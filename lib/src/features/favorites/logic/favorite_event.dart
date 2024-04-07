part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddProductToFavoriteEvent extends FavoriteEvent {
  final FavoriteItem item;

  const AddProductToFavoriteEvent(this.item);
}

class RemoveProductFromFavorite extends FavoriteEvent {
  final int productId;

  const RemoveProductFromFavorite(this.productId);
}

class RemoveAllProductFromFavorites extends FavoriteEvent {}

class GetFavoritesItemsEvent extends FavoriteEvent {}
