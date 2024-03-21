import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';

part 'cart_state.dart';

enum StepType { cart, address, payment }

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<ChangeStepperEvent>(_changeStepper);
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
