import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/presentation/lib/helpers/image_picker.dart';
import 'package:heydodo/src/presentation/screens/note/bloc/note_bloc.dart';
import 'package:heydodo/src/presentation/widgets/button.dart';
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
      context.read<NoteProvider>().write(note);
    }
    _noteController.clear();
    _titleController.clear();
    Navigator.of(context).pop();
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
    _noteController.dispose();
    _titleController.dispose();
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
            },
            icon: const Icon(
              Icons.arrow_back,
              size: heyDoDoPadding * 4,
              color: HeyDoDoColors.light,
            ),
          ),
          backgroundColor: HeyDoDoColors.white,
          surfaceTintColor: HeyDoDoColors.white,
          title: Text(
            'Nota',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: HeyDoDoColors.light, fontSize: 22.0),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            child: CustomScrollView(
              slivers: [
                StreamBuilder<NoteEntity>(
                  stream: _bloC.stream,
                  builder: (context, snapshot) {
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
                    height: heyDoDoPadding * 2,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(heyDoDoPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Título:',
                          softWrap: true,
                          style: TextStyle(
                              color: HeyDoDoColors.light, fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: heyDoDoPadding,
                        ),
                        TextFormField(
                          controller: _titleController,
                          cursorColor: HeyDoDoColors.light,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: HeyDoDoColors.light, fontSize: 18.0),
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.all(heyDoDoPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nota:',
                          style: TextStyle(
                              color: HeyDoDoColors.light, fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 3.5,
                        ),
                        Expanded(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(heyDoDoPadding * 2),
          child: HeyDoDoButton(
            onPressed: () {
              _onSaveNote(_note);
            },
            label: 'Guardar',
          ),
        ),
      ),
    );
  }
}
