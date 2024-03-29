part of 'cart_bloc.dart';

class CartState extends Equatable {
  int selectedStepper = 0;

  String currentAddress;

  CartState({
    this.selectedStepper = 0,
    this.currentAddress = 'none',
  });

  CartState copyWith({int? selectedStepper, String? currentAddress}) {
    return CartState(
      selectedStepper: selectedStepper ?? this.selectedStepper,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }

  @override
  List<Object> get props => [selectedStepper, currentAddress];
}
