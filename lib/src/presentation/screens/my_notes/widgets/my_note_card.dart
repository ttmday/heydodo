import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/widgets/card.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/note_provider.dart';
import 'package:heydodo/src/presentation/screens/screens.dart';

class MyNoteCard extends StatelessWidget {
  const MyNoteCard({
    super.key,
    required this.note,
  });

  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return HeyDoDoCard(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NoteScreen(note: note)));
        },
        title: note.title ?? '',
        subtitle: note.dateFormatted,
        body: note.note,
        color: note.color != null ? Color(note.color!) : null,
        textColor: Color(note.textColor ?? HeyDoDoColors.white.value),
        actions: [
          GestureDetector(
            onTap: () {
              showHeyDoDoAlert(
                  context: context,
                  title: 'Confirmar',
                  content: HeyDoDoDialogAlertContentText(text: [
                    const TextSpan(
                        text:
                            'Al presionar continuar se eliminará permanentemente la nota '),
                    TextSpan(
                        text: '${note.title}',
                        style: const TextStyle(
                            color: HeyDoDoColors.medium, fontSize: 18))
                  ]),
                  buttons: [
                    const HeyDoDoAlertButtonConfirm(label: 'Continuar'),
                    const SizedBox(
                      width: heyDoDoPadding * 2,
                    ),
                    const HeyDoDoAlertButtonCancel(label: 'Cancelar')
                  ]).then((value) {
                if (value != null &&
                    value == HeyDoDoDialogAlertRole.confirmed) {
                  context.read<NoteProvider>().remove(note.id);
                }
              });
            },
            child: SizedBox(
              child: Icon(
                Iconsax.trash,
                color: Color(note.textColor ?? HeyDoDoColors.white.value),
                size: heyDoDoPadding * 3,
              ),
            ),
          ),
          const SizedBox(
            width: heyDoDoPadding / 2,
          ),
          GestureDetector(
            onTap: () {
              note.isFixed = note.isFixed ? !note.isFixed : true;
              context.read<NoteProvider>().write(note);
            },
            child: SizedBox(
              child: Icon(
                note.isFixed ? Icons.push_pin : Icons.push_pin_outlined,
                color: Color(note.textColor ?? HeyDoDoColors.white.value),
                size: heyDoDoPadding * 3,
              ),
            ),
          ),
          const SizedBox(
            width: heyDoDoPadding / 2,
          ),
          GestureDetector(
            onTap: () {
              note.isFavorite = note.isFavorite ? !note.isFavorite : true;
              context.read<NoteProvider>().write(note);
            },
            child: SizedBox(
              child: Icon(
                note.isFavorite ? Icons.star_sharp : Icons.star_outline_sharp,
                color: Color(note.textColor ?? HeyDoDoColors.white.value),
                size: heyDoDoPadding * 3,
              ),
            ),
          ),
          const SizedBox(
            width: heyDoDoPadding / 2,
          ),
        ],
      );
    });
  }
}
