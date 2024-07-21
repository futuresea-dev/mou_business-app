import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/repositories/auth_repository.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/helpers/validators_helper.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class SendEmailViewModel extends BaseViewModel {
  final emailController = TextEditingController();
  final activeSubject = BehaviorSubject<bool>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _message;

  final AuthRepository authRepository;

  SendEmailViewModel(this.authRepository);

  void onEmailChanged(String text) {
    activeSubject.add(text.isNotEmpty);
  }

  void onSendPressed() {
    FocusScope.of(context).unfocus();
    String email = emailController.text;
    String validate = ValidatorsHelper.validateEmail(email);
    if (validate.isNotEmpty) {
      showSnackBar(validate);
    } else {
      _onSendEmail(email);
    }
  }

  void _onSendEmail(String email) async {
    setLoading(true);
    authRepository.sendEmail(email).then((value) {
      setLoading(false);
      if (value.isSuccess) {
        showDialogSuccess(value.data ?? '');
      } else {
        showSnackBar(value.message);
      }
    }).catchError((error) {
      setLoading(false);
      showSnackBar(error.toString());
    });

    // UserCredential userCredential;

    // List<String> siginInMethods = await _auth.fetchSignInMethodsForEmail(email);
    // if (siginInMethods.isEmpty) {
    //   _message = "Email doesn't not exist.";

    //   userCredential = await _auth.createUserWithEmailAndPassword(
    //     email: email,
    //     password: "password",
    //   );
    // } else {
    //    userCredential = 
    //     await _auth.signInWithEmailAndPassword(
    //         email: email, 
    //         password: "password"
    //     );
    // }

    // User? user = userCredential.user;
    // if (user != null) {
    //   if (!user.emailVerified) {
    //     await user.sendEmailVerification();
    //     _message = "Verification email has been sent. Please check your email.";
    //       showSnackBar(_message);
    //   } 
    //   authRepository.sendEmail(email).then((value) {
    //     setLoading(false);
    //     if (value.isSuccess) {
    //       showDialogSuccess(value.data ?? '');
    //     } else {
    //       showSnackBar(value.message);
    //     }
    //   }).catchError((error) {
    //     setLoading(false);
    //     showSnackBar(error.toString());
    //   });
    // }

    // setLoading(false);
  }

  @override
  void dispose() {
    activeSubject.close();
    activeSubject.close();
    emailController.dispose();
    super.dispose();
  }

  void showDialogSuccess(String message) {
    if (message.isEmpty) return;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(allTranslations.text(AppLanguages.ok)),
              onPressed: () => Navigator.pop(dialogContext),
            ),
          ],
        );
      },
    );
  }
}
