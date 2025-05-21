import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> writeBool(String key, bool value) async {
    await storage.write(key: key, value: value.toString());
  }

  Future<bool?> readBool(String key) async {
    final value = await storage.read(key: key);
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }


  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
