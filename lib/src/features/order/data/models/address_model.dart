/*
{
"street": "string",
"city": "string"
}*/
import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String street;
  final String city;

  const AddressModel({
    required this.street,
    required this.city,
  });

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        city: json["city"],
      );

  Map<String, dynamic> toMap() => {
        "street": street,
        "city": city,
      };

  @override
  List<Object> get props => [street, city];
}
