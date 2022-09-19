import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final String title;
  final Widget counter;
  final Widget actions;

  const Layout(
      {super.key,
      required this.counter,
      required this.actions,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const Spacer(),
          const Spacer(),
          counter,
          const Spacer(),
          actions,
          const Spacer(),
          const Spacer()
        ],
      ),
    );
  }
}

class LayoutValue extends StatelessWidget {
  final int value;

  const LayoutValue({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      value.toString(),
      style: theme.textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }
}
