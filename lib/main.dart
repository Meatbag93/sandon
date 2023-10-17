import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
  SemanticsBinding.instance.ensureSemantics();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PermutationsList(),
    );
  }
}

class PermutationsList extends StatefulWidget {
  const PermutationsList({super.key});

  @override
  PermutationsListState createState() => PermutationsListState();
}

class PermutationsListState extends State<PermutationsList> {
  List<String> permutations = [];
  String name = 'sandon';

  @override
  void initState() {
    super.initState();
    generatePermutations();
  }

  void generatePermutations() {
    List<String> characters = name.split('');
    List<String> tempPermutations = generatePermutationsList(characters);

    // Shuffle
    final random = Random();
    for (int i = tempPermutations.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = tempPermutations[i];
      tempPermutations[i] = tempPermutations[j];
      tempPermutations[j] = temp;
    }

    setState(() {
      permutations = tempPermutations;
    });
  }

  List<String> generatePermutationsList(List<String> characters) {
    if (characters.length == 1) {
      return characters;
    }

    List<String> result = [];
    for (int i = 0; i < characters.length; i++) {
      String char = characters[i];
      List<String> remainingChars = List.from(characters);
      remainingChars.removeAt(i);

      List<String> subPermutations = generatePermutationsList(remainingChars);
      for (String subPermutation in subPermutations) {
        result.add(char + subPermutation);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permutations of "sandon"'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shuffle, semanticLabel: "Reshuffle"),
            onPressed: generatePermutations,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: permutations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(permutations[index]),
          );
        },
      ),
    );
  }
}
