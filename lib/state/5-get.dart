import 'package:demo/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
  increment() => count++;
}

class GetExample extends StatelessWidget {
  const GetExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Provides the controller. You can use the C here directly if you want
    final CounterController c = Get.put(CounterController());

    // NB: Not const!
    return Layout(counter: Value(), actions: Actions(), title: "Get");
  }
}

class Value extends StatelessWidget {
  final CounterController c = Get.find();

  Value({super.key});

  @override
  Widget build(BuildContext context) {
    // Obx performs dark magic to find the needed listeners to rebuild on changes
    return Obx(() => LayoutValue(value: c.count.value));
  }
}

class Actions extends StatelessWidget {
  final CounterController c = Get.find();

  Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: c.increment, child: const Icon(Icons.add));
  }
}
