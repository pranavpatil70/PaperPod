import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Firebase Authentication Methods
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Firebase Storage Methods (for uploading podcast)
  Future<String> uploadPodcast(File file) async {
    try {
      String fileName = "podcast_${DateTime.now().millisecondsSinceEpoch}.mp3";
      Reference storageRef = _storage.ref().child('podcasts/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading podcast: $e");
      return "";
    }
  }

  // Firestore Methods (for storing podcast metadata)
  Future<void> savePodcastHistory(
      String title, String downloadUrl, String userId) async {
    try {
      await _firestore.collection('podcasts').add({
        'title': title,
        'url': downloadUrl,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving podcast history: $e");
    }
  }

  // Get user's podcasts from Firestore
  Future<List<Map<String, dynamic>>> getPodcastHistory(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('podcasts')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();
      List<Map<String, dynamic>> podcasts = [];
      for (var doc in snapshot.docs) {
        podcasts.add(doc.data() as Map<String, dynamic>);
      }
      return podcasts;
    } catch (e) {
      print("Error fetching podcast history: $e");
      return [];
    }
  }
}
