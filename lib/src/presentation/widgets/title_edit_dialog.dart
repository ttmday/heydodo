import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';

class TitleEditDialog extends StatelessWidget {
  const TitleEditDialog(
      {super.key, required this.oldText, required this.controller});

  final TextEditingController controller;
  final String oldText;

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        controller.text = oldText;
        return false;
      },
      child: HeyDoDoDialogAlert(
        title: 'Título',
        content: Column(
          children: [
            TextFormField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                maxLines: 4,
                inputFormatters: [LengthLimitingTextInputFormatter(200)],
                onSaved: (String? value) {
                  Navigator.pop(context);
                },
                cursorColor: HeyDoDoColors.light,
                style:
                    const TextStyle(color: HeyDoDoColors.light, fontSize: 16.0),
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none)),
          ],
        ),
        buttons: [
          const HeyDoDoAlertButtonConfirm(label: 'Aceptar'),
          const SizedBox(
            width: heyDoDoPadding,
          ),
          HeyDoDoAlertButtonCancel(
            label: 'Cancelar',
            onPressed: () {
              controller.text = oldText;

              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
