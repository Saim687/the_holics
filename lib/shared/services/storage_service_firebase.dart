import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadUserProfileImage(String uid, XFile file) async {
    try {
      final ref = _firebaseStorage.ref('users/$uid/profile.jpg');
      final bytes = await file.readAsBytes();
      final uploadTask = ref.putData(bytes);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadWorkoutVideo(String workoutId, XFile file) async {
    try {
      final ref =
          _firebaseStorage.ref('body_holics/workouts/$workoutId/video.mp4');
      final bytes = await file.readAsBytes();
      final uploadTask = ref.putData(bytes);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadSpecialistPhoto(String specialistId, XFile file) async {
    try {
      final ref =
          _firebaseStorage.ref('skin_holics/specialists/$specialistId.jpg');
      final bytes = await file.readAsBytes();
      final uploadTask = ref.putData(bytes);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      await _firebaseStorage.ref(path).delete();
    } catch (e) {
      rethrow;
    }
  }
}
