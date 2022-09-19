import 'package:demo/layout.dart';
import 'package:flutter/material.dart';

class StatefullExample extends StatefulWidget {
  const StatefullExample({super.key});

  @override
  State<StatefullExample> createState() => _StatefullExampleState();
}

class _StatefullExampleState extends State<StatefullExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: "Statefull Widget",
        counter: Value(value: _counter),
        actions: Actions(onIncrease: () {
          setState(() {
            _counter++;
          });
        }));
  }
}

class Value extends StatelessWidget {
  final int value;

  const Value({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutValue(value: value);
  }
}

class Actions extends StatelessWidget {
  final VoidCallback onIncrease;

  const Actions({super.key, required this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onIncrease, child: const Icon(Icons.add));
  }
}
