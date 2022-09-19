import 'package:demo/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CounterEvent {}

class CounterIncrementPressed extends CounterEvent {}

// Bloc
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }
}

// Widgets
class BlocExample extends StatelessWidget {
  const BlocExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const Layout(
        actions: Actions(),
        counter: Value(),
        title: "BloC",
      ),
    );
  }
}

class Value extends StatelessWidget {
  const Value({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(builder: (context, state) {
      return LayoutValue(value: state);
    });
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () =>
            context.read<CounterBloc>().add(CounterIncrementPressed()),
        child: const Icon(Icons.add));
  }
}
