part of 'search_bloc.dart';

@immutable
class SearchState extends Equatable {
  final String errorMessage;

  final List<ProductModel> medicine;
  final ReqState getSearchReqState;

  const SearchState({
    this.errorMessage = '',
    this.getSearchReqState = ReqState.nothing,
    this.medicine = const [],
  });

  SearchState copyWith({
    String? errorMessage,
    ReqState? getSearchReqState,
    List<ProductModel>? medicine,
  }) {
    return SearchState(
      errorMessage: errorMessage ?? this.errorMessage,
      getSearchReqState: getSearchReqState ?? this.getSearchReqState,
      medicine: medicine ?? this.medicine,
    );
  }

  @override
  List<Object> get props => [
    errorMessage,
    medicine,
    getSearchReqState,
  ];
}

