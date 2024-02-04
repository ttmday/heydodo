import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

class AddNewToDo extends StatelessWidget {
  const AddNewToDo(
      {super.key, required this.onSaved, required this.controller});

  final void Function(String) onSaved;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(heyDoDoPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ToDo',
              style: TextStyle(color: HeyDoDoColors.light, fontSize: 12.0),
            ),
            const SizedBox(
              height: heyDoDoPadding,
            ),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              onSaved: (String? value) {
                onSaved(value ?? '');
              },
              cursorColor: HeyDoDoColors.light,
              style:
                  const TextStyle(color: HeyDoDoColors.light, fontSize: 16.0),
              decoration: InputDecoration(
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            controller.clear();
                          },
                          icon: const Icon(Icons.cancel,
                              color: HeyDoDoColors.medium))
                      : null,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: HeyDoDoColors.secondary)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: HeyDoDoColors.secondary)),
                  errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: HeyDoDoColors.secondary))),
            ),
            const SizedBox(
              height: heyDoDoPadding * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: heyDoDoPadding,
                ),
                GestureDetector(
                  onTap: () {
                    onSaved(controller.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: heyDoDoPadding * 5,
                        vertical: heyDoDoPadding),
                    decoration: BoxDecoration(
                        color: HeyDoDoColors.secondary,
                        borderRadius: BorderRadius.circular(24.0)),
                    child: const Text(
                      'Crear',
                      style: TextStyle(
                          color: HeyDoDoColors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
