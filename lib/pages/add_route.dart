import 'dart:ffi';

import 'package:bus_reservation/datasource/temp_db.dart';
import 'package:bus_reservation/models/but_route.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddRoute extends StatelessWidget {
  const AddRoute({super.key});

  @override
  Widget build(BuildContext context) {
    String? fromCity;
    String? toCity;
    final distanceController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    void _addRoute() {
      if (_formKey.currentState!.validate()) {
        final route = BusRoute(
            routeId: TempDB.tableRoute.length + 1,
            routeName: fromCity! + '-' + toCity!,
            cityFrom: fromCity!,
            cityTo: toCity!,
            distanceInKm: double.parse(distanceController.text));
        Provider.of<Appdataprovider>(context, listen: false)
            .addRoute(route)
            .then((value) {
          if (value.statusCode == 200) {
            Navigator.pop(context);
            showErrMsg(context, value.message);
          } else {}
        }).catchError((error) {
          showErrMsg(context, error);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Route'),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField(
                      value: fromCity,
                      hint: Text('Select From City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyFieldErrMessage;
                        } else if (value == toCity) {
                          return 'From and To Cities are Same';
                        } else {
                          return null;
                        }
                      },
                      items: cities
                          .map((value) => DropdownMenuItem(
                              value: value, child: Text(value)))
                          .toList(),
                      onChanged: (String? value) {
                        fromCity = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField(
                      value: toCity,
                      hint: Text('Select To City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyFieldErrMessage;
                        } else {
                          return null;
                        }
                      },
                      items: cities
                          .map((value) => DropdownMenuItem(
                              value: value, child: Text(value)))
                          .toList(),
                      onChanged: (String? value) {
                        toCity = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                        controller: distanceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Distance in KM',
                            prefixIcon: Icon(Icons.social_distance_rounded)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return emptyFieldErrMessage;
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                        onPressed: _addRoute, child: Text('Add Route')),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
