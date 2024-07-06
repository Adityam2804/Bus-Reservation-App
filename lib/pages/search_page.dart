import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Form(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(8.0),
            children: [
              DropdownButtonFormField(
                  value: fromCity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Colors.white)),
                  isExpanded: true,
                  hint: Text('From'),
                  items: cities
                      .map((city) => DropdownMenuItem(
                            child: Text(city),
                            value: city,
                          ))
                      .toList(),
                  onChanged: (value) {
                    fromCity = value;
                  }),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                  value: toCity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Colors.white)),
                  isExpanded: true,
                  hint: Text('To'),
                  items: cities
                      .map((city) => DropdownMenuItem(
                            child: Text(city),
                            value: city,
                          ))
                      .toList(),
                  onChanged: (value) {
                    toCity = value;
                  })
            ],
          ),
        ),
      ),
    );
  }
}
