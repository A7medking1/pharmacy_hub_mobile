part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final List<FavoriteItem> favoritesItems;
  final ReqState reqState;
  final ReqState addFavReqState;

  const FavoriteState({
    this.favoritesItems = const [],
    this.reqState = ReqState.loading,
    this.addFavReqState = ReqState.empty,
  });

  FavoriteState copyWith({
    List<FavoriteItem>? favoritesItems,
    ReqState? reqState,
    ReqState? addFavReqState,
  }) {
    return FavoriteState(
      favoritesItems: favoritesItems ?? this.favoritesItems,
      reqState: reqState ?? this.reqState,
      addFavReqState: addFavReqState ?? this.addFavReqState,
    );
  }

  @override
  List<Object> get props => [
        favoritesItems,
        reqState,
        addFavReqState,
      ];
}
