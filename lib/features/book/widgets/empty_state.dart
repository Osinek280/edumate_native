import 'package:flutter/material.dart';

class EmptyLibrary extends StatelessWidget {
  const EmptyLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Biblioteka jest pusta'));
  }
}

class NoResults extends StatelessWidget {
  final String query;
  const NoResults({required this.query, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Brak wyników dla "$query"'));
  }
}
