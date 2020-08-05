
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._privateConstructor(){
    if(_storage == null) {
      _storage = new FlutterSecureStorage();
    }
  }
  static final SecureStorage instance = SecureStorage._privateConstructor();

  static FlutterSecureStorage _storage;

  save(String key, String value) async{
    await _storage.write(key: key, value: value);
  }

  Future<String> read(String key) async{
    return await _storage.read(key: key);
  }

  delete(String key) async{
    await _storage.delete(key: key);
  }
}
