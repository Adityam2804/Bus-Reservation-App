import 'package:bus_reservation/datasource/temp_db.dart';
import 'package:bus_reservation/models/bus_model.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/but_route.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  Bus? bus;
  BusRoute? route;
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final processingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TimeOfDay? _departureDate;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Appdataprovider>(context);
    provider.getAllBus();
    provider.getAllRoutes();
    void _addSchedule() {
      if (_departureDate == null) {
        showErrMsg(context, emptyDateErrMsg);
        return;
      }
      if (_formKey.currentState!.validate()) {
        final totalfare = int.parse(priceController.text) +
            int.parse(discountController.text) +
            int.parse(processingController.text);
        final schedule = BusSchedule(
            scheduleId: TempDB.tableSchedule.length + 1,
            bus: bus!,
            busRoute: route!,
            departureTime: _departureDate!.format(context),
            ticketPrice: totalfare);

        provider.addSchedule(schedule).then((value) {
          if (value.statusCode == 200) {
            Navigator.pop(context);
            Navigator.pop(context);
            showErrMsg(context, value.message);
          } else {
            showErrMsg(context, value.message);
          }
        }).catchError((error) {
          showErrMsg(context, error);
        });
      }
    }

    _selectDatePicker() async {
      final slectedDate = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (slectedDate != null) {
        setState(() {
          _departureDate = slectedDate;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Schedule'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Consumer<Appdataprovider>(
                    builder: (context, provider, _) => FutureBuilder<List<Bus>>(
                        future: provider.getAllBus(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final buses = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DropdownButtonFormField(
                                value: bus,
                                hint: Text('Select Bus'),
                                validator: (value) {
                                  if (value == null) {
                                    return emptyFieldErrMessage;
                                  }
                                  return null;
                                },
                                items: buses
                                    .map((bus) => DropdownMenuItem(
                                        value: bus, child: Text(bus.busNumber)))
                                    .toList(),
                                onChanged: (Bus? value) {
                                  bus = value;
                                },
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Text('Failed to Fetch Data');
                          }
                          return const Text('Please wait');
                        })),
                Consumer<Appdataprovider>(
                    builder: (context, provider, _) =>
                        FutureBuilder<List<BusRoute>>(
                            future: provider.getAllRoutes(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final routes = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: DropdownButtonFormField(
                                    value: route,
                                    hint: Text('Select Route'),
                                    validator: (value) {
                                      if (value == null) {
                                        return emptyFieldErrMessage;
                                      }
                                      return null;
                                    },
                                    items: routes
                                        .map((route) => DropdownMenuItem(
                                            value: route,
                                            child: Text(route.routeName)))
                                        .toList(),
                                    onChanged: (BusRoute? value) {
                                      route = value;
                                    },
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text('Failed to Fetch Data');
                              }
                              return const Text('Please wait');
                            })),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Ticket Price',
                          prefixIcon: Icon(Icons.price_change_outlined)),
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
                  child: TextFormField(
                      controller: discountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Discount(%)',
                          prefixIcon: Icon(Icons.discount)),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            (int.parse(value) < 0 || int.parse(value) > 100)) {
                          return emptyFieldErrMessage;
                        } else {
                          return null;
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      controller: processingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Processing Fee',
                          prefixIcon: Icon(Icons.currency_rupee)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyFieldErrMessage;
                        } else {
                          return null;
                        }
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: _selectDatePicker,
                        child: Text('Select Departure Time')),
                    Text(_departureDate == null
                        ? 'No Date Chosen'
                        : _departureDate!.format(context))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: _addSchedule, child: Text('Add Schedule')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
