import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static setSometing(dynamic value) {
    final box = GetStorage();
    return box.write('someting-key', value);
  }
}
