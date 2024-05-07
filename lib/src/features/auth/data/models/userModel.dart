import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String phoneNumber;
  final String token;
  final String street;
  final String city;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.token,
    required this.street,
    required this.city,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        token: json["token"],
        street: json["street"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "token": token,
        "street": street,
        "city": city,
      };

  @override
  List<Object> get props => [
        id,
        name,
        email,
        userName,
        phoneNumber,
        token,
        street,
        city,
      ];

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, userName: $userName, phoneNumber: $phoneNumber, token: $token, street: $street, city: $city)';
}
