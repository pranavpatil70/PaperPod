import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paperpod/services/tts_service.dart';
import 'package:paperpod/services/share_service.dart';
import 'package:paperpod/services/auth_service.dart';
import 'package:paperpod/services/firebase_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final firebaseService = FirebaseService();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Home'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            await authService.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, '/auth', (route) => false);
          },
          child: const Icon(CupertinoIcons.square_arrow_right),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoButton.filled(
              onPressed: () {
                // Play TTS
                Provider.of<TTSService>(context, listen: false)
                    .speak("Welcome to PaperPod!");
              },
              child: const Text('Play TTS'),
            ),
            CupertinoButton.filled(
              onPressed: () {
                // Share Podcast
                Provider.of<ShareService>(context, listen: false)
                    .sharePodcast("Check out this cool podcast!");
              },
              child: const Text('Share Podcast'),
            ),
            CupertinoButton.filled(
              onPressed: () {
                // Navigate to History Screen
                Navigator.pushNamed(context, '/history');
              },
              child: const Text('View History'),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: firebaseService.getPodcastHistory(authService.userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No podcasts uploaded yet.');
                }

                var podcasts = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: podcasts.length,
                    itemBuilder: (context, index) {
                      var podcast = podcasts[index];
                      return ListTile(
                        title: Text(podcast['title']),
                        subtitle: Text(
                            'Uploaded on: ${podcast['timestamp'].toDate()}'),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
