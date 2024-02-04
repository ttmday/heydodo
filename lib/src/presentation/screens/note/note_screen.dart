import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/widgets/color_random_dialog.dart';
import 'package:heydodo/src/presentation/widgets/title_edit_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/presentation/widgets/icon_action.dart';
import 'package:heydodo/src/presentation/lib/helpers/image_picker.dart';
import 'package:heydodo/src/presentation/screens/note/bloc/note_bloc.dart';

import 'package:heydodo/src/presentation/widgets/dialog.dart';
import 'package:heydodo/src/presentation/widgets/image_container.dart';

import 'package:image_picker/image_picker.dart';

import 'package:heydodo/src/config/constants/colors.dart';

import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/note_provider.dart';

class NoteScreen extends StatefulWidget {
  final NoteEntity note;
  const NoteScreen({required this.note, super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _noteController;
  late final ImageHelper _imageHelper;

  late final NoteEntity _note;

  late final NoteBloC _bloC;

  @override
  void initState() {
    _note = widget.note;
    _bloC = NoteBloC()..init(_note);
    _imageHelper = ImageHelper(imagePicker: ImagePicker());

    _titleController = TextEditingController(
        text: widget.note.title ?? widget.note.dateFormatted);
    _noteController = TextEditingController(text: widget.note.note);

    super.initState();
  }

  _onSaveNote(NoteEntity note) {
    if (_noteController.text.isNotEmpty) {
      note.note = _noteController.text;
      note.title = _titleController.text;
      note.color = note.color;
      _bloC.update(note);
      context.read<NoteProvider>().write(note);
    }
  }

  _onPickImage(NoteEntity note) async {
    try {
      final file = await _imageHelper.pick();
      if (file == null) return;

      final bytes = _imageHelper.toBytes(file: file);
      note.image = bytes;
      _bloC.update(note);
      if (!mounted) return;

      context.read<NoteProvider>().write(note);
    } catch (e) {
      showHeyDoDoAlert(
          context: context,
          title: '¡Oh no!',
          content: const HeyDoDoDialogAlertContentText(text: [
            TextSpan(text: 'Al parecer algo ha salido muy mal'),
          ]),
          buttons: [
            const HeyDoDoAlertButtonConfirm(label: 'Aceptar'),
          ]);
    }
  }

  _onDeleteImage(NoteEntity note) {
    note.image = null;
    _bloC.update(note);

    context.read<NoteProvider>().write(note);
  }

  @override
  void dispose() {
    _titleController.clear();
    _noteController.clear();
    _noteController.dispose();
    _titleController.dispose();
    _bloC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size q = MediaQuery.of(context).size;
    return BackButtonListener(
      onBackButtonPressed: () async {
        _onSaveNote(_note);
        return true;
      },
      child: Scaffold(
        backgroundColor: HeyDoDoColors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _onSaveNote(_note);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: heyDoDoPadding * 4,
              color: HeyDoDoColors.light,
            ),
          ),
          backgroundColor: HeyDoDoColors.white,
          surfaceTintColor: HeyDoDoColors.white,
          actions: [
            StreamBuilder<NoteEntity>(
                stream: _bloC.stream,
                builder: (context, snapshot) {
                  return IconAction(
                    onPressed: () async {
                      int? color = await showDialog(
                          context: context,
                          builder: (context) => const ColorRandomDialog());

                      if (color != null) {
                        _note.color = color;
                        _onSaveNote(_note);
                      }
                    },
                    icon: Iconsax.colors_square,
                    iconColor: snapshot.data?.color != null
                        ? Color(snapshot.data!.color!)
                        : HeyDoDoColors.secondary,
                  );
                }),
            const SizedBox(
              width: heyDoDoPadding,
            ),
            IconAction(
              onPressed: () {
                _onPickImage(_note);
              },
              icon: Iconsax.gallery_add,
            ),
            const SizedBox(
              width: heyDoDoPadding,
            ),
            IconAction(
              onPressed: () {
                _onSaveNote(_note);
                Navigator.of(context).pop();
              },
              icon: Icons.save,
            ),
            const SizedBox(
              width: heyDoDoPadding + 5,
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                      padding: const EdgeInsets.all(heyDoDoPadding),
                      sliver: SliverToBoxAdapter(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              _titleController.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: HeyDoDoColors.light,
                                    fontSize: 18.0,
                                  ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => TitleEditDialog(
                                      oldText: _titleController.text,
                                      controller: _titleController));
                            },
                            child: const SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: Icon(Iconsax.edit),
                            ),
                          )
                        ],
                      ))),
                  StreamBuilder<NoteEntity>(
                    stream: _bloC.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data?.image == null) {
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      }
                      return SliverAppBar(
                          automaticallyImplyLeading: false,
                          collapsedHeight: 240.0,
                          expandedHeight: 240.0,
                          flexibleSpace: ImageContainer(
                            image: snapshot.data?.image,
                            onImageTap: () => _onPickImage(_note),
                            onImageDelete: () => _onDeleteImage(_note),
                          ));
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: heyDoDoPadding,
                    ),
                  ),
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.all(heyDoDoPadding),
                      child: TextFormField(
                        controller: _noteController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        cursorColor: HeyDoDoColors.light,
                        minLines: q.height.toInt(),
                        maxLines: q.height.toInt(),
                        style: const TextStyle(
                            color: HeyDoDoColors.light,
                            fontSize: heyDoDoPadding + 11.0),
                        decoration: const InputDecoration(
                            hintText:
                                'Describe tus ideas, crea increibles historias, escribe tus días',
                            hintStyle: TextStyle(
                                color: HeyDoDoColors.light,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
