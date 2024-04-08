part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String errorMessage;

  final List<ProductModel> medicine;
  final ReqState getSearchReqState;

  final int fuckenBuildStateparam;

  const SearchState({
    this.errorMessage = '',
    this.getSearchReqState = ReqState.empty,
    this.medicine = const [],
    this.fuckenBuildStateparam = 0,
  });

  SearchState copyWith({
    String? errorMessage,
    ReqState? getSearchReqState,
    List<ProductModel>? medicine,
    int? fuckenBuildStateparam,
  }) {
    return SearchState(
      errorMessage: errorMessage ?? this.errorMessage,
      getSearchReqState: getSearchReqState ?? this.getSearchReqState,
      medicine: medicine ?? this.medicine,
      fuckenBuildStateparam:
          fuckenBuildStateparam ?? this.fuckenBuildStateparam,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        medicine,
        getSearchReqState,
        fuckenBuildStateparam,
      ];
}
