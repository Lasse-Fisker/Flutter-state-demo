import 'package:demo/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../async-example.dart';

final counterProvider = StateProvider((ref) => 0);

final isEvenProvider = Provider((ref) {
  final counter = ref.watch(counterProvider);

  return counter % 2 == 0;
});

class RiverpodExample extends ConsumerWidget {
  const RiverpodExample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProviderScope(
        child: Layout(
      actions: Actions(),
      counter: SideEffectOnStateChange(
        child: Value(),
      ),
      title: "Riverpod",
    ));
  }
}

class Value extends ConsumerWidget {
  const Value({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return LayoutValue(value: counter);
  }
}

class Actions extends ConsumerWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NB: Watching notifier for manipulating state
    final provider = ref.watch(counterProvider.notifier);

    return FloatingActionButton(
        onPressed: () => provider.state = provider.state + 1,
        child: const Icon(Icons.add));
  }
}

// Riverpod with hooks and computed providers!
class SideEffectOnStateChange extends HookConsumerWidget {
  final Widget child;

  const SideEffectOnStateChange({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = useState(Colors.blue.shade500);
    final state = ref.watch(counterProvider);
    final isEven = ref.watch(isEvenProvider);

    useEffect(() {
      color.value = color.value == Colors.blue.shade500
          ? Colors.green.shade500
          : Colors.blue.shade500;

      // Run on changes to state
    }, [state]);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: color.value,
      child: Column(children: [Text(isEven ? "Even" : "Odd"), child]),
    );
  }
}

final pokemonProvider = FutureProvider((ref) {
  // We could listen to other provider, e.g. filters, eith ref.watch

  return getPokemon();
});

class AsyncExampleWithProvider extends ConsumerWidget {
  const AsyncExampleWithProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonProvider);
    return Scaffold(
      body: SafeArea(
          child: pokemon.when(
              data: (pokemon) => pokemon.isEmpty
                  ? const Text("Ingen pokemon :(")
                  : ListView(
                      children: pokemon
                          .map((name) => ListTile(
                                title: Text(name),
                              ))
                          .toList()),
              error: (error, trace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
