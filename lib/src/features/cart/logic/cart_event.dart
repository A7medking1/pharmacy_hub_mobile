part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ChangeStepperEvent extends CartEvent {}

class GetCurrentAddressEvent extends CartEvent {}

class GetCartDataEvent extends CartEvent {
  final bool isLoading;

  const GetCartDataEvent({this.isLoading = true});
}

class AddToCartEvent extends CartEvent {
  final List<CartItem> cartModel;

  const AddToCartEvent(this.cartModel);
}

class AddProductToCartLocal extends CartEvent {
  final CartItem cartItem;

  const AddProductToCartLocal(this.cartItem);
}

class RemoveCartItemLocalEvent extends CartEvent {
  final int cartItemId;

  const RemoveCartItemLocalEvent(this.cartItemId);
}

class UpdateCartItemLocalEvent extends CartEvent {
  final CartItem cartItem;

  const UpdateCartItemLocalEvent(this.cartItem);
}

class ClearAllCartLocalEvent extends CartEvent {}

class GetCartItemsFromLocal extends CartEvent {}

class IncreaseItemQuantityEvent extends CartEvent {
  final CartItem cartItem;

  const IncreaseItemQuantityEvent(this.cartItem);
}

class DecreaseItemQuantityEvent extends CartEvent {
  final CartItem cartItem;

  const DecreaseItemQuantityEvent(this.cartItem);
}
