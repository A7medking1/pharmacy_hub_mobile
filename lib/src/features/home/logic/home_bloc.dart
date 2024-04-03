import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/features/home/data/models/category_model.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:pharmacy_hub/src/features/home/data/repository/repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._homeRepository) : super(const HomeState()) {
    on<GetMedicineEvent>(_getMedicine);
    on<GetCategoriesEvent>(_getCategories);
    on<GetVitaminsEvent>(_getVitamins);
    on<GetEquipmentsEvent>(_getEquipment);
    on<GetCaresEvent>(_getCares);
  }

  final HomeRepository _homeRepository;

  FutureOr<void> _getMedicine(
      GetMedicineEvent event, Emitter<HomeState> emit) async {
    try {
      final List<ProductModel> medicine =
          await _homeRepository.getMedicine(page: 1);

      emit(
        state.copyWith(
          medicine: medicine,
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

  FutureOr<void> _getCategories(
      GetCategoriesEvent event, Emitter<HomeState> emit) async {
    try {
      final List<CategoryModel> medicine =
          await _homeRepository.getCategories();

      emit(
        state.copyWith(
          categories: medicine,
          getCategoriesReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getCategoriesReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _getVitamins(
      GetVitaminsEvent event, Emitter<HomeState> emit) async {
    try {
      final List<ProductModel> vitamins =
          await _homeRepository.getVitamins(page: 1);

      emit(
        state.copyWith(
          vitamins: vitamins,
          getVitaminsReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getVitaminsReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _getEquipment(
      GetEquipmentsEvent event, Emitter<HomeState> emit) async {
    try {
      final List<ProductModel> equipment =
          await _homeRepository.getEquipments(page: 1);

      emit(
        state.copyWith(
          equipments: equipment,
          getEquipmentsReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getEquipmentsReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _getCares(GetCaresEvent event, Emitter<HomeState> emit) async {
    try {
      final List<ProductModel> cares = await _homeRepository.getCares(page: 1);

      emit(
        state.copyWith(
          cares: cares,
          getCaresReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          getCaresReqState: ReqState.error,
        ),
      );
    }
  }
}
