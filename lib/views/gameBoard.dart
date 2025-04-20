import 'package:flutter/material.dart';
import 'package:flutter_chess/controllers/game_controller.dart';
import 'package:flutter_chess/utils/app_colors.dart';
import 'package:get/get.dart';
import '../utils/helper_methods.dart';
import '../utils/square.dart';

class GameBoard extends GetView<GameController> {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ~ Turn Indicator and reset button
            Container(
              height: 50,
              width: 200,
              color: AppColor.borderColor,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      controller.isCheck.value
                          ? 'check'
                          : controller.isWhiteTurn.value
                              ? 'White\'s Turn'
                              : 'Black\'s Turn',
                      style: TextStyle(
                        color: controller.isCheck.value
                            ? Colors.red
                            : controller.isWhiteTurn.value
                                ? Colors.white
                                : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ~ Captured Pieces by Black
            SizedBox(
              height: 35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.blackCapturedPieces.length,
                  itemBuilder: (context, index) {
                    var blackCapturedPieces =
                        controller.blackCapturedPieces[index];
                    return Image.asset(
                      height: 10,
                      width: 20,
                      blackCapturedPieces.imagePath,
                    );
                  }),
            ),
            // ~ Chessboard
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.borderColor,
                  width: 5.0,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8 * 8,
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;

                    //  check if this square is selected
                    bool isSelected = (controller.selectedRow.value == row &&
                        controller.selectedCol.value == col);

                    // check if this square is a valid move
                    bool isValidMove = false;
                    for (var move in controller.validMoves) {
                      if (move[0] == row && move[1] == col) {
                        isValidMove = true;
                        break;
                      }
                    }
                    return Square(
                      isWhite: isWhite(index),
                      piece: controller.board[row][col],
                      isSelected: isSelected,
                      onTap: () => controller.pieceSelected(row, col),
                      isValidMove: isValidMove,
                    );
                  },
                ),
              ),
            ),

            // ~ Captured Pieces by White
            SizedBox(
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.whiteCapturedPieces.length,
                  itemBuilder: (context, index) {
                    var blackCapturedPieces =
                        controller.whiteCapturedPieces[index];
                    return Image.asset(
                      height: 10,
                      width: 20,
                      blackCapturedPieces.imagePath,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }


}


class StringColor{
    String? value;
   Color? color;
   StringColor({this.value,this.color});
}