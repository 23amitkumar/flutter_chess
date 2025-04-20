import 'package:flutter_chess/utils/piece.dart';
import 'package:flutter_chess/utils/pieces_position.dart';

List<List<ChessPiece?>> initialBoard() {
  // initialize the board with null values, meaning no piece is present
  List<List<ChessPiece?>> newBoard = List.generate(8, (index) {
    return List.generate(8, (index) => null);
  });

  //  Add the pawns
  PiecesPosition.initialPawnPosition(newBoard);

  // * Add the rooks
  PiecesPosition.initialRookPosition(newBoard);

  // * Add the knights
  PiecesPosition.initialKnightPosition(newBoard);

  // * Add the bishops
  PiecesPosition.initialBishopPosition(newBoard);

  // * Add the queens
  PiecesPosition.initialQueenPosition(newBoard);

  // * Add the kings
  PiecesPosition.initialKingPosition(newBoard);

  return newBoard;
}
