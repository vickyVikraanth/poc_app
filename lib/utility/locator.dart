import 'package:get_it/get_it.dart';
import 'package:sample_project/utility/services/exceptions/api_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {

  locator.registerLazySingleton<ApiService>(() => ApiService());

}