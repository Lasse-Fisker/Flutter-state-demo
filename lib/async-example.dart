import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<List<String>> getPokemon() async {
  final res = await Dio().get("https://pokeapi.co/api/v2/pokemon");

  return (res.data["results"] as List<dynamic>)
      .map((pokemon) => pokemon["name"] as String)
      .toList();
}

class AsyncExample extends StatelessWidget {
  const AsyncExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<String>>(
        future: getPokemon(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.data!.isEmpty == true) {
            return const Text("Ingen pokemon :(");
          }

          return ListView(
              children: snapshot.data!
                  .map((name) => ListTile(
                        title: Text(name),
                      ))
                  .toList());
        }),
      )),
    );
  }
}
