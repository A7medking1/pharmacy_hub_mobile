part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String errorMessage;

  final List<ProductModel> medicine;
  final List<CategoryModel> categories;
  final List<ProductModel> vitamins;
  final List<ProductModel> equipments;
  final List<ProductModel> cares;
  final List<ProductModel> similarMedicine;
  final List<ProductModel> alternativeMedicine;
  final ReqState getMedicineReqState;
  final ReqState getCategoriesReqState;
  final ReqState getVitaminsReqState;
  final ReqState getEquipmentsReqState;
  final ReqState getCaresReqState;
  final ReqState getSimilarMedicineReqState;
  final ReqState getAlternativeMedicineReqState;

  const HomeState({
    this.errorMessage = '',
    this.getMedicineReqState = ReqState.loading,
    this.medicine = const [],
    this.categories = const [],
    this.getCategoriesReqState = ReqState.loading,
    this.vitamins = const [],
    this.getVitaminsReqState = ReqState.loading,
    this.equipments = const [],
    this.getEquipmentsReqState = ReqState.loading,
    this.cares = const [],
    this.getCaresReqState = ReqState.loading,
    this.alternativeMedicine = const [],
    this.similarMedicine = const [],
    this.getAlternativeMedicineReqState = ReqState.empty,
    this.getSimilarMedicineReqState = ReqState.empty,
  });

  HomeState copyWith({
    String? errorMessage,
    ReqState? getMedicineReqState,
    List<ProductModel>? medicine,
    List<CategoryModel>? categories,
    List<ProductModel>? vitamins,
    List<ProductModel>? equipments,
    List<ProductModel>? cares,
    List<ProductModel>? alternativeMedicine,
    List<ProductModel>? similarMedicine,
    ReqState? getCategoriesReqState,
    ReqState? getVitaminsReqState,
    ReqState? getEquipmentsReqState,
    ReqState? getCaresReqState,
    ReqState? getAlternativeMedicineReqState,
    ReqState? getSimilarMedicineReqState,
  }) {
    return HomeState(
      errorMessage: errorMessage ?? this.errorMessage,
      getMedicineReqState: getMedicineReqState ?? this.getMedicineReqState,
      medicine: medicine ?? this.medicine,
      categories: categories ?? this.categories,
      getCategoriesReqState:
          getCategoriesReqState ?? this.getCategoriesReqState,
      vitamins: vitamins ?? this.vitamins,
      getVitaminsReqState: getVitaminsReqState ?? this.getVitaminsReqState,
      equipments: equipments ?? this.equipments,
      getEquipmentsReqState:
          getEquipmentsReqState ?? this.getEquipmentsReqState,
      cares: cares ?? this.cares,
      getCaresReqState: getCaresReqState ?? this.getCaresReqState,
      similarMedicine: similarMedicine ?? this.similarMedicine,
      alternativeMedicine: alternativeMedicine ?? this.alternativeMedicine,
      getAlternativeMedicineReqState:
          getAlternativeMedicineReqState ?? this.getAlternativeMedicineReqState,
      getSimilarMedicineReqState:
          getSimilarMedicineReqState ?? this.getSimilarMedicineReqState,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        medicine,
        categories,
        vitamins,
        equipments,
        cares,
        similarMedicine,
        alternativeMedicine,
        getMedicineReqState,
        getCategoriesReqState,
        getVitaminsReqState,
        getEquipmentsReqState,
        getCaresReqState,
        getSimilarMedicineReqState,
        getAlternativeMedicineReqState,
      ];
}
