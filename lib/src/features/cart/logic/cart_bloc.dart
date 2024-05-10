import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/core/location_services.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/cart/data/repository/cart_repository.dart';
import 'package:pharmacy_hub/src/features/cart/data/repository/cart_repository_local.dart';
import 'package:pharmacy_hub/src/features/order/data/models/address_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._cartRepository) : super(CartState()) {
    on<ChangeStepperEvent>(_changeStepper);
    on<GetCurrentAddressEvent>(_getCurrentAddressEvent);
    on<AddToCartEvent>(_addToCartEvent);
    on<GetCartDataEvent>(_getCartEvent);
    on<AddProductToCartLocal>(_addProductToCartLocal);
    on<RemoveCartItemLocalEvent>(_removeCartItemLocal);
    on<UpdateCartItemLocalEvent>(_updateCartItemLocal);
    on<ClearAllCartLocalEvent>(_clearAllCartLocal);
    on<GetCartItemsFromLocal>(_getCartItemsFromLocal);
    on<IncreaseItemQuantityEvent>(_increaseQuantity);
    on<DecreaseItemQuantityEvent>(_decreaseQuantity);
    on<ClearCartItemsEvent>(_clearCartItems);
  }

  final CartRepository _cartRepository;
  final CartLocalRepository _localRepository = CartLocalRepositoryImpl();

  FutureOr<void> _getCartEvent(
      GetCartDataEvent event, Emitter<CartState> emit) async {
    final UserModel user = sl<AppPreferences>().getUser();

    if (event.isLoading) {
      emit(state.copyWith(getCartReqState: ReqState.loading));
    }
    try {
      final CartModel result = await _cartRepository.getCart(
        cartId: user.id,
      );

      await _localRepository.removeAllCart();
      await _localRepository.addAllCart(result.items);
      log("from Api ${result.toString()}");
      add(GetCartItemsFromLocal());
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getCartReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _getCartItemsFromLocal(
      GetCartItemsFromLocal event, Emitter<CartState> emit) async {
    final UserModel user = sl<AppPreferences>().getUser();

    final List<CartItem> result = await getCartLocal();

    double totalPrice = await _localRepository.getTotalPrice();

    emit(
      state.copyWith(
        cart: CartModel(id: user.id, items: result),
        getCartReqState: result.isEmpty ? ReqState.empty : ReqState.success,
        addToCartReqState: result.isEmpty ? ReqState.empty : ReqState.success,
        totalPrice: totalPrice,
      ),
    );
  }

  FutureOr<void> _addToCartEvent(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(addToCartReqState: ReqState.loading));

    final UserModel user = sl<AppPreferences>().getUser();

    final CartModel cartModel = CartModel(id: user.id, items: event.cartModel);

    try {
      await _cartRepository.addToCart(
        cartModel: cartModel,
      );
      add(GetCartItemsFromLocal());
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          addToCartReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _addProductToCartLocal(
      AddProductToCartLocal event, Emitter<CartState> emit) async {
    if (!await isItemAddedInLocalCart(event.cartItem.id)) {
      await _localRepository.addCart(event.cartItem);
      showToast('Item added to cart');
      List<CartItem> carts = await getCartLocal();
      print('here here ');
      add(AddToCartEvent(carts));
    } else {
      print('here here ');

      showToast('Item already added to cart');
    }
  }

  Future<List<CartItem>> getCartLocal() async {
    final List<CartItem> result = await _localRepository.getCarts();
    log(result.toString());

    return result;
  }

  Future<bool> isItemAddedInLocalCart(int id) async {
    return await _localRepository.isItemAdded(id);
  }

  FutureOr<void> _removeCartItemLocal(
      RemoveCartItemLocalEvent event, Emitter<CartState> emit) async {
    final UserModel user = sl<AppPreferences>().getUser();

    await _localRepository.removeCartItem(event.cartItemId);
    List<CartItem> carts = await getCartLocal();

    emit(
      state.copyWith(
        cart: CartModel(id: user.id, items: carts),
        addToCartReqState: carts.isEmpty ? ReqState.empty : ReqState.success,
        getCartReqState: carts.isEmpty ? ReqState.empty : ReqState.success,
      ),
    );
    add(AddToCartEvent(carts));
  }

  FutureOr<void> _updateCartItemLocal(
      UpdateCartItemLocalEvent event, Emitter<CartState> emit) async {
    final UserModel user = sl<AppPreferences>().getUser();

    await _localRepository.updateCartItem(event.cartItem);

    List<CartItem> carts = await getCartLocal();

    double totalPrice = await _localRepository.getTotalPrice();

    log("in _updateCartItemLocal ${carts.toString()}");

    add(AddToCartEvent(carts));

    emit(
      state.copyWith(
        cart: CartModel(id: user.id, items: carts),
        totalPrice: totalPrice,
      ),
    );
  }

  FutureOr<void> _clearAllCartLocal(
      ClearAllCartLocalEvent event, Emitter<CartState> emit) async {
    await _localRepository.removeAllCart();
    await getCartLocal();
  }

  FutureOr<void> _increaseQuantity(
      IncreaseItemQuantityEvent event, Emitter<CartState> emit) async {
    CartItem cartItem =
        event.cartItem.copyWith(quantity: event.cartItem.quantity + 1);

    log(cartItem.toString());

    add(UpdateCartItemLocalEvent(cartItem));
  }

  FutureOr<void> _decreaseQuantity(
      DecreaseItemQuantityEvent event, Emitter<CartState> emit) async {
    if (event.cartItem.quantity == 1) {
      return;
    }
    CartItem cartItem =
        event.cartItem.copyWith(quantity: event.cartItem.quantity - 1);
    add(UpdateCartItemLocalEvent(cartItem));
  }

  FutureOr<void> _clearCartItems(
      ClearCartItemsEvent event, Emitter<CartState> emit) async {
    final String cartId = sl<AppPreferences>().getUser().id;
    await _cartRepository.deleteCart(cartId: cartId);
  }

  ///  section location
  CameraPosition? cameraPosition;

  Completer<GoogleMapController> mapController = Completer();
  LatLng mapCenter = const LatLng(0.0, 0.0);

  void onCameraMove(CameraPosition position) {
    mapCenter = position.target;
    log(mapCenter.toString());
  }

  Future<void> initCameraPositionMap() async {
    final target = await getCurrentLatLong();
    cameraPosition = CameraPosition(
      target: target,
      zoom: 17,
    );
  }

  Future<LatLng> getCurrentLatLong() async {
    return await LocationServices.getCurrentLatLong();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);

    await initCameraPositionMap();

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition!,
      ),
    );
  }

  FutureOr<void> _getCurrentAddressEvent(
      GetCurrentAddressEvent event, Emitter<CartState> emit) async {
    final AddressModel currentAddress =
        await LocationServices.getAddressFromLatLang(mapCenter);

    log("currentAddress $mapCenter");

    emit(state.copyWith(
      currentAddress: '${currentAddress.street} ${currentAddress.city}',
      addressModel: currentAddress,
    ));
  }

  FutureOr<void> _changeStepper(
      ChangeStepperEvent event, Emitter<CartState> emit) async {
    // print(state.selectedStepper);
    if (state.selectedStepper > 2) {
      return;
    }
    emit(state.copyWith(selectedStepper: state.selectedStepper + 1));
  }

  @override
  void onEvent(CartEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
    log("current event => $event");
  }
}

void showToast(String s) {
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.primary,
    textColor: Colors.white,
  );
}
