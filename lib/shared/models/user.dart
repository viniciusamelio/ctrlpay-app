import 'package:ctrl_money/shared/models/user_dto.dart';

class User {
  static User _instance;
  factory User._() {
    _instance ??= User._internalConstructor(UserDto());
    return _instance;
  }

  static User get instance {
    return _instance ??= User._();
  }

  User._internalConstructor(this.data);

  static void dispose() {
  _instance = null;
}

  UserDto data;
}
