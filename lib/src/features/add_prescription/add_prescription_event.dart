part of 'add_prescription_bloc.dart';

class AddPrescriptionEvent extends Equatable {
  const AddPrescriptionEvent();

  @override
  List<Object> get props => [];
}

class AddImageEvent extends AddPrescriptionEvent {
  final BuildContext context;

  const AddImageEvent(this.context);
}
