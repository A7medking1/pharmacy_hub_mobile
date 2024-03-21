part of 'cart_bloc.dart';

class CartState extends Equatable {
   int selectedStepper;

   CartState({
    this.selectedStepper = 0,
  });

  CartState copyWith({
    int? selectedStepper,
  }) {
    return CartState(
      selectedStepper: selectedStepper ?? this.selectedStepper,
    );
  }

  @override
  List<Object> get props => [selectedStepper];
}
