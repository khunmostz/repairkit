import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton(() => GlobalStateService());
}

class GlobalStateService {
  String? _fcmToken;
  String? get fcmToken => _fcmToken;
  void setFcmToken(String? token){
    _fcmToken = token;
  }
}
