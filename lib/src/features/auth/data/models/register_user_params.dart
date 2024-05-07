import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String repeatPassword;
  final String city;

  final String street;

  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.repeatPassword,
    required this.city,
    required this.street,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "repeatPassword": repeatPassword,
        "city": city,
        "street": street
      };


  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        password,
        repeatPassword,
        city,
        street,
      ];
}
