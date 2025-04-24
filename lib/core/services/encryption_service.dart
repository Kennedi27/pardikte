import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final Encrypter _encrypter;
  final IV _iv;

  EncryptionService(String key)
      : _iv = IV.fromLength(16),
        _encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));

  String encrypt(String plain) {
    final encrypted = _encrypter.encrypt(plain, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedBase64) {
    final encrypted = Encrypted.fromBase64(encryptedBase64);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
