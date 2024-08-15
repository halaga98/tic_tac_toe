import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/feature/home/model/move.dart';
import 'package:tic_tac_toe/feature/home/view/play_game_view.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/product/navigation/app_router.dart';
import 'package:tic_tac_toe/product/state/base/base_state.dart';

/// Manage your home view business logic
mixin PlayGameViewMixin on BaseState<PlayGameView> {
  late final HomeViewModel _homeViewModel;
  late String myName;
  HomeViewModel get homeViewModel => _homeViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      myName = await giveMyName();
    });
    _homeViewModel = HomeViewModel();
    _homeViewModel.getGame(widget.id);
    _homeViewModel.listenGame(widget.id);
  }

  Future<void> makeMove({required int index, required Game game}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String playerName = prefs.getString('username')!;

    List<Move> moves = game.board;

    String currentUser = game.turn;
    String currentSign = game.turn == game.creator ? 'X' : 'O';

    if (game.turn != playerName) return;
    if (moves.any((x) => x.move == index && x.sign != "")) return;
    game.turn = game.turn == game.creator ? game.opponent! : game.creator;
    moves.where((x) => x.move == index).first.sign = currentSign;
    moves.where((x) => x.move == index).first.userName = currentUser;

    await FirebaseFirestore.instance
        .collection('games')
        .doc(game.id)
        .update(game.toMap());

    checkWinner(game);
  }

  Future<void> checkWinner(Game game) async {
    List<Move> moves = game.board;
    List<List<int>> winningCombinations =
        _getWinningCombinations(pow(moves.length, 1 / 2).ceil());

    for (var combo in winningCombinations) {
      // İlk hamleyi al
      var firstMove = moves
          .where((move) => move.move == combo[0] && move.sign != "")
          .firstOrNull;

      if (firstMove == null) {
        continue; // İlk hamle boşsa bu kombinasyonu geç
      }

      bool hasWon = true;

      for (int i = 1; i < combo.length; i++) {
        var nextMove = moves
            .where((move) => move.move == combo[i] && move.sign != "")
            .firstOrNull;

        if (nextMove == null || nextMove.sign != firstMove.sign) {
          hasWon = false;
          break;
        }
      }

      if (hasWon) {
        await FirebaseFirestore.instance
            .collection('games')
            .doc(game.id)
            .update({"status": "done", "winner": firstMove.userName});
        return;
      }
    }

    if (moves.where((x) => x.sign != "").length == moves.length) {
      int oldLength = moves.length;
      List<Map<String, dynamic>> board = List.generate(
        oldLength,
        (index) => Move(move: index, sign: "", userName: "").toJson(),
      );

      await FirebaseFirestore.instance
          .collection('games')
          .doc(game.id)
          .update({"board": board});
    }
  }

  Future<void> showWinner(String winner) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.maybeOf(context)!
          .showSnackBar(SnackBar(content: Text("Winner is " + winner)));
    });

    await Future.delayed(Duration(seconds: 3));

    context.router.replace(HomeRoute());
  }

  String showTurn(String turn) {
    if (myName == turn)
      return "Your turn";
    else
      return "Oppent turn";
  }

  Future<String> giveMyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username')!;
  }

  List<List<int>> _getWinningCombinations(int gridSize) {
    if (gridSize == 3) {
      return [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
      ];
    } else if (gridSize == 4) {
      return [
        [0, 1, 2, 3],
        [4, 5, 6, 7],
        [8, 9, 10, 11],
        [12, 13, 14, 15],
        [0, 4, 8, 12],
        [1, 5, 9, 13],
        [2, 6, 10, 14],
        [3, 7, 11, 15],
        [0, 5, 10, 15],
        [3, 6, 9, 12],
      ];
    } else if (gridSize == 5) {
      return [
        [0, 1, 2, 3, 4],
        [5, 6, 7, 8, 9],
        [10, 11, 12, 13, 14],
        [15, 16, 17, 18, 19],
        [20, 21, 22, 23, 24],
        [0, 5, 10, 15, 20],
        [1, 6, 11, 16, 21],
        [2, 7, 12, 17, 22],
        [3, 8, 13, 18, 23],
        [4, 9, 14, 19, 24],
        [0, 6, 12, 18, 24],
        [4, 8, 12, 16, 20],
      ];
    } else
      return [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
      ];
  }
}
