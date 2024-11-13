import 'package:bus_reservation/datasource/temp_db.dart';
import 'package:bus_reservation/drawers/main_drawer.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Form(
        key: _formKey,
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
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: _selectDatePicker,
                        child: const Text('Select Departure Date')),
                    Text(departureDate == null
                        ? 'No Date Chosen'
                        : dateFormater(departureDate!,
                            pattern: 'EEE MMM dd, yyyy'))
                  ],
                ),
              ),
              Center(
                  child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: _search, child: Text('Search'))))
            ],
          ),
        ),
      ),
    );
  }

  _selectDatePicker() async {
    final selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 7)));
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showErrMsg(context, emptyDateErrMsg);
    }
    if (_formKey.currentState!.validate()) {
      Provider.of<Appdataprovider>(context, listen: false)
          .getBusRouteFromCityToCity(fromCity!, toCity!)
          .then((route) {
        Navigator.pushNamed(context, routeNameSearchResultPage,
            arguments: [route, dateFormater(departureDate!)]);
      });
    }
  }
}
