import 'package:flutter_chess/utils/piece.dart';
import 'package:flutter_chess/generated/assets.dart';

import 'helper_methods.dart';

class PiecesPosition {
  static void initialBishopPosition(List<List<ChessPiece?>> newBoard) {
    // ~ Add the black bishops
    newBoard[0][2] = ChessPiece(
      ChessPieceType.bishop,
      false,
      Assets.blackBishop,
    );
    newBoard[0][5] = ChessPiece(
      ChessPieceType.bishop,
      false,
      Assets.blackBishop,
    );
    // ~ Add the white bishops
    newBoard[7][2] = ChessPiece(
      ChessPieceType.bishop,
      true,
      Assets.whiteBishop,
    );
    newBoard[7][5] = ChessPiece(
      ChessPieceType.bishop,
      true,
      Assets.whiteBishop,
    );
  }

  static void initialKingPosition(List<List<ChessPiece?>> newBoard) {
    // ~ Add the black king
    newBoard[0][4] = ChessPiece(
      ChessPieceType.king,
      false,
      Assets.blackKing,
    );
    // ~ Add the white king
    newBoard[7][4] = ChessPiece(
      ChessPieceType.king,
      true,
      Assets.whiteKing,
    );
  }

  static void initialKnightPosition(List<List<ChessPiece?>> newBoard) {
    // ~ Add the black knights
    newBoard[0][1] = ChessPiece(
      ChessPieceType.knight,
      false,
      Assets.blackKnight,
    );
    newBoard[0][6] = ChessPiece(
      ChessPieceType.knight,
      false,
      Assets.blackKnight,
    );
    // ~ Add the white knights
    newBoard[7][1] = ChessPiece(
      ChessPieceType.knight,
      true,
      Assets.whiteKnight,
    );
    newBoard[7][6] = ChessPiece(
      ChessPieceType.knight,
      true,
      Assets.whiteKnight,
    );
  }

  static void initialPawnPosition(List<List<ChessPiece?>> newBoard) {
    for (var i = 0; i < 8; i++) {
      // ~Add the black pawns
      newBoard[1][i] = ChessPiece(
        ChessPieceType.pawn,
        false,
        Assets.blackPawn,
      );
      // ~Add the white pawns
      newBoard[6][i] = ChessPiece(
        ChessPieceType.pawn,
        true,
        Assets.whitePawn,
      );
    }
  }

  static void initialQueenPosition(List<List<ChessPiece?>> newBoard) {
    // ~ Add the black queen
    newBoard[0][3] = ChessPiece(
      ChessPieceType.queen,
      false,
      Assets.blackQueen,
    );
    // ~ Add the white queen
    newBoard[7][3] = ChessPiece(
      ChessPieceType.queen,
      true,
      Assets.whiteQueen,
    );
  }

  static void initialRookPosition(List<List<ChessPiece?>> newBoard) {
    // ~ Add the black rooks
    newBoard[0][0] = ChessPiece(
      ChessPieceType.rook,
      false,
      Assets.blackRook,
    );
    newBoard[0][7] = ChessPiece(
      ChessPieceType.rook,
      false,
      Assets.blackRook,
    );
    // ~ Add the white rooks
    newBoard[7][0] = ChessPiece(
      ChessPieceType.rook,
      true,
      Assets.whiteRook,
    );
    newBoard[7][7] = ChessPiece(
      ChessPieceType.rook,
      true,
      Assets.whiteRook,
    );
  }

  static void validMoves(
      int row,
      int col,
      ChessPiece selectedPiece,
      List<List<ChessPiece?>> board,
      int direction,
      List<List<int>> candidateMoves) {}


  static void validPawnMoves(
      int row,
      int col,
      ChessPiece selectedPiece,
      List<List<ChessPiece?>> board,
      int direction,
      List<List<int>> candidateMoves) {
    // 1 square forward if the square is empty
    if (isInBoard(row + direction, col) &&
        board[row + direction][col] == null) {
      candidateMoves.add([row + direction, col]);
    }

    // 2 squares forward if the pawn is in its starting position
    if ((selectedPiece.isWhite && row == 6) ||
        (!selectedPiece.isWhite && row == 1)) {
      // check if the square is next 2 squares and just next square is empty
      if (isInBoard(row + 2 * direction, col) &&
          board[row + direction][col] == null) {
        candidateMoves.add([row + 2 * direction, col]);
      }
    }

    // capture diagonally
    // check if the square is in the board and if there is a piece and it is of opposite color
    if (isInBoard(row + direction, col + direction) &&
        board[row + direction][col + direction] != null &&
        board[row + direction][col + direction]!.isWhite !=
            selectedPiece.isWhite) {
      candidateMoves.add([row + direction, col + direction]);
    }
  }
}
