import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

part 'cart_model.g.dart';



class CartModel extends Equatable {
  final String id;
  final List<CartItem> items;
  final num? deliveryMethodId;
  final num? shippingPrice;
  final String? paymentIntetId;
  final String? clientSecret;

  const CartModel({
    required this.id,
    required this.items,
    this.clientSecret,
    this.deliveryMethodId,
    this.paymentIntetId,
    this.shippingPrice,
  });

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        clientSecret: json["clientSecret"] ?? '',
        deliveryMethodId: json["deliveryMethodId"] ?? 0,
        paymentIntetId: json["paymentIntetId"] ?? '',
        shippingPrice: json["shippingPrice"],
        items:
            List<CartItem>.from(json["items"].map((x) => CartItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "clientSecret": clientSecret ?? '',
        "deliveryMethodId": deliveryMethodId ?? 0,
        "paymentIntetId": paymentIntetId ?? '',
        "shippingPrice": shippingPrice ?? 0,
      };

  CartModel copyWith({
    String? id,
    List<CartItem>? items,
    num? deliveryMethodId,
    num? shippingPrice,
    String? paymentIntetId,
    String? clientSecret,
  }) {
    return CartModel(
      id: id ?? this.id,
      items: items ?? this.items,
      clientSecret: clientSecret ?? this.clientSecret,
      deliveryMethodId: deliveryMethodId ?? this.deliveryMethodId,
      paymentIntetId: paymentIntetId ?? this.paymentIntetId,
      shippingPrice: shippingPrice ?? this.shippingPrice,
    );
  }

  @override
  List<Object> get props => [id, items];
}

@HiveType(typeId: 2)
class CartItem extends Equatable {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String pictureUrl;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final num price;
  @HiveField(6)
  final int quantity;

  const CartItem({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.category,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        name: json["name"],
        pictureUrl: json["pictureUrl"],
        category: json["category"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "pictureUrl": pictureUrl,
        "category": category,
        "price": price,
        "quantity": quantity,
      };

  factory CartItem.fromEntity(CartItem model) {
    return CartItem(
      id: model.id,
      name: model.name,
      pictureUrl: model.pictureUrl,
      category: model.category,
      price: model.price,
      quantity: model.quantity,
    );
  }

  factory CartItem.fromProduct(ProductModel model) {
    return CartItem(
      id: model.id,
      name: model.name,
      pictureUrl: model.pictureUrl,
      category: model.category,
      price: model.price,
      quantity: 1,
    );
  }

  CartItem copyWith({
    int? id,
    String? name,
    String? pictureUrl,
    String? category,
    num? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        pictureUrl,
        category,
        price,
        quantity,
      ];
}
