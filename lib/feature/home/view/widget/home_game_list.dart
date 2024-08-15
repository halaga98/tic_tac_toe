import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/product/navigation/app_router.dart';

/// HomeUserList widget
final class HomeGameList extends StatelessWidget {
  const HomeGameList({required this.games, super.key});
  final List<Game> games;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        final game = games[index];
        int grid = pow(game.board.length, 1 / 2).ceil();

        return Column(
          children: [
            ListTile(
              onTap: () {
                if (game.status == "waiting")
                  context.router.push(CreateGameRoute(id: game.id));
              },
              title: Text(game.name),
              trailing: Text(grid.toString() + "X" + grid.toString()),
              subtitle: Text(game.status == "done"
                  ? "Winner is ${game.winner}"
                  : game.status),
              leading: Text(game.creator),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
