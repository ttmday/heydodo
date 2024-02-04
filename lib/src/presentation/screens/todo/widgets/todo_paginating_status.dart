import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/presentation/lib/providers/todo_provider.dart';
import 'package:heydodo/src/presentation/screens/todo/bloc/todo_bloc.dart';

class TodoPaginatingStatus extends StatelessWidget {
  const TodoPaginatingStatus({
    super.key,
    required TodoBloC bloC,
  }) : _bloC = bloC;

  final TodoBloC _bloC;

  @override
  Widget build(BuildContext context) {
    Size q = MediaQuery.of(context).size;

    return Consumer<ToDoProvider>(builder: (context, provider, _) {
      final complete = provider.todos
          .where(
            (element) => element.isCompleted == true,
          )
          .length;
      final pending = (complete - provider.todos.length).abs();
      if (pending == 0 && complete == 0) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverPadding(
          padding: const EdgeInsets.all(heyDoDoPadding),
          sliver: SliverToBoxAdapter(
              child: SizedBox(
                  width: q.width,
                  height: 65.0,
                  child: StreamBuilder<int>(
                      stream: _bloC.paginatorStream,
                      initialData: 0,
                      builder: (context, snapshot) {
                        return Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<ToDoProvider>(
                                    builder: (context, provider, _) {
                                  return PageLabel(
                                      onPressed: () => _bloC.setCurrentPage(0),
                                      label: 'Pendientes',
                                      isActive: snapshot.data == 0,
                                      badge: pending);
                                }),
                                const SizedBox(
                                  width: heyDoDoPadding,
                                ),
                                PageLabel(
                                  onPressed: () => _bloC.setCurrentPage(1),
                                  label: 'Completados',
                                  isActive: snapshot.data == 1,
                                  badge: complete,
                                ),
                              ],
                            ),
                            AnimatedPositioned(
                              bottom: 0,
                              left: snapshot.data == 0
                                  ? (115 + 24) / 2
                                  : (336 - (190 + 24) / 2),
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeInOutQuad,
                              child: Container(
                                width: 9.0,
                                height: 9.0,
                                decoration: const BoxDecoration(
                                    color: HeyDoDoColors.medium,
                                    shape: BoxShape.circle),
                              ),
                            )
                          ],
                        );
                      }))));
    });
  }
}

class PageLabel extends StatelessWidget {
  const PageLabel(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.isActive,
      this.width,
      required this.badge});

  final void Function()? onPressed;
  final String label;
  final bool isActive;
  final double? width;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? HeyDoDoColors.medium
                    : HeyDoDoColors.medium.withOpacity(.45),
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              width: heyDoDoPadding,
            ),
            Container(
              width: 21.0,
              height: 21.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: HeyDoDoColors.secondary, shape: BoxShape.circle),
              child: Text(
                badge.toString(),
                style:
                    const TextStyle(color: HeyDoDoColors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
