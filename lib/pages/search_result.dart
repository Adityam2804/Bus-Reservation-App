import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/but_route.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)?.settings.arguments as List;
    final BusRoute busRoute = argList[0];
    final String departureDate = argList[1];
    final provider = Provider.of<Appdataprovider>(context);
    provider.getSchedulesByRouteName(busRoute.routeName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Text(
            'Showing Routes from ${busRoute.cityFrom} to ${busRoute.cityTo} on $departureDate',
            style: TextStyle(fontSize: 18.0),
          ),
          Consumer<Appdataprovider>(
              builder: (context, provider, _) =>
                  FutureBuilder<List<BusSchedule>>(
                      future:
                          provider.getSchedulesByRouteName(busRoute.routeName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final busSchedule = snapshot.data!;
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: busSchedule
                                  .map((schedule) => SearchListView(
                                      date: departureDate,
                                      busSchedule: schedule))
                                  .toList());
                        }
                        if (snapshot.hasError) {
                          return const Text('Failed to Fetch Data');
                        }
                        return const Text('Please wait');
                      }))
        ],
      ),
    );
  }
}

class SearchListView extends StatelessWidget {
  final String date;
  final BusSchedule busSchedule;
  const SearchListView(
      {super.key, required this.date, required this.busSchedule});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(busSchedule.bus.busName),
              subtitle: Text(busSchedule.bus.busType),
              trailing: Text('$currency${busSchedule.ticketPrice}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'From:${busSchedule.busRoute.cityFrom}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'To:${busSchedule.busRoute.cityTo}',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Departure Time:${busSchedule.departureTime}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Total Seats:${busSchedule.bus.totalSeat}',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
