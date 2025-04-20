import 'package:get/get.dart';

import '../controllers/game_controller.dart';

class GameBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(
          () => GameController(),
    );
  }
}