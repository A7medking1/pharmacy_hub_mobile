import 'package:equatable/equatable.dart';

class DeliveryMethodsModel extends Equatable {
  final String name;
  final String description;
  final num cost;
  final String deliveryTime;
  final int id;

  const DeliveryMethodsModel({
    required this.name,
    required this.description,
    required this.cost,
    required this.deliveryTime,
    required this.id,
  });

  factory DeliveryMethodsModel.fromMap(Map<String, dynamic> json) =>
      DeliveryMethodsModel(
        name: json["name"],
        description: json["description"],
        cost: json["cost"],
        deliveryTime: json["deliveryTime"],
        id: json["id"],
      );

  @override
  List<Object> get props => [name, description, cost, deliveryTime, id];
}
