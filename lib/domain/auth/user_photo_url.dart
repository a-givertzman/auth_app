import 'package:auth_app/domain/core/error/failure.dart';
import 'package:auth_app/domain/core/entities/value_object.dart';
import 'package:auth_app/domain/core/entities/value_validators.dart';
import 'package:dartz/dartz.dart';


class UserPhotoURL extends ValueObject<String>{
  @override
  final Either<Failure, String> value;

  factory UserPhotoURL(String input) {
    return UserPhotoURL._(
      validdateUserName(input),
    );
  }

  const UserPhotoURL._(this.value);
}