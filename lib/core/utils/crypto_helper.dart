import 'package:encrypt/encrypt.dart';

class CryptoHelper {
  static final _key = Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 karakter
  static final _iv = IV.fromLength(16); // IV standar AES

  final _encrypter = Encrypter(AES(_key));

  String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
    return decrypted;
  }
}
