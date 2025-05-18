import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import '../data/models/user_model.dart';
import '../data/services/user_service.dart';
import '../utils/constants/images.dart';

class UserProvider extends ChangeNotifier {
  static const String _boxName = "userBox";
  var avatarList = <String>[];

  UserModel _user = UserModel.empty();
  UserModel get user => _user;
  UserProvider() {
    initUser();
  }

  final fullNameText = TextEditingController();
  final phoneNumberText = TextEditingController();
  String profileText = '';

  /// Initialize Hive and Load User Data
  Future<void> initUser() async {
    var box = await Hive.openBox<UserModel>(_boxName);
    _user = box.get('user', defaultValue: UserModel.empty())!;
    fullNameText.text = _user.name;
    phoneNumberText.text = _user.number;
    profileText = _user.profile;
    avatarList = Images.profile;
    notifyListeners();
  }

  /// Update User Profile
  Future<void> updateUser() async {
    var updatedUser = UserModel(
      name: fullNameText.text,
      number: phoneNumberText.text,
      email: _user.email,
      profile: profileText,
    );
    var box = await Hive.openBox<UserModel>(_boxName);
    await box.put('user', updatedUser);
    await UserService().updateUserField(userMdel: updatedUser);
    _user = updatedUser;
    notifyListeners();
  }

  /// Clear User Data
  Future<void> logoutUser() async {
    var box = await Hive.openBox<UserModel>(_boxName);
    await box.delete('user');
    _user = UserModel.empty();
    notifyListeners();
  }

  /// Add User Data on Sign Up or Sign In
  Future<void> addUser(UserModel newUser) async {
    var box = await Hive.openBox<UserModel>(_boxName);
    await box.put('user', newUser);
    _user = newUser;
    notifyListeners();
  }

  void changeProfile(int index) {
    profileText = avatarList[index];
    notifyListeners();
  }
}
