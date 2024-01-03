import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/presentation/providers/note_provider.dart';
import 'package:heydodo/src/presentation/screens/screens.dart';

class MyNoteCard extends StatelessWidget {
  const MyNoteCard({
    super.key,
    required this.note,
  });

  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: heyDoDoPadding + 5, vertical: heyDoDoPadding),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteScreen(note: note)));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: heyDoDoPadding * 2, vertical: heyDoDoPadding),
              height: 110.0,
              decoration: BoxDecoration(
                  color: HeyDoDoColors.secondary,
                  borderRadius: BorderRadius.circular(24.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          note.title ?? '',
                          style: const TextStyle(
                              color: HeyDoDoColors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: heyDoDoPadding,
                  ),
                  Text(
                    note.dateFormatted,
                    style: const TextStyle(
                        color: HeyDoDoColors.light,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: heyDoDoPadding,
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note.note,
                      maxLines: 3,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: HeyDoDoColors.light,
                          fontSize: 14.0),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Positioned(
              top: heyDoDoPadding,
              right: heyDoDoPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<NoteProvider>().remove(note.id);
                    },
                    child: const SizedBox(
                      child: Icon(
                        Iconsax.trash,
                        color: HeyDoDoColors.light,
                        size: heyDoDoPadding * 3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: heyDoDoPadding / 2,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const SizedBox(
                      child: Icon(
                        Icons.share_outlined,
                        color: HeyDoDoColors.light,
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
                        color: HeyDoDoColors.light,
                        size: heyDoDoPadding * 3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      note.isFavorite =
                          note.isFavorite ? !note.isFavorite : true;
                      context.read<NoteProvider>().write(note);
                    },
                    child: SizedBox(
                      child: Icon(
                        note.isFavorite
                            ? Icons.star_sharp
                            : Icons.star_outline_sharp,
                        color: HeyDoDoColors.light,
                        size: heyDoDoPadding * 3,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
