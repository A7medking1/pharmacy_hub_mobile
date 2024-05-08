import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/enums.dart';
import '../../../../core/error/exceptions.dart';
import '../../data/models/product_model.dart';
import '../../data/repository/repository.dart';

part 'search_event.dart';

part 'search_state.dart';

const _duration = Duration(milliseconds: 400);

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._homeRepository) : super(const SearchState()) {
    on<SearchForEvent>(
      _searchFor,
      transformer: (eventStream, mapper) =>
          (eventStream).debounceTime(_duration).flatMap(mapper),
    );
    on<FetchMoreDataEvent>(_fetchMoreData);
  }

  final HomeRepository _homeRepository;
  final TextEditingController searchController = TextEditingController();

  int page = 1;
  bool hasReachedMax = false;

  FutureOr<void> _searchFor(
      SearchForEvent event, Emitter<SearchState> emit) async {
    page = 1;
    emit(
      state.copyWith(getSearchReqState: ReqState.loading),
    );

    if (event.text.isEmpty) {
      emit(
        state.copyWith(
          medicine: const [],
          getSearchReqState: ReqState.empty,
        ),
      );
      return;
    }
    try {
      final List<ProductModel> data = await _homeRepository.search(
        page: '1',
        text: event.text,
      );
      if (data.isEmpty) {
        emit(
          state.copyWith(
            errorMessage: event.text,
            getSearchReqState: ReqState.error,
          ),
        );
        return;
      }
      hasReachedMax = data.length < 10;
      emit(
        state.copyWith(
          medicine: data,
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

  FutureOr<void> _fetchMoreData(
      FetchMoreDataEvent event, Emitter<SearchState> emit) async {
    if (hasReachedMax) {
      return;
    }

    try {
      final List<ProductModel> data = await _homeRepository.search(
        page: (++page).toString(),
        text: event.text,
      );
      if (data.isEmpty || data.length < 10) {
        hasReachedMax = true;
        emit(
          state.copyWith(
            errorMessage: 'No More Data',
            // add this param to build screen and remove the singleshimmer loading ,, fucken equatable not build it because fucken data not change and the state have same data
            fuckenBuildStateparam: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }
      emit(
        state.copyWith(
          medicine: [...state.medicine, ...data],
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
