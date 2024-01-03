import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:heydodo/src/config/constants/colors.dart';

import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/presentation/providers/note_provider.dart';

class NoteScreen extends StatefulWidget {
  final NoteEntity note;
  const NoteScreen({required this.note, super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _noteController;

  @override
  void initState() {
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

  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // HeyDoDoTheme.setStatusBarAndNavigationBarTheme(
    //     color: HeyDoDoColors.primary, brightness: Brightness.light);
    final note = widget.note;
    Size q = MediaQuery.of(context).size;
    return BackButtonListener(
      onBackButtonPressed: () async {
        _onSaveNote(note);
        return true;
      },
      child: Scaffold(
        backgroundColor: HeyDoDoColors.primary,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _onSaveNote(note);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: heyDoDoPadding * 4,
              color: HeyDoDoColors.light,
            ),
          ),
          backgroundColor: HeyDoDoColors.primary,
          surfaceTintColor: HeyDoDoColors.primary,
          title: Text(
            'Nota',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: HeyDoDoColors.light, fontSize: 22.0),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 3.5),
              child: GestureDetector(
                onTap: () {},
                child: const SizedBox(
                  child: Icon(
                    Icons.share,
                    color: HeyDoDoColors.light,
                    size: heyDoDoPadding * 3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: heyDoDoPadding,
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, contraints) => Container(
            decoration: const BoxDecoration(color: HeyDoDoColors.primary),
            child: Padding(
              padding: const EdgeInsets.all(heyDoDoPadding),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: HeyDoDoColors.primary,
                    surfaceTintColor: HeyDoDoColors.primary,
                    pinned: true,
                    flexibleSpace: Container(
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                        controller: _titleController,
                        maxLines: 3,
                        cursorColor: HeyDoDoColors.light,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: HeyDoDoColors.light),
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: heyDoDoPadding / 2,
                    ),
                  ),
                  SliverFillRemaining(
                    child: TextFormField(
                      controller: _noteController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      cursorColor: HeyDoDoColors.light,
                      minLines: q.height.toInt(),
                      maxLines: q.height.toInt(),
                      style: const TextStyle(
                          color: HeyDoDoColors.light,
                          fontSize: heyDoDoPadding + 12.0),
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(heyDoDoPadding * 2),
          child: GestureDetector(
            onTap: () {
              _onSaveNote(note);
            },
            child: Container(
              alignment: Alignment.center,
              height: 56.0,
              padding: const EdgeInsets.symmetric(
                  horizontal: heyDoDoPadding * 5, vertical: heyDoDoPadding * 2),
              decoration: BoxDecoration(
                  color: HeyDoDoColors.secondary,
                  borderRadius: BorderRadius.circular(24.0)),
              child: const Text(
                'Guardar',
                style: TextStyle(
                    color: HeyDoDoColors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
