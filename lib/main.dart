import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'routes/routes.dart';
import 'routes/routes_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chess',
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      initialRoute: Routes.gameBoard,
      onGenerateRoute: RoutesGenerator.generateRoute,
      navigatorObservers: [ClearFocusOnPush()],
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          RoutesGenerator.generateRoute(
              const RouteSettings(name: Routes.gameBoard)),
        ];
      },
    );
  }
}

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}
