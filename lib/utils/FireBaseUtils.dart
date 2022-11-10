import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseUtils {

  static final FirebaseStorage storage = FirebaseStorage.instance;
  static bool uploading = false;
  static bool loading = false;
  static late String urlperfilPhoto;

  static Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  static Future<UploadTask> upload(String path, int personId) async {
    File file = File(path);
    try {
      String ref = 'images/users/${personId.toString()}/img_perfil.jpg';

      return storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  static Future<void> pickAndUploadImage(int personId, Function setStateRunning, Function setStateSuccess) async {
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await upload(file.path, personId);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setStateRunning();
        } else if (snapshot.state == TaskState.success) {
          setStateSuccess();
        }
      });
    }
  }

  static Future<String> loadImage(int personId) async {
    return storage
        .ref('images/users/${personId.toString()}/img_perfil.jpg')
        .getDownloadURL();
  }

}