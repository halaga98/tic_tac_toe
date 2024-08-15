import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';

import 'package:tic_tac_toe/feature/home/view/mixin/create_game_view_mixin.dart';
import 'package:tic_tac_toe/feature/home/view/widget/color_picker.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/home_state.dart';
import 'package:tic_tac_toe/product/navigation/app_router.dart';

import 'package:tic_tac_toe/product/state/base/base_state.dart';

@RoutePage()
class CreateGameView extends StatefulWidget {
  const CreateGameView({super.key, this.id});

  @override
  _CreateGameViewState createState() => _CreateGameViewState();
  final String? id;
}

class _CreateGameViewState extends BaseState<CreateGameView>
    with CreateGameViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeViewModel,
      child: BlocListener<HomeViewModel, HomeState>(
        listener: (context, state) {},
        child: BlocSelector<HomeViewModel, HomeState,
            Stream<DocumentSnapshot<Object?>>?>(
          selector: (state) {
            return state.gameStream ?? null;
          },
          builder: (context, state) {
            return StreamBuilder<DocumentSnapshot>(
                stream: state,
                builder: (context, snapshot) {
                  var gameData = snapshot.data ?? null;
                  Game? game;
                  if (gameData != null) {
                    game = Game.fromDocument(gameData);
                    gameNameController.text = game.name;
                    int grid = pow(game.board.length, 1 / 2).ceil();
                    gridViewCount = grid.toString() + "x" + grid.toString();
                    if (game.status == "started") {
                      context.router.replace(PlayGameRoute(id: game.id!));
                    }
                  }
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Create a New Game'),
                      actions: [if (game != null) Text(game.status)],
                    ),
                    body: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: gameNameController,
                              readOnly: game != null,
                              decoration: InputDecoration(
                                labelText: 'Game Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? 'Cannot be empty'
                                    : null;
                              },
                            ),
                            SizedBox(height: 20),
                            ColorPickerWidget(
                              onColorSelected: (Color color) {
                                if (game != null) return;
                                gridColor = color;
                              },
                            ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: gridViewCount, // Default value
                              items: ["3x3", "4x4", "5x5"].map((String value) {
                                return DropdownMenuItem<String>(
                                  enabled: game == null,
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Handle change
                                if (newValue != null) {
                                  gridViewCount = newValue.toString();
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Select a number for grid',
                                border: OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                return (value == null)
                                    ? 'Cannot be empty'
                                    : null;
                              },
                            ),
                            if (game != null)
                              Column(
                                children: [
                                  Text("Participant"),
                                  Text(game.opponent ?? "Waiting"),
                                  Text(game.creator),
                                ],
                              ),
                            if (widget.id == null)
                              if (game?.status == "ready")
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () => startGame(game!.id!),
                                    child: Text('Start Game'),
                                  ),
                                )
                              else
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: createGame,
                                    child: Text('Create Game'),
                                  ),
                                )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
