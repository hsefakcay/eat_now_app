import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/ui/views/login_view.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';

class AuthService {
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //hata olmazsa ana sayfaya yönlendirir
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is to weak';
      } else if (e.code == 'email-already-in-use') {
        message = "An account already exists with that email";
      } else if (e.code == 'channel-error') {
        message = "Channel error";
      }

      _showToast(message);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
//hata olmazsa ana sayfaya yönlendirir
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ));
    } on FirebaseAuthException catch (e) {
      String message = 'Kullanıcı bilgilerini kontrol edin !';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided for that user.";
      }

      _showToast(message);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();

    await Future.delayed(Durations.extralong4);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ));
  }
}

void _showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: AppColor.redColor,
    fontSize: 16,
  );
}
