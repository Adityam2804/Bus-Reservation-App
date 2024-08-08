import 'package:bus_reservation/models/bus_reservation.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/customer.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({super.key});

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late String departureDate;
  late String seatNumbers;
  late BusSchedule schedule;
  bool isFirst = true;
  late int noSeats;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = 'MR.ABC';
    phoneController.text = '123456789';
    emailController.text = 'abc@gmail.com';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirst) {
      final argList = ModalRoute.of(context)!.settings.arguments as List;
      departureDate = argList[0];
      schedule = argList[1];
      seatNumbers = argList[2];
      noSeats = argList[3];
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please provide your information',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Customer Name',
                    prefixIcon: Icon(Icons.person),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 40, minHeight: 40),
                    filled: true),
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
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 40, minHeight: 40),
                    filled: true),
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.justify,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(),
                    prefixIcon: Icon(Icons.email),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 40, minHeight: 40),
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please provide your information',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer Name: ${nameController.text}'),
                    Text('Phone Number: ${phoneController.text}'),
                    Text('Email Address: ${emailController.text}'),
                    Text('Route: ${schedule.busRoute.routeName}'),
                    Text('Departure Date: $departureDate'),
                    Text('Departure Time: ${schedule.departureTime}'),
                    Text('Ticket Price: $currency ${schedule.ticketPrice}'),
                    Text('Total Seat(s): $noSeats'),
                    Text('Seat Number(s): $seatNumbers'),
                    Text('Discount: ${schedule.discount}%'),
                    Text('Proccesing Fees: ${schedule.processingFee}%'),
                    Text(
                      'Grand Total: $currency ${getGrandTotal(schedule.discount, noSeats, schedule.ticketPrice, schedule.processingFee)}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: _confirmBooking,
                child: const Text('Confirm Booking'))
          ],
        ),
      ),
    );
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(
          customerName: nameController.text,
          mobile: phoneController.text,
          email: emailController.text);
      final reservation = BusReservation(
          customer: customer,
          busSchedule: schedule,
          timestamp: DateTime.now().microsecondsSinceEpoch,
          departureDate: departureDate,
          totalSeatBooked: noSeats,
          seatNumbers: seatNumbers,
          reservationStatus: reservationActive,
          totalPrice: getGrandTotal(schedule.discount, noSeats,
              schedule.ticketPrice, schedule.processingFee));

      Provider.of<Appdataprovider>(context, listen: false)
          .addReservation(reservation)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showErrMsg(context, response.message);
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        } else {
          showErrMsg(context, response.message);
        }
      }).catchError((error) {});
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
