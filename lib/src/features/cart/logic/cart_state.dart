part of 'cart_bloc.dart';

class CartState extends Equatable {
  final int selectedStepper;

  String currentAddress;
  final AddressModel? addressModel;

  /// cart

  final CartModel cart;
  final String errorMessage;
  final ReqState getCartReqState;
  final ReqState deleteCartReqState;
  final ReqState addToCartReqState;
  final int id;

  final double totalPrice;

  CartState({
    this.selectedStepper = 0,
    this.currentAddress = 'none',
    this.cart = const CartModel(id: '', items: []),
    this.errorMessage = '',
    this.getCartReqState = ReqState.loading,
    this.deleteCartReqState = ReqState.empty,
    this.addToCartReqState = ReqState.empty,
    this.id = 0,
    this.totalPrice = 0.0,
    this.addressModel,
  });

  CartState copyWith({
    int? selectedStepper,
    String? currentAddress,

    /// cart
    CartModel? cart,
    String? errorMessage,
    ReqState? getCartReqState,
    ReqState? deleteCartReqState,
    ReqState? addToCartReqState,
    int? id,
    double? totalPrice,

    /// address
    AddressModel? addressModel,
  }) {
    return CartState(
      selectedStepper: selectedStepper ?? this.selectedStepper,
      currentAddress: currentAddress ?? this.currentAddress,
      cart: cart ?? this.cart,
      errorMessage: errorMessage ?? this.errorMessage,
      getCartReqState: getCartReqState ?? this.getCartReqState,
      deleteCartReqState: deleteCartReqState ?? this.deleteCartReqState,
      addToCartReqState: addToCartReqState ?? this.addToCartReqState,
      id: id ?? this.id,
      totalPrice: totalPrice ?? this.totalPrice,
      addressModel: addressModel ?? this.addressModel,
    );
  }

  @override
  List<Object?> get props => [
        selectedStepper,
        currentAddress,
        cart,
        errorMessage,
        getCartReqState,
        deleteCartReqState,
        addToCartReqState,
        id,
        totalPrice,
        addressModel,
      ];
}
