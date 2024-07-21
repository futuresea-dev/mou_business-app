import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mou_business_app/utils/app_shared.dart';

class FirebaseService {
  String? _verificationId;

  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  static FirebaseService? _instance;

  FirebaseService() {
    _instance = this;
  }

  static Future<void> logout() async {
    if (_instance == null) return;
    _instance?.signOut();
  }

  Future<void> verifyPhone(
    String phoneNumber,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
  ) async {
    print("verifyPhone $phoneNumber");
    return _fireBaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeAutoRetrievalTimeout: (String verId) {
        _verificationId = verId;
      },
      codeSent: (String verId, [int? forceCodeResend]) {
        _verificationId = verId;
        print("verId $verId");
        print("Code send");
      },
      timeout: const Duration(seconds: 120),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
    );
  }

  Future<String?> getTokenByCode(String smsCode) async {
    try {
      final String? verificationId = _verificationId;
      if (verificationId == null || verificationId.isEmpty) return null;
      print("smsCode: $smsCode");
      print("verificationId: $verificationId");
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return signInWithAuthCredential(credential);
    } catch (e) {
      print("getTokenByCode error: ${e.toString()}");
    }
    return null;
  }

  Future<String?> signInWithAuthCredential(AuthCredential credential) async {
    try {
      final UserCredential? userCredential = await _fireBaseAuth.signInWithCredential(credential);
      final User? user = userCredential?.user;
      final User? currentUser = _fireBaseAuth.currentUser;
      if (user != null && currentUser != null && user.uid == currentUser.uid) {
        return await user.getIdToken(true);
      }
    } catch (e) {
      print("signInWithAuthCredential error: ${e.toString()}");
    }
    return null;
  }

  bool isLogged() {
    final User? currentUser = _fireBaseAuth.currentUser;
    if (currentUser != null) {
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await _fireBaseAuth.signOut();
  }

  Future<void> refreshToken() async {
    final String accessToken = await _fireBaseAuth.currentUser?.getIdToken(true) ?? '';
    await AppShared.setAccessToken(accessToken);
    print("Refresh access token : $accessToken");
  }
}
