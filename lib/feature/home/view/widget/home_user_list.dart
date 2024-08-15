import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';

/// HomeUserList widget
final class HomeUserList extends StatelessWidget {
  const HomeUserList({required this.games, super.key});
  final List<Game> games;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        final game = games[index];
        return ListTile(
          title: Text(game.id.toString()),
          trailing: Text(game.creator.toString() ?? ''),
          subtitle: Text(game.board.length.toString()),
        );
      },
    );
  }
}
