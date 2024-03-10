
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/error/error_message_model.dart';

class ServerException extends Equatable implements Exception {
  final ErrorMessageModel? errorMessageModel;

  const ServerException([this.errorMessageModel]);

  @override
  List<Object?> get props => [errorMessageModel];


}

class FetchDataException extends ServerException {
  const FetchDataException([super.errorMessageModel]);
}

class BadRequestException extends ServerException {
  const BadRequestException([super.errorMessageModel]);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([super.errorMessageModel]);
}

class NotFoundException extends ServerException {
  const NotFoundException([super.errorMessageModel]);
}

class ConflictException extends ServerException {
  const ConflictException([super.errorMessageModel]);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([super.errorMessageModel]);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([super.errorMessageModel]);
}

class CacheException implements Exception {}
