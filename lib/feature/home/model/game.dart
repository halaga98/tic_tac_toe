import 'package:tic_tac_toe/feature/home/model/move.dart';

class Game {
  String name;
  String creator;
  String? opponent;
  List<Move> board;
  String turn;
  String status;
  int backgroundColor;

  Game({
    required this.name,
    required this.creator,
    required this.board,
    required this.turn,
    required this.status,
    required this.backgroundColor,
    this.opponent,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'creator': creator,
      'opponent': opponent,
      //'board': board.map((move) => move.toMap()).toList(),
      'board': this.board.map((v) => v.toJson()).toList(),
      'turn': turn,
      'status': status,
      'backgroundColor': backgroundColor, // Firebase'de rengi saklamak için
    };
  }
}
