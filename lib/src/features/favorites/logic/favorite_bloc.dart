import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/features/favorites/data/local_repository/local_repository.dart';
import 'package:pharmacy_hub/src/features/favorites/data/model/favorites_model.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<GetFavoritesItemsEvent>(_getFavorites);
    on<AddProductToFavoriteEvent>(_addProductToFavorites);
    on<RemoveProductFromFavorite>(_removeProductFromFavorite);
  }

  final FavoriteLocalRepository _repository = FavoriteLocalRepositoryImpl();
  final GlobalKey<AnimatedGridState> gridKey = GlobalKey<AnimatedGridState>();

  AnimatedGridState? get animatedGrid => gridKey.currentState;

  Map<int, bool> favorites = {};

  FutureOr<void> _getFavorites(
      GetFavoritesItemsEvent event, Emitter<FavoriteState> emit) async {
    favorites.clear();
    final List<FavoriteItem> data = await _repository.getFavorites();
    for (var element in data) {
      favorites.addAll({element.id: true});
    }
    log(favorites.toString());
    emit(state.copyWith(favoritesItems: data, reqState: ReqState.success));
  }

  FutureOr<void> _addProductToFavorites(
      AddProductToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(addFavReqState: ReqState.loading));
    if (!await _repository.isItemAdded(event.item.id)) {
      await _repository.addFavorite(event.item);
      favorites.addAll({event.item.id: true});
      add(GetFavoritesItemsEvent());
    }
  }

  FutureOr<void> _removeProductFromFavorite(
      RemoveProductFromFavorite event, Emitter<FavoriteState> emit) async {
    if (favorites.containsKey(event.productId)) {
      favorites.remove(event.productId);
    }
    await _repository.removeFavoriteItem(event.productId);
    add(GetFavoritesItemsEvent());
  }
}