import 'package:bus_reservation/customwidgets/seat_plan_view.dart';
import 'package:bus_reservation/models/bus_reservation.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/colors.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SeatPlan extends StatefulWidget {
  const SeatPlan({super.key});

  @override
  State<SeatPlan> createState() => _SeatPlanState();
}

class _SeatPlanState extends State<SeatPlan> {
  late BusSchedule busSchedule;
  late String departureDate;
  int totalSeatBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  bool isFirst = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier('');

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)?.settings.arguments as List;
    busSchedule = argList[0];
    departureDate = argList[1];
    _getData();
    super.didChangeDependencies();
  }

  Future<void> _getData() async {
    List<String> seats = [];
    List<BusReservation> reservations =
        await Provider.of<Appdataprovider>(context, listen: false)
            .getReservationsByScheduleAndDepartureDate(
                busSchedule.scheduleId!, departureDate);
    setState(() {
      isDataLoading = false;
    });
    for (BusReservation res in reservations) {
      totalSeatBooked += res.totalSeatBooked;
      seats.add(res.seatNumbers);
    }
    bookedSeatNumbers = seats.join(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Plan'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          color: seatBookedColor,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Booked')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          color: seatAvailableColor,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('Available')
                      ],
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selectedSeatStringNotifier,
                builder: (context, value, _) => Text(
                      'Selected: $value',
                      style: const TextStyle(fontSize: 16),
                    )),
            if (!isDataLoading)
              Expanded(
                  child: SingleChildScrollView(
                child: SeatPlanView(
                    totalSeats: busSchedule.bus.totalSeat,
                    bookedSeatNumbers: bookedSeatNumbers,
                    totalSeatsBooked: totalSeatBooked,
                    isBusinessClass:
                        busSchedule.bus.busType == busTypeACBusiness,
                    onSelected: (value, seat) {
                      if (value) {
                        selectedSeats.add(seat);
                      } else {
                        selectedSeats.remove(seat);
                      }
                      selectedSeatStringNotifier.value =
                          selectedSeats.join(',');
                    }),
              )),
            OutlinedButton(
                onPressed: () {
                  if (selectedSeats.isEmpty) {
                    showErrMsg(context, 'Please Select your seats');
                    return;
                  } else {
                    Navigator.pushNamed(
                        context, routeNameBookingConfirmationPage,
                        arguments: [
                          departureDate,
                          busSchedule,
                          selectedSeatStringNotifier.value,
                          selectedSeats.length
                        ]);
                  }
                },
                child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
