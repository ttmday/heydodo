import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';

class ColorRandomDialog extends StatefulWidget {
  const ColorRandomDialog({super.key});

  @override
  State<ColorRandomDialog> createState() => _ColorRandomDialogState();
}

class _ColorRandomDialogState extends State<ColorRandomDialog> {
  late Color _color;

  @override
  void initState() {
    _color = _generateRandomColor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HeyDoDoDialogAlert(
      title: '',
      content: Column(
        children: [
          const SizedBox(
            height: heyDoDoPadding * 2,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _color = _generateRandomColor();
              });
            },
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: _color,
            ),
          ),
          const SizedBox(
            height: heyDoDoPadding * 2,
          ),
          const HeyDoDoDialogAlertContentText(
            text: [
              TextSpan(text: 'Pulsa encima del color para generar uno nuevo')
            ],
          ),
        ],
      ),
      buttons: [
        HeyDoDoAlertButtonConfirm(
          label: 'Aceptar',
          onPressed: () {
            Navigator.of(context).pop(_color.value);
          },
        ),
        const SizedBox(
          width: heyDoDoPadding,
        ),
        HeyDoDoAlertButtonCancel(
          label: 'Cancelar',
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Color _generateRandomColor() {
    int r = Random().nextInt(255);
    int g = Random().nextInt(255);
    int b = Random().nextInt(255);

    return Color.fromRGBO(r, g, b, 1);
  }
}
