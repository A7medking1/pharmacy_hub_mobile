part of 'add_prescription_bloc.dart';

class AddPrescriptionState extends Equatable {
  final String errorMessage;

  final ReqState uploadReqState;

  const AddPrescriptionState({
    this.errorMessage = '',
    this.uploadReqState = ReqState.empty,
  });


  AddPrescriptionState copyWith({
    String? errorMessage,
    ReqState? uploadReqState,
  }) {
    return AddPrescriptionState(
      errorMessage: errorMessage ?? this.errorMessage,
      uploadReqState: uploadReqState ?? this.uploadReqState,
    );
  }

  @override
  List<Object> get props => [errorMessage, uploadReqState];
}
