import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setGetIt() {
  getIt.registerLazySingleton(() => AppModel());
}

class AppModel {}
