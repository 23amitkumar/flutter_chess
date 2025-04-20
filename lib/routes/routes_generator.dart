import 'package:flutter/material.dart';
import 'package:flutter_chess/views/gameBoard.dart';
import 'package:get/get.dart';
import '../bindings/bindings.dart';
import 'routes.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    final args = settings.arguments;
    Bindings? binding;
    switch (settings.name) {
      case Routes.gameBoard:
        widgetScreen = GameBoard();
        binding = GameBoardBinding();
        break;

      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name,
        page: () => widgetScreen,
        binding: binding,
        transition: Transition.noTransition,
        settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(),
      body:
          const Center(child: Text('No Such screen found in route generator')),
    );
  }
}
