import 'package:equatable/equatable.dart';

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
