import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/feature/home/model/move.dart';

class Game {
  String? id;
  String name;
  String creator;
  String? opponent;
  List<Move> board;
  String turn;
  String status;
  int backgroundColor;

  Game({
    this.id,
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

  factory Game.fromDocument(DocumentSnapshot? doc) {
    var data = doc?.data() as Map<String, dynamic>;
    var moves = (data['board'] as List)
        .map((item) => Move.fromJson(item as Map<String, dynamic>))
        .toList();
    return Game(
      id: doc?.id,
      name: data['name'],
      board: moves,
      turn: data['turn'],
      creator: data['creator'],
      opponent: data['opponent'],
      status: data['status'],
      backgroundColor: data['backgroundColor'],
    );
  }
}
