// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;

// Project imports:
import 'package:flutter_example/domain/auth/user.dart';
import 'package:flutter_example/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase.User {
  User toDomain() {
    return User(id: UniqueId.fromUniqueString(uid));
  }
}
