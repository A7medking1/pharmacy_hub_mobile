import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums.dart';
import '../../../../core/error/exceptions.dart';
import '../../data/models/product_model.dart';
import '../../data/repository/repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._homeRepository) : super(const SearchState()) {
    on<SearchForEvent>(_searchFor);
  }

  final HomeRepository _homeRepository;
  final TextEditingController searchController = TextEditingController();

  int page = 1;
  bool hasReachedMax = false;
  bool notFound = false;
  String? lastSearch;

  FutureOr<void> _searchFor(
      SearchForEvent event, Emitter<SearchState> emit) async {
    hasReachedMax = false;
    notFound = false;

    if(lastSearch != null) lastSearch = event.text;

    if (hasReachedMax) {
      return;
    }

    if(event.getMore) page++; else page = 1;

    if (page == 1) emit(state.copyWith(getSearchReqState: ReqState.loading));

    try {
      final List<ProductModel> searchResult = await _homeRepository.searchFor(page: page.toString(), text: event.text ?? lastSearch ?? "");


      if (searchResult.isEmpty || searchResult.length < 10) hasReachedMax = true;
      if(searchResult.isEmpty && page == 1) notFound = true;

      if(!event.getMore){
        emit(
          state.copyWith(
            medicine: searchResult,
            getSearchReqState: ReqState.success,
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          medicine: [...state.medicine, ...searchResult],
          getSearchReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getSearchReqState: ReqState.error,
        ),
      );
    }
  }
}
