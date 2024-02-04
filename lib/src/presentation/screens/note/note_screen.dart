import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/presentation/widgets/color_random_dialog.dart';
import 'package:heydodo/src/presentation/widgets/icon_action_with_label.dart';
import 'package:heydodo/src/presentation/widgets/title_edit_dialog.dart';

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
        backgroundColor: Color(_note.color ?? HeyDoDoColors.white.value),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _onSaveNote(_note);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: heyDoDoPadding * 4,
              color: HeyDoDoColors.primary,
            ),
          ),
          backgroundColor: Color(_note.color ?? HeyDoDoColors.white.value),
          surfaceTintColor: Color(_note.color ?? HeyDoDoColors.white.value),
          actions: [
            IconAction(
                icon: Icons.more_vert,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: HeyDoDoColors.white,
                      builder: (context) => Container(
                            width: double.infinity,
                            height: 300.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 21.0),
                            decoration: const BoxDecoration(
                                color: HeyDoDoColors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24.0),
                                    topLeft: Radius.circular(24.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Opciones',
                                  style: TextStyle(
                                      color: HeyDoDoColors.secondary,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: heyDoDoPadding * 3,
                                ),
                                IconActionWithLabel(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _onSaveNote(_note);

                                    Navigator.of(context).pop();
                                  },
                                  icon: Icons.save_outlined,
                                  label: 'Guardar',
                                ),
                                const SizedBox(
                                  height: heyDoDoPadding + 5,
                                ),
                                IconActionWithLabel(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _onPickImage(_note);
                                  },
                                  icon: Iconsax.gallery_add,
                                  label: 'Agregar imagen',
                                ),
                                const SizedBox(
                                  height: heyDoDoPadding,
                                ),
                                IconActionWithLabel(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    int? color = await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const ColorRandomDialog());

                                    if (color != null) {
                                      _note.color = color;
                                      _onSaveNote(_note);

                                      setState(() {});
                                    }
                                  },
                                  icon: Iconsax.paintbucket,
                                  label: 'Cambiar color de fondo',
                                ),
                                const SizedBox(
                                  height: heyDoDoPadding,
                                ),
                                IconActionWithLabel(
                                  onPressed: () async {
                                    int? color = await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const ColorRandomDialog());

                                    if (color != null) {
                                      _note.textColor = color;
                                      _onSaveNote(_note);
                                      setState(() {});
                                    }
                                    if (!mounted) return;
                                    Navigator.of(context).pop();
                                  },
                                  icon: Iconsax.color_swatch,
                                  label: 'Cambiar color de texto',
                                ),
                                const SizedBox(
                                  height: heyDoDoPadding,
                                ),
                              ],
                            ),
                          ));
                }),
            const SizedBox(
              width: heyDoDoPadding,
            ),
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
                                    color: Color(
                                      _note.textColor ??
                                          HeyDoDoColors.light.value,
                                    ),
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
                            child: const Icon(Iconsax.edit),
                          ),
                          const SizedBox(
                            width: 3.5,
                          )
                        ],
                      ))),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: heyDoDoPadding,
                    ),
                  ),
                  StreamBuilder<NoteEntity>(
                    stream: _bloC.stream,
                    initialData: _note,
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
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.all(heyDoDoPadding),
                      child: TextFormField(
                        controller: _noteController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        cursorColor: Color(
                          _note.textColor ?? HeyDoDoColors.light.value,
                        ),
                        minLines: q.height.toInt(),
                        maxLines: q.height.toInt(),
                        style: TextStyle(
                            color: Color(
                              _note.textColor ?? HeyDoDoColors.light.value,
                            ),
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
}
