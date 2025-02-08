import 'package:flutter/cupertino.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Podcast History'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.back),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No podcasts uploaded yet.',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
              CupertinoButton.filled(
                onPressed: () {
                  // Navigate back to Home Screen
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
