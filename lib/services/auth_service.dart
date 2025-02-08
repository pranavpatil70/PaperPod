import 'package:flutter/material.dart';
import 'firebase_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  String? _userId;

  String? get userId => _userId;

  Future<bool> signUp(String email, String password) async {
    var user = await _firebaseService.signUp(email, password);
    if (user != null) {
      _userId = user.uid;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    var user = await _firebaseService.signIn(email, password);
    if (user != null) {
      _userId = user.uid;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
    _userId = null;
    notifyListeners();
  }
}
