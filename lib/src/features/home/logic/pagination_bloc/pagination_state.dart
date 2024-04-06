part of 'pagination_bloc.dart';

class PaginationState extends Equatable {
  final String errorMessage;

  final List<ProductModel> medicine;
  final ReqState getMedicineReqState;

  const PaginationState({
    this.errorMessage = '',
    this.getMedicineReqState = ReqState.loading,
    this.medicine = const [],
  });

  PaginationState copyWith({
    String? errorMessage,
    ReqState? getMedicineReqState,
    List<ProductModel>? medicine,
  }) {
    return PaginationState(
      errorMessage: errorMessage ?? this.errorMessage,
      getMedicineReqState: getMedicineReqState ?? this.getMedicineReqState,
      medicine: medicine ?? this.medicine,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        medicine,
        getMedicineReqState,
      ];
}
