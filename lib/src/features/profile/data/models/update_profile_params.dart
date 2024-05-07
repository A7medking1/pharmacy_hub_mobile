import 'package:equatable/equatable.dart';

class UpdateProfileParams extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String street;
  final String city;

  const UpdateProfileParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.street,
    required this.city,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "street": street,
        "city": city,
      };

  @override
  List<Object?> get props => [name, email, phoneNumber, street, city];
}
