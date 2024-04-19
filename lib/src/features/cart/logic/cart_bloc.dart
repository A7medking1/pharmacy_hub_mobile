import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy_hub/src/core/location_services.dart';

part 'cart_event.dart';

part 'cart_state.dart';

enum StepType { cart, address, payment }

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<ChangeStepperEvent>(_changeStepper);
    on<GetCurrentAddressEvent>(_getCurrentAddressEvent);
  }

  CameraPosition? cameraPosition;

  Completer<GoogleMapController> mapController = Completer();
  LatLng mapCenter = const LatLng(0.0, 0.0);

  void onCameraMove(CameraPosition position) {
    mapCenter = position.target;
    print(mapCenter);
  }

  Future<void> initCameraPositionMap() async {
    final target = await getCurrentLatLong();
    cameraPosition = CameraPosition(
      target: target,
      zoom: 17,
    );
    //add(GetCurrentAddressEvent());
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
    final String currentAddress =
        await LocationServices.getAddressFromLatLang(mapCenter);

    print("currentAddress $mapCenter");

    emit(state.copyWith(currentAddress: currentAddress));
  }

  FutureOr<void> _changeStepper(
      ChangeStepperEvent event, Emitter<CartState> emit) async {
    print(state.selectedStepper);
    if (state.selectedStepper > 2) {
      return;
    }
    emit(state.copyWith(selectedStepper: state.selectedStepper + 1));
  }
}
