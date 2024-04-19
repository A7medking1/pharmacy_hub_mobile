part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetMedicineEvent extends HomeEvent {}

class GetCategoriesEvent extends HomeEvent {}

class GetVitaminsEvent extends HomeEvent {}

class GetEquipmentsEvent extends HomeEvent {}

class GetCaresEvent extends HomeEvent {}

class GetMedicineSimilarEvent extends HomeEvent {
  final SimilarProductParams params;

  const GetMedicineSimilarEvent(this.params);
}

class GetMedicineAlternativeEvent extends HomeEvent {
  final AlternativeProductParams params;

  const GetMedicineAlternativeEvent(this.params);
}

class RefreshHomeEvent extends HomeEvent {}
