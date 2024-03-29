import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heydodo/objectbox.g.dart';

import 'package:heydodo/src/presentation/lib/providers/colors_provider.dart';
import 'package:heydodo/src/presentation/lib/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/lib/providers/store_provider.dart';
import 'package:heydodo/src/presentation/lib/providers/todo_provider.dart';

import 'package:heydodo/src/config/router/router.dart';
import 'package:heydodo/src/presentation/lib/providers/note_provider.dart';

import 'package:heydodo/src/config/constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Store store = await openStore();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store store;
  const MyApp({required this.store, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => HeyDoDoRouter()),
        Provider(
          lazy: false,
          create: (context) => StoreProvider(store),
        ),
        ChangeNotifierProvider(
            lazy: false, create: (context) => NoteProvider(store)),
        ChangeNotifierProvider(
            lazy: false, create: (context) => GroupToDoProvider(store)),
        ChangeNotifierProvider(
            lazy: false, create: (context) => ToDoProvider(store)),
        ChangeNotifierProvider(create: (context) => ColorsProvider(store))
      ],
      child: Builder(builder: (context) {
        final router = context.read<HeyDoDoRouter>().router;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: HeyDoDoTheme.getThemeDefault(),
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
        );
      }),
    );
  }
}
