import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> sharePodcast(String message) async {
    await Share.share(message);
  }
}
