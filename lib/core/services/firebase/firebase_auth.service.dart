// ignore_for_file: unused_element, empty_catches

import 'package:mymystore/core/commons/common_configs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymystore/core/commons/common_methods.dart';

class FirebaseAuthService {
  static signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      CommonMethods.wirtePrint("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          CommonMethods.wirtePrint(
              "Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          CommonMethods.wirtePrint("Unknown error.");
      }
    }
  }

  static _convertNumberPhoneWithCountryCode(String number,
      {String code = "+84"}) {
    String numberCode = number;
    if (number[0] == "0") {
      numberCode = number.replaceFirst("0", code);
    }
    return numberCode;
  }

  static final FirebaseAuthService _instance = FirebaseAuthService.internal();
  FirebaseAuthService.internal();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Map<String, dynamic> verify = <String, String>{};
  factory FirebaseAuthService() {
    return _instance;
  }
  //Xử lý cho thiết bị android or ios
  static Future<void> sendOTP(
    String phoneNumber,
    void Function(Object) fnError,
    void Function() fnSuccess,
  ) async {
    _auth.setLanguageCode(CommonConfig.LanguageCode);
    phoneNumber = _convertNumberPhoneWithCountryCode(phoneNumber);
    if (!CommonMethods.isMobile()) {
      try {
        phoneNumber = _convertNumberPhoneWithCountryCode(phoneNumber);
        verify[phoneNumber] = await _auth.signInWithPhoneNumber(phoneNumber);
        fnSuccess();
      } catch (e) {
        fnError(e);
      }
    } else {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        timeout: Duration(seconds: CommonConfig.TimeVerify * 60),
        verificationFailed: (FirebaseAuthException ex) {
          fnError(ex.message!);
        },
        codeSent: (String verificationId, int? resend) {
          verify[phoneNumber] = verificationId;
          fnSuccess();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  static Future<bool> verifyOTP(String phoneNumber, String smsCode) async {
    phoneNumber = _convertNumberPhoneWithCountryCode(phoneNumber);
    if (!CommonMethods.isMobile()) {
      return await verify[phoneNumber].confirm(smsCode);
    } else {
      UserCredential user = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verify[phoneNumber], smsCode: smsCode));
      return user.user != null;
    }
  }
}
