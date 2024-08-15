import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  final ValueNotifier<Color> _colorNotifier = ValueNotifier<Color>(Colors.blue);

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: (_colorNotifier.value),
              onColorChanged: (Color color) {
                widget.onColorSelected(color);
                _colorNotifier.value = color;
              },
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
    return ValueListenableBuilder<Color>(
      valueListenable: _colorNotifier,
      builder: (BuildContext context, Color value, child) {
        return ListTile(
          onTap: () => pickColor(context),
          title: Text("Grid Color Değiştirmek İçin Tıklayınız"),
          leading: Icon(
            Icons.lens,
            color: value,
          ),
        );
      },
    );
  }
}
