import 'package:flutter/material.dart';

class Searchbox extends StatefulWidget {
  final Function(String) onSubmit;
  const Searchbox({super.key, required this.onSubmit});

  @override
  State<Searchbox> createState() => _SearchboxState();
}

class _SearchboxState extends State<Searchbox> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Search with Mobile',
          suffix: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (searchController.text.isEmpty) return;
              widget.onSubmit(searchController.text);
            },
          ),
        ),
      ),
    );
  }
}
