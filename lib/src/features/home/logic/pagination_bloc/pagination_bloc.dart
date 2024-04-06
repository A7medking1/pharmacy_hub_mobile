import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:pharmacy_hub/src/features/home/data/repository/repository.dart';

part 'pagination_event.dart';

part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc(this._repository) : super(const PaginationState()) {
    on<GetProductsEvent>(_getMoreProductEvent);
  }

  final HomeRepository _repository;

  int page = 1;
  bool isPaginated = false;
  bool hasReachedMax = false;

  FutureOr<void> _getMoreProductEvent(
      GetProductsEvent event, Emitter<PaginationState> emit) async {
    if (hasReachedMax) {
      return;
    }
    if (page == 1) {
      emit(state.copyWith(getMedicineReqState: ReqState.loading));
    }

    isPaginated = page == 1 ? false : true;

    try {
      final List<ProductModel> result = await _repository.getMoreProducts(
        page: (page++).toString(),
        categoryId: event.categoryId,
      );

      if (result.isEmpty || result.length < 10) {
        hasReachedMax = true;
        emit(state.copyWith(errorMessage: 'No More Data'));
      }
      isPaginated = false;

      emit(
        state.copyWith(
          medicine: [...state.medicine, ...result],
          getMedicineReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getMedicineReqState: ReqState.error,
        ),
      );
    }
  }
}
