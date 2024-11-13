import 'package:bus_reservation/datasource/temp_db.dart';
import 'package:bus_reservation/models/bus_model.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBus extends StatelessWidget {
  const AddBus({super.key});

  @override
  Widget build(BuildContext context) {
    String? busType;
    final _formKey = GlobalKey<FormState>();
    final busNameController = TextEditingController();
    final busNumberContoller = TextEditingController();
    final totalSeatsController = TextEditingController();

    void _addBus() {
      if (_formKey.currentState!.validate()) {
        final bus = Bus(
            busId: TempDB.tableBus.length,
            busName: busNameController.text,
            busNumber: busNumberContoller.text,
            busType: busType!,
            totalSeat: int.parse(totalSeatsController.text));
        Provider.of<Appdataprovider>(context, listen: false)
            .addBus(bus)
            .then((value) {
          if (value.statusCode == 200) {
            Navigator.pop(context);

            showErrMsg(context, value.message);
          }
        }).catchError((error) {
          showErrMsg(context, error);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bus'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(36.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField(
                  value: busType,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                  hint: Text('Select Bus Type'),
                  items: busTypes
                      .map((bustype) => DropdownMenuItem(
                            value: bustype,
                            child: Text(bustype),
                          ))
                      .toList(),
                  onChanged: (value) {
                    busType = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: busNameController,
                  decoration: InputDecoration(
                      hintText: 'Bus Name', prefixIcon: Icon(Icons.bus_alert)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: busNumberContoller,
                  decoration: InputDecoration(
                      hintText: 'Bus Number',
                      prefixIcon: Icon(Icons.bus_alert)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: totalSeatsController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Total Seats',
                      prefixIcon: Icon(Icons.event_seat_rounded)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    ElevatedButton(onPressed: _addBus, child: Text('Add Bus')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
