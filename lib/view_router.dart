

import 'package:get/get.dart';
import 'package:sample_project/view/ui/home_screen.dart';
import 'package:sample_project/view/ui/splash_screen.dart';
import 'package:sample_project/view_routes.dart';

class ViewRouter {
  static final routes = [
    GetPage(
      name: ViewRoutes.initial,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: ViewRoutes.homePage,
      page: () => HomeScreen(),
    ),

  ];


}
