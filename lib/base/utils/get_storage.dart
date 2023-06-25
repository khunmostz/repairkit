import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static setFcmToLocal(String value) {
    final box = GetStorage();
    return box.write('fcmToken', value);
  }

  static String getFcmToLocal(String value){
    final box = GetStorage();
    return box.read('fcmToken');
  }
}
