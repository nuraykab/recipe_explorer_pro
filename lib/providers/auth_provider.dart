import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../data/models/user_model.dart';
import '../data/services/auth_service.dart';
import '../data/services/user_service.dart';
import '../utils/constants/images.dart';
import '../utils/constants/snackbar.dart';
import '../utils/routes/app_routes.dart';
import 'user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    final userPro = Provider.of<UserProvider>(context, listen: false);

    if (emailTextEditingController.text.isEmpty ||
        passwordTextEditingController.text.isEmpty) {
      MySnackbar.showError(context, "Please fill all the fields");
      return;
    }

    _setLoading(true); // начинаем загрузку

    try {
      var user = await AuthService().signInWithEmailAndPassword(
        emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim(),
      );

      if (user.email == '') {
        if (context.mounted) {
          MySnackbar.showError(context, "Please verify your email");
        }
        return;
      }

      await userPro.addUser(user);

      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } catch (e, s) {
      log("SigninError $e :- $s");
      if (context.mounted) {
        MySnackbar.showError(context, "Invalid email or password");
      }
    } finally {
      _setLoading(false); // завершаем загрузку
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
    }
  }


  final fullNameText = TextEditingController();
  final phoneNumberText = TextEditingController();
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    log("_isChecked: $_isChecked");
    notifyListeners();
  }

  void signup(BuildContext context) async {
    if (!signupFormKey.currentState!.validate()) return;
    final userPro = Provider.of<UserProvider>(context, listen: false);

    signupFormKey.currentState!.save();
    log("signup isChecked: $_isChecked");
    try {
      if (!_isChecked) {
        MySnackbar.showError(context, "Need to accept the privacy & policy");
        return;
      }
      log(' Get.to(() => const LoadingPopup());');

      final userCredential = await AuthService().registerWithEmailAndPassword(
          emailText.text, passwordText.text.trim());
      final user = UserModel(
        id: userCredential.user!.uid,
        name: fullNameText.text.trim(),
        number: phoneNumberText.text.trim(),
        email: emailText.text.trim(),
        profile: Images.avatar,
      );
      await UserService().saveUserRecord(user, userCredential.user!.uid);

      // Add user data to UserProvider
      await userPro.addUser(user);

      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.home);
      }

      fullNameText.clear();
      phoneNumberText.clear();
      emailText.clear();
      passwordText.clear();
      isChecked = false;
      signupFormKey.currentState!.reset();
    } catch (e) {
      log("Error: $e");
    }
  }
  // Google Sign-In
  Future<void> signInWithGoogle(BuildContext context) async {
    _setLoading(true);
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final userPro = Provider.of<UserProvider>(context, listen: false);
      UserModel user =
      await UserService().fetchUserdetails(userCredential.user!.uid);

      await userPro.addUser(user);

      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } catch (e) {
      if (context.mounted) {
        MySnackbar.showError(context, 'Google sign-in failed: $e');
      }
    } finally {
      _setLoading(false);
    }
  }


// Facebook Sign-In
  Future<void> signInWithFacebook(BuildContext context) async {
    _setLoading(true);
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) return;

      final credential =
      FacebookAuthProvider.credential(result.accessToken!.token);

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final userPro = Provider.of<UserProvider>(context, listen: false);
      UserModel user =
      await UserService().fetchUserdetails(userCredential.user!.uid);

      await userPro.addUser(user);

      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } catch (e) {
      if (context.mounted) {
        MySnackbar.showError(context, 'Facebook sign-in failed: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

// GitHub Sign-In
  Future<void> signInWithGitHub(BuildContext context) async {
    _setLoading(true);
    try {
      final clientId = 'Ov23liWInARHgDwb844PD';
      final clientSecret = '96d622f2e6f4528018b35e2dae1707113429a02b';

      final url = Uri.https("github.com", "/login/oauth/authorize", {
        'client_id': clientId,
        'scope': 'read:user,user:email',
      });

      final result = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: "https",
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) throw 'Не удалось получить код авторизации';

      final response = await http.post(
        Uri.parse("https://github.com/login/oauth/access_token"),
        headers: {'Accept': 'application/json'},
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
        },
      );

      final accessToken = json.decode(response.body)['access_token'];
      if (accessToken == null) throw 'Не удалось получить токен доступа';

      final credential = GithubAuthProvider.credential(accessToken);

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final userPro = Provider.of<UserProvider>(context, listen: false);
      UserModel user =
      await UserService().fetchUserdetails(userCredential.user!.uid);

      await userPro.addUser(user);

      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } catch (e) {
      if (context.mounted) {
        MySnackbar.showError(context, 'GitHub sign-in failed: $e');
      }
    } finally {
      _setLoading(false);
    }
  }



  void signOut(BuildContext context) async {
    final userPro = Provider.of<UserProvider>(context, listen: false);

    _auth.signOut();
    _user = null;

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (route) => false);
    }
    await userPro.logoutUser();
    notifyListeners();
  }

  void requestEmailVerification(BuildContext context) async {
    try {
      String email = emailTextEditingController.text.trim();
      await AuthService().sendPasswordResetEmail(email);
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.password);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        log("Error request EmailVerification: $e");
        MySnackbar.showError(context, "Try again later");
      }
    }
  }
}
