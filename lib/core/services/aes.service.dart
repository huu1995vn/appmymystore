import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class AESService {
  static final key = Key(Uint8List.fromList(
      Key.fromUtf8("SDGD\$E^&Ư#RBSDGFGJ*IY^&ÉDQQWRWF#\$%#SGSAS")
          .bytes
          .take(16)
          .toList()));
  static final iv = IV(Uint8List.fromList(
      IV.fromUtf8("@&AA#\$D@ILYXE@2022").bytes.take(16).toList()));
  // mã hóa động theo key
  static String encrypt(String plainText) {
    Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.encrypt(plainText, iv: iv).base64;
  }
  // dịch mã động theo key
  static String decrypt(String base64) {
    Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt(Encrypted.fromBase64(base64), iv: iv);
  }
}
