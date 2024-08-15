import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/feature/home/model/move.dart';
import 'package:tic_tac_toe/feature/home/view/create_game_view.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/product/navigation/app_router.dart';

import 'package:tic_tac_toe/product/state/base/base_state.dart';

/// Manage your home view business logic
mixin CreateGameViewMixin on BaseState<CreateGameView> {
  late final HomeViewModel _homeViewModel;
  var db = FirebaseFirestore.instance;
  HomeViewModel get homeViewModel => _homeViewModel;

  @override
  void initState() {
    _homeViewModel = HomeViewModel();

    if (widget.id != null) {
      connectGame(widget.id!);
      update(widget.id!);
    }
    super.initState();
  }

  @override
  void dispose() {
    disconnectGame();
    super.dispose();
  }

  //oppennt actions
  Future<void> update(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String playerName = prefs.getString('username')!;
    await db
        .collection('games')
        .doc(id)
        .update({"status": "ready", "opponent": playerName});
  }

  //connect game and listen firebase
  late DocumentReference gameRef;

  void connectGame(String gameId) {
    gameRef = db.collection('games').doc(gameId);

    _homeViewModel.changeStream(gameRef.snapshots());
  }

  void disconnectGame() {
    _homeViewModel.changeStream(null);
  }

// Create Game Fonction and utils

  final formKey = GlobalKey<FormState>();
  final TextEditingController gameNameController = TextEditingController();
  String gridViewCount = "3x3";
  Color gridColor = Colors.blue;
  Future<void> createGame() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String playerName = prefs.getString('username')!;
    List<Move> board = List.generate(
      int.parse(gridViewCount[0]) * int.parse(gridViewCount[0]),
      (index) => Move(move: index, sign: "", userName: ""),
    );

    Game newGame = Game(
      name: gameNameController.text,
      creator: playerName,
      board: board,
      turn: playerName,
      status: 'waiting',
      backgroundColor: gridColor.value,
    );

    var data = await db.collection('games').add(newGame.toMap());
    connectGame(data.id);
  }

  Future<void> startGame(String id) async {
    await FirebaseFirestore.instance.collection('games').doc(id).update({
      "status": "started",
    });
    context.router.replace(PlayGameRoute(id: id));
  }
}
