import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/feature/home/model/move.dart';
import 'package:tic_tac_toe/feature/home/view/create_game_view.dart';
import 'package:tic_tac_toe/feature/home/view_model/create_game_view_model.dart';

import 'package:tic_tac_toe/product/state/base/base_state.dart';

import 'package:flutter/services.dart';

/// Manage your home view business logic
mixin CreateGameViewMixin on BaseState<CreateGameView> {
  late final CreateGameViewModel _createGameViewModel;

  CreateGameViewModel get createGameViewModel => _createGameViewModel;

  @override
  void initState() {
    super.initState();

    _createGameViewModel = CreateGameViewModel();
  }

// Create Game Fonction and utils

  final formKey = GlobalKey<FormState>();
  final TextEditingController gameNameController = TextEditingController();
  final TextEditingController gridViewCount = TextEditingController();

  Future<void> createGame() async {
    if (formKey.currentState!.validate()) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String playerName = prefs.getString('player_name') ?? "";
    List<Move> board = List.generate(
      int.parse(gridViewCount.text),
      (index) => Move(move: index, sign: "", userName: ""),
    );

    Game newGame = Game(
      name: gameNameController.text,
      creator: playerName,
      board: board,
      turn: playerName,
      status: 'waiting',
      backgroundColor: createGameViewModel.state.gridColor.value,
    );

    FirebaseFirestore.instance.collection('games').add(newGame.toMap());
  }
}
