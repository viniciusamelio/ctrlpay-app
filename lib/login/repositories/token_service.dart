import 'package:ctrl_money/shared/services/istorage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService implements IStorageService {
  final _storage = FlutterSecureStorage();

  Future<void> save({String key, dynamic value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clear({String key, dynamic value}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> read({String key, dynamic value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }
}
