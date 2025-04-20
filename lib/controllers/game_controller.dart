import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chess/utils/piece.dart';
import 'package:flutter_chess/utils/initial_board.dart';
import 'package:flutter_chess/utils/valid_moves.dart';

class GameController extends GetxController {
  RxList<List<ChessPiece?>> board = <List<ChessPiece?>>[].obs;
  Rxn<ChessPiece?> selectedPiece = Rxn();
  RxInt selectedRow = (-1).obs;
  RxInt selectedCol = (-1).obs;
  RxList<List<int>> validMoves = <List<int>>[].obs;
  RxList<ChessPiece> whiteCapturedPieces = <ChessPiece>[].obs;
  RxList<ChessPiece> blackCapturedPieces = <ChessPiece>[].obs;
  RxBool isWhiteTurn = true.obs;
  RxList<int> whiteKingPosition = [7, 4].obs;
  RxList<int> blackKingPosition = [0, 4].obs;
  var isCheck = false.obs;

  @override
  void onInit() {
    super.onInit();
    resetGame();
  }

  void pieceSelected(int row, int col) {
    if (board[row][col] != null && selectedPiece.value == null) {
      if (board[row][col]!.isWhite == isWhiteTurn.value) {
        selectedPiece.value = board[row][col];
        selectedRow.value = row;
        selectedCol.value = col;
      }
    } else if (board[row][col] != null &&
        board[row][col]!.isWhite == selectedPiece.value!.isWhite) {
      selectedPiece.value = board[row][col];
      selectedRow.value = row;
      selectedCol.value = col;
    } else if (selectedPiece.value != null &&
        validMoves.any((move) => move[0] == row && move[1] == col)) {
      movePiece(row, col);
    }

    if (selectedPiece.value != null) {
      validMoves.value = calculateRealValidMoves(
          selectedRow.value,
          selectedCol.value,
          selectedPiece.value!,
          true,
          board,
          whiteKingPosition,
          blackKingPosition);
    }
    refreshGame();
  }

  void movePiece(int newRow, int newCol) {
    if (board[newRow][newCol] != null) {
      if (board[newRow][newCol]!.isWhite) {
        whiteCapturedPieces.add(board[newRow][newCol]!);
      } else {
        blackCapturedPieces.add(board[newRow][newCol]!);
      }
    }

    if (selectedPiece.value!.type == ChessPieceType.king) {
      if (selectedPiece.value!.isWhite) {
        whiteKingPosition.value = [newRow, newCol];
      } else {
        blackKingPosition.value = [newRow, newCol];
      }
    }

    board[newRow][newCol] = selectedPiece.value;
    board[selectedRow.value][selectedCol.value] = null;

    isCheck.value = isKingInCheck(
        !isWhiteTurn.value, board, whiteKingPosition, blackKingPosition);

    selectedPiece.value = null;
    selectedRow.value = -1;
    selectedCol.value = -1;
    validMoves.clear();

    if (isCheckMate(!isWhiteTurn.value, board, whiteKingPosition,
        blackKingPosition)) {
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('CHECK MATE!'),
          actions: [
            TextButton(
              onPressed: resetGame,
              child: const Text('Play Again'),
            ),
          ],
        ),
      );
    }

    isWhiteTurn.toggle();
    refreshGame();
  }

  void resetGame() {
    board.value = initialBoard();
    isCheck.value = false;
    isWhiteTurn.value = true;
    whiteCapturedPieces.clear();
    blackCapturedPieces.clear();
    whiteKingPosition.value = [7, 4];
    blackKingPosition.value = [0, 4];
    refreshGame();
  }
  void refreshGame() {
    board.refresh();
    isCheck.refresh();
    isWhiteTurn.refresh();
    whiteCapturedPieces.refresh();
    blackCapturedPieces.refresh();
    whiteKingPosition.refresh();
    blackKingPosition.refresh();
  }
}
