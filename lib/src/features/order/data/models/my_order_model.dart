import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/features/order/data/models/address_model.dart';

class MyOrdersModel extends Equatable {
  final int id;
  final String buyerEmail;
  final DateTime orderDate;
  final String status;
  final AddressModel shippingAddress;
  final String deliveryMethod;
  final int deliveryMethodCost;
  final List<Item> items;
  final num subtotal;
  final num total;
  final String paymentIntentId;

  const MyOrdersModel({
    required this.id,
    required this.buyerEmail,
    required this.orderDate,
    required this.status,
    required this.shippingAddress,
    required this.deliveryMethod,
    required this.deliveryMethodCost,
    required this.items,
    required this.subtotal,
    required this.total,
    required this.paymentIntentId,
  });

  factory MyOrdersModel.fromMap(Map<String, dynamic> json) => MyOrdersModel(
        id: json["id"],
        buyerEmail: json['buyerEmail'],
        orderDate: DateTime.parse(json["orderDate"]),
        status: json['status'],
        shippingAddress: AddressModel.fromMap(json["shippingAddress"]),
        deliveryMethod: json["deliveryMethod"],
        deliveryMethodCost: json["deliveryMethodCost"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        subtotal: json["subtotal"],
        total: json["total"],
        paymentIntentId: json["paymentIntentId"],
      );

  @override
  List<Object> get props => [
        id,
        buyerEmail,
        orderDate,
        status,
        shippingAddress,
        deliveryMethod,
        deliveryMethodCost,
        items,
        subtotal,
        total,
        paymentIntentId,
      ];
}

class Item {
  final int productId;
  final String productName;
  final int price;
  final String pictureUrl;
  final int quantity;

  Item({
    required this.productId,
    required this.productName,
    required this.price,
    required this.pictureUrl,
    required this.quantity,
  });

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        productId: json["productId"],
        productName: json["productName"],
        price: json["price"],
        pictureUrl: json["pictureUrl"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productName": productName,
        "price": price,
        "pictureUrl": pictureUrl,
        "quantity": quantity,
      };
}

/*class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}*/
