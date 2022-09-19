import 'package:demo/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookExample extends HookWidget {
  const HookExample({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    return Layout(
        title: "Hooks Widget",
        counter: Value(value: counter.value),
        actions: Actions(onIncrease: () => counter.value++));
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
