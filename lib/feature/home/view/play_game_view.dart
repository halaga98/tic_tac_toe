import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/feature/home/view/mixin/play_game_view_mixin.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/home_state.dart';
import 'package:tic_tac_toe/product/state/base/base_state.dart';

@RoutePage<bool?>()
final class PlayGameView extends StatefulWidget {
  PlayGameView({required this.id, super.key});
  final String id;

  @override
  State<PlayGameView> createState() => _PlayGameViewState();
}

class _PlayGameViewState extends BaseState<PlayGameView>
    with PlayGameViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeViewModel,
      child: BlocListener<HomeViewModel, HomeState>(
        listener: (context, state) {},
        child: BlocSelector<HomeViewModel, HomeState, Game?>(
          selector: (state) {
            return state.game ?? null;
          },
          builder: (context, state) {
            if (state == null) return CircularProgressIndicator.adaptive();
            if (state.status == "done") {
              showWinner(state.winner!);
            }
            showTurn(state.turn);
            return Scaffold(
              appBar: AppBar(
                title: Text(showTurn(state.turn)),
              ),
              body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: pow(state.board.length, 1 / 2).ceil(),
                ),
                itemCount: state.board.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => makeMove(index: index, game: state),
                    child: GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(state.backgroundColor),
                        ),
                        margin: EdgeInsets.all(2),
                        child: Center(
                          child: Text(
                            state.board[index].sign ?? "",
                            style: TextStyle(
                                fontSize:
                                    32, // Yazı boyutunu ayarlayabilirsiniz
                                fontWeight:
                                    FontWeight.bold, // Yazının kalınlığı
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
