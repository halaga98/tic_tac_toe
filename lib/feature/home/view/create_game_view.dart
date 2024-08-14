import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tic_tac_toe/feature/home/view/mixin/create_game_view_mixin.dart';
import 'package:tic_tac_toe/feature/home/view/widget/color_picker.dart';

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
        create: (context) => createGameViewModel,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            createGameViewModel.changeColor(Colors.redAccent);
          }),
          appBar: AppBar(
            title: Text('Create a New Game'),
          ),
          body: Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: gameNameController,
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
                  ),
                  ElevatedButton(
                    onPressed: createGame,
                    child: Text('Create Game'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
