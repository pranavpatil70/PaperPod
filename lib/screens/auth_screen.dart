import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Sign In'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () async {
            // Handle authentication logic here
            try {
              await FirebaseAuth.instance.signInAnonymously();
              Navigator.pushReplacementNamed(context, '/home');
            } catch (e) {
              print('Error: $e');
            }
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}
