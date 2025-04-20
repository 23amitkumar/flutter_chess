import 'package:flutter_chess/utils/piece.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final void Function()? onTap;
  final bool isValidMove;
  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.onTap,
    required this.isValidMove,
  });

  @override
  Widget build(BuildContext context) {
    Color? squareColor;

    if (isSelected) {
      squareColor = AppColor.selectedColor;
    } else if (isValidMove) {
      squareColor = AppColor.validMoveColor;
    } else {
      squareColor = isWhite ? AppColor.lightSquareColor : AppColor.darkSquareColor;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        margin: EdgeInsets.all(isValidMove ? 4 : 0),
        child: piece != null
            ? Image.asset(
                piece?.imagePath??"",
              )
            : null,
      ),
    );
  }
}
