import 'package:bus_reservation/pages/add_bus.dart';
import 'package:bus_reservation/pages/add_route.dart';
import 'package:bus_reservation/pages/add_schedule.dart';
import 'package:bus_reservation/pages/booking_confirmation_page.dart';
import 'package:bus_reservation/pages/login.dart';
import 'package:bus_reservation/pages/search_page.dart';
import 'package:bus_reservation/pages/search_result.dart';
import 'package:bus_reservation/pages/seat_plan.dart';
import 'package:bus_reservation/pages/view_reservations.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return Appdataprovider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      //home: const SearchPage(),
      initialRoute: routeNameHome,
      routes: {
        routeNameLoginPage: (context) => const Login(),
        routeNameHome: (context) => const SearchPage(),
        routeNameSearchResultPage: (context) => const SearchResult(),
        routeNameSeatPlanPage: (context) => const SeatPlan(),
        routeNameBookingConfirmationPage: (context) =>
            const BookingConfirmationPage(),
        routeNameAddBusPage: (context) => const AddBus(),
        routeNameAddRoutePage: (context) => const AddRoute(),
        routeNameAddSchedulePage: (context) => const AddSchedule(),
        routeNameReservationPage: (context) => const ViewReservations()
      },
    );
  }
}
