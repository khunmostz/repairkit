import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static setFcmToLocal(String value) {
    final box = GetStorage();
    return box.write('fcmToken', value);
  }

  static String? getFcmToLocal(){
    final box = GetStorage();
    if (box.read('fcmToken') != null) {
      return box.read('fcmToken');
    }
    return null;
  }

  static void clearFcmToLocal(){
    final box = GetStorage();
    box.remove('fcmToken');
  }
}
