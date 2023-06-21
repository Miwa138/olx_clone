import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUploader {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(File image) async {
    // Upload image to Firebase Storage
    final ref = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = ref.putFile(image);
    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // Save download URL to Firestore
    _firestore.collection('images').add({'url': downloadUrl});

    return downloadUrl;
  }
}