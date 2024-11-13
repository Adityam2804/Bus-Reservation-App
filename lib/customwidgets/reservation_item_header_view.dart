import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class ReservationItemHeaderView extends StatelessWidget {
  final ReservationExpansionHeader header;
  const ReservationItemHeaderView({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('${header.departureDate} ${header.schedule.departureTime}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${header.schedule.busRoute.routeName}--${header.schedule.departureTime}'),
            Text(
                'Booking Time: ${dateFormater(DateTime.fromMillisecondsSinceEpoch(header.timestamp), pattern: 'EEE MMM DD yyyy')}')
          ],
        ),
      ),
    );
  }
}
