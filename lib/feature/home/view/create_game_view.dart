import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';

import 'package:tic_tac_toe/feature/home/view/mixin/create_game_view_mixin.dart';
import 'package:tic_tac_toe/feature/home/view/widget/color_picker.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/home_state.dart';

import 'package:tic_tac_toe/product/state/base/base_state.dart';

@RoutePage()
class CreateGameView extends StatefulWidget {
  @override
  _CreateGameViewState createState() => _CreateGameViewState();
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
                  late Game game;
                  if (gameData != null) {
                    game = Game.fromDocument(gameData);
                  }
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Create a New Game'),
                      actions: [if (gameData != null) Text(game.status)],
                    ),
                    body: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: gameNameController,
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
                                gridColor = color;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: gridViewCount,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Sadece rakamlara izin verir
                              ],
                              decoration: InputDecoration(
                                labelText: 'Enter a number for grid',
                                border: OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? 'Cannot be empty'
                                    : null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: createGame,
                                child: Text('Create Game'),
                              ),
                            ),
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
