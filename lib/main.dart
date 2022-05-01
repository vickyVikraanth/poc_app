import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/view_model/home_view_model.dart';

import 'utility/locator.dart';
import 'view_router.dart';
import 'view_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create : (context) => HomeViewModel()) //multi viewmodel register here
    ],
    child: GetMaterialApp(
      title: 'Flutter Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: ViewRoutes.initial,
      getPages: ViewRouter.routes,
    ),);
  }
}
