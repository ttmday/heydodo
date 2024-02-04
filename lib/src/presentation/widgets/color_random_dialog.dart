import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/colors_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/colors_provider.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';

class ColorRandomDialog extends StatefulWidget {
  const ColorRandomDialog({super.key});

  @override
  State<ColorRandomDialog> createState() => _ColorRandomDialogState();
}

class _ColorRandomDialogState extends State<ColorRandomDialog> {
  final TextEditingController _controller = TextEditingController();
  late Color _color;

  @override
  void initState() {
    _color = _generateRandomColor();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsProvider>(builder: (context, provider, _) {
      final colors = provider.colors;
      return HeyDoDoDialogAlert(
        title: '',
        content: Column(
          children: [
            const SizedBox(
              height: heyDoDoPadding * 2,
            ),
            const HeyDoDoDialogAlertContentText(
              text: [
                TextSpan(
                    text: 'Pulsa encima del color para generar uno nuevo',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300))
              ],
            ),
            const SizedBox(
              height: heyDoDoPadding * 2,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _color = _generateRandomColor();
                });

                int id = provider.colors
                    .indexWhere((element) => element.color == _color.value);

                if (id == -1) {
                  provider.write(ColorEntity(_color.value));
                }
              },
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: _color,
              ),
            ),
            const SizedBox(
              height: heyDoDoPadding * 2,
            ),
            if (colors.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 70.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: colors.length,
                        itemBuilder: (context, index) {
                          final color = Color(colors[index].color);
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: heyDoDoPadding),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _color = color;
                                });
                              },
                              onLongPress: () {
                                provider.remove(colors[index].id);
                              },
                              child: CircleAvatar(
                                  radius: 20.0, backgroundColor: color),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: heyDoDoPadding * 2,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Crea tu color',
                style: TextStyle(
                    color: HeyDoDoColors.secondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(
              height: heyDoDoPadding,
            ),
            TextFormField(
              controller: _controller,
              cursorColor: HeyDoDoColors.secondary,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: HeyDoDoColors.secondary, fontSize: 16.0),
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HeyDoDoColors.secondary)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HeyDoDoColors.secondary)),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HeyDoDoColors.secondary))),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
            ),
            const SizedBox(
              height: heyDoDoPadding + 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  String value = _controller.text;
                  final c = int.parse('0xff$value');
                  int id = provider.colors
                      .indexWhere((element) => element.color == c);

                  if (id == -1) {
                    provider.write(ColorEntity(c));
                  }

                  _controller.clear();
                  FocusScope.of(context).unfocus();
                },
                child: const Text(
                  'Crear',
                  style: TextStyle(
                      color: HeyDoDoColors.secondary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
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
    });
  }

  Color _generateRandomColor() {
    int r = Random().nextInt(255);
    int g = Random().nextInt(255);
    int b = Random().nextInt(255);

    return Color.fromRGBO(r, g, b, 1);
  }
}
