import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/history_screen.dart';
import '/services/auth_service.dart';
import '/services/firebase_service.dart';
import '/services/tts_service.dart';
import '/services/share_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PaperPod());
}

class PaperPod extends StatelessWidget {
  const PaperPod({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirebaseService>(create: (_) => FirebaseService()),
        Provider<TTSService>(create: (_) => TTSService()),
        Provider<ShareService>(create: (_) => ShareService()),
      ],
      child: CupertinoApp(
        title: 'PaperPod',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
        ),
        home: const AuthScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/upload': (context) => const UploadScreen(),
          '/history': (context) => const HistoryScreen(),
        },
      ),
    );
  }
}
