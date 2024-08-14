import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../model/move.dart';

@RoutePage<bool?>()
final class PlayGameView extends StatefulWidget {
  PlayGameView({required this.id, super.key});
  final String id;

  @override
  State<PlayGameView> createState() => _PlayGameViewState();
}

class _PlayGameViewState extends State<PlayGameView> {
  List<Move> _moves =
      List.generate(9, (index) => Move(move: index, sign: "", userName: ""));

  bool xTurn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Detail View'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: _moves.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _makeMove(
              index: index,
            ),
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    border:
                        Border.all(color: Theme.of(context).colorScheme.error)),
                child: Center(
                  child: Text(
                    _moves[index].sign ?? "",
                    style: TextStyle(
                        fontSize: 32, // Yazı boyutunu ayarlayabilirsiniz
                        fontWeight: FontWeight.bold, // Yazının kalınlığı
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _makeMove({required int index}) {
    String currentUser = xTurn ? 'Player 1' : 'Player 2';
    String currentSign = xTurn ? 'X' : 'O';

    if (_moves.any((x) => x.move == index && x.sign != "")) return;
    setState(() {
      xTurn = !xTurn;
      _moves.where((x) => x.move == index).first.sign = currentSign;
      _moves.where((x) => x.move == index).first.userName = currentUser;
    });
    _checkWinner();
  }

  Future<void> _checkWinner() async {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      var a = _moves
          .where((move) => move.move == combo[0] && move.sign != "")
          .firstOrNull;
      var b = _moves
          .where((move) => move.move == combo[1] && move.sign != "")
          .firstOrNull;
      var c = _moves
          .where((move) => move.move == combo[2] && move.sign != "")
          .firstOrNull;

      if (a != null && b != null && c != null) {
        if (a.sign == b.sign && b.sign == c.sign) {
          ScaffoldMessenger.maybeOf(context)!.showSnackBar(
              SnackBar(content: Text("Winner is " + a.userName!)));
          await Future.delayed(Duration(seconds: 3));
          _moves.clear();
          setState(() {
            _moves = List.generate(
                9, (index) => Move(move: index, sign: "", userName: ""));
          });
        }
      }
    }

    if (_moves.where((x) => x.sign != "").length == 9) {
      _moves.clear();
      setState(() {
        _moves = List.generate(
            9, (index) => Move(move: index, sign: "", userName: ""));
      });
    }
  }
}
