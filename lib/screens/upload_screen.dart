import 'package:flutter/cupertino.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Upload Podcast'),
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
          child: CupertinoButton.filled(
            onPressed: () {
              // Implement upload functionality here
              print('Podcast uploaded');
              // After uploading, navigate back
              Navigator.pop(context);
            },
            child: const Text('Upload Podcast'),
          ),
        ),
      ),
    );
  }
}
