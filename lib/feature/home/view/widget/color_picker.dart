import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tic_tac_toe/feature/home/view_model/create_game_view_model.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/create_game_state.dart';

class ColorPickerWidget extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ColorPickerWidget({
    super.key,
    required this.onColorSelected,
  });
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  void pickColor(BuildContext context, CreateGameState state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: (state.gridColor),
              onColorChanged: (Color color) => widget.onColorSelected(color),
              pickerAreaHeightPercent: 0.8, // Renk havuzunu genişletmek için
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Select'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGameViewModel, CreateGameState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                pickColor(context, state);
              },
              child: Container(
                color: state.gridColor,
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    'Tap to pick color',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 158, 36, 36)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Text(
                'Selected Color: ${state.gridColor}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
