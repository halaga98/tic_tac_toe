import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/feature/home/model/move.dart';
import 'package:tic_tac_toe/feature/home/view/mixin/create_game_view_mixin.dart';
import 'package:tic_tac_toe/feature/home/view/widget/color_picker.dart';
import 'package:tic_tac_toe/feature/home/view_model/create_game_view_model.dart';

import 'package:tic_tac_toe/product/state/base/base_state.dart';

@RoutePage()
class CreateGameView extends StatefulWidget {
  @override
  _CreateGameViewState createState() => _CreateGameViewState();
}

class _CreateGameViewState extends BaseState<CreateGameView>
    with CreateGameViewMixin {
  final TextEditingController _gameNameController = TextEditingController();
  final TextEditingController _gridViewCount = TextEditingController();

  void _createGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? playerName = prefs.getString('player_name');

    FirebaseFirestore.instance.collection('games').add({
      'name': _gameNameController.text,
      'creator': playerName,
      'opponent': null,
      'board': List.generate(int.parse(_gridViewCount.text),
          (index) => Move(move: index, sign: "", userName: "")),
      'turn': playerName,
      'status': 'waiting',
      'backgroundColor': createGameViewModel.state.gridColor,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => createGameViewModel,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            createGameViewModel.changeColor(Colors.redAccent);
          }),
          appBar: AppBar(
            title: Text('Create a New Game'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _gameNameController,
                  decoration: InputDecoration(labelText: 'Game Name'),
                ),
                SizedBox(height: 20),
                Text('Select Background Color'),
                SizedBox(height: 10),
                Expanded(child: ColorPickerWidget(
                  onColorSelected: (Color color) {
                    createGameViewModel.changeColor(color);
                  },
                )),
                SizedBox(height: 20),
                TextField(
                  controller: _gridViewCount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly, // Sadece rakamlara izin verir
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter a number for grid',
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: _createGame,
                  child: Text('Create Game'),
                ),
              ],
            ),
          ),
        ));
  }
}
