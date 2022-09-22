import 'package:demo/async-example.dart';
import 'package:demo/state/3-bloc.dart';
import 'package:demo/state/4-cubit.dart';
import 'package:demo/state/5-get.dart';
import 'package:demo/state/2-hook.dart';
import 'package:demo/state/6-riverpod.dart';
import 'package:demo/state/1-stateful-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

const pages = [
  AsyncExample(),
  StatefullExample(),
  HookExample(),
  BlocExample(),
  CubitExample(),
  GetExample(),
  RiverpodExample(),
];

const bottomItems = [
  "Async",
  "Stateful",
  "Hook",
  "BloC",
  "Cubit",
  "Get",
  "River"
];

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final active = useState(0);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => active.value = value,
              currentIndex: active.value,
              items: bottomItems
                  .map((e) => BottomNavigationBarItem(
                      backgroundColor: Colors.black,
                      icon: const Icon(Icons.home),
                      label: e))
                  .toList()),
          body: pages.elementAt(active.value),
        ));
  }
}
