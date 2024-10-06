import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/utils/toast_helper.dart';
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
      await Future<void>.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<MainPage>(
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

      ToastHelper.showToast(message);
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
      await Future<void>.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<MainPage>(
            builder: (context) => MainPage(),
          ));
    } on FirebaseAuthException catch (e) {
      String message = 'Kullanici bilgilerini kontrol edin !';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided for that user.";
      }

      ToastHelper.showToast(message);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();

    await Future<void>.delayed(Durations.extralong4);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute<LoginView>(
          builder: (context) => LoginView(),
        ));
  }
}
