import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String phoneNumber;
  final String token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "token": token,
      };

  @override
  List<Object> get props => [
        id,
        name,
        email,
        userName,
        phoneNumber,
        token,
      ];

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, userName: $userName, phoneNumber: $phoneNumber, token: $token)';
}
