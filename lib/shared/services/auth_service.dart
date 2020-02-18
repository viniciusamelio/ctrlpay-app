import 'package:ctrl_money/shared/services/istorage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage implements IStorageService {
  FlutterSecureStorage _storage;
  AuthStorage(){
    _storage = FlutterSecureStorage();
  }

  Future save({String key, dynamic value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  Future clear({String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  Future read({String key}) async {
    try {
      dynamic value = await _storage.read(key: key);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  Future clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
