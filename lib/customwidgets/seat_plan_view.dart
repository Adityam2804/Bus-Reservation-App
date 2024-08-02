import 'package:bus_reservation/utils/colors.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';

class SeatPlanView extends StatelessWidget {
  final int totalSeats;
  final String bookedSeatNumbers;
  final int totalSeatsBooked;
  final bool isBusinessClass;
  final Function(bool, String) onSelected;
  const SeatPlanView(
      {super.key,
      required this.totalSeats,
      required this.bookedSeatNumbers,
      required this.totalSeatsBooked,
      required this.isBusinessClass,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final noOfRows =
        (isBusinessClass ? totalSeats / 3 : totalSeats / 4).toInt();
    final noOfColumns = (isBusinessClass ? 3 : 4);
    List bookedSeats =
        bookedSeatNumbers.isEmpty ? [] : bookedSeatNumbers.split(',');
    List<List<String>> seatArrangement = [];
    for (int i = 0; i < noOfRows; i++) {
      List<String> columns = [];
      for (int j = 0; j < noOfColumns; j++) {
        columns.add('${seatLabelList[i]}${j + 1}');
      }
      seatArrangement.add(columns);
    }
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Column(
        children: [
          const Text(
            'FRONT',
            style: TextStyle(fontSize: 32.0, color: Colors.grey),
          ),
          const Divider(
            height: 2.0,
            color: Colors.black,
          ),
          Column(
            children: [
              for (int i = 0; i < seatArrangement.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int j = 0; j < seatArrangement[i].length; j++)
                      Row(
                        children: [
                          Seat(
                              isBooked:
                                  bookedSeats.contains(seatArrangement[i][j]),
                              label: seatArrangement[i][j],
                              onSelect: (value) {
                                onSelected(value, seatArrangement[i][j]);
                              }),
                          if (isBusinessClass && j == 0)
                            const SizedBox(
                              width: 24,
                            ),
                          if (!isBusinessClass && j == 1)
                            const SizedBox(
                              width: 24,
                            )
                        ],
                      )
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}

class Seat extends StatefulWidget {
  final bool isBooked;
  final String label;
  final Function(bool) onSelect;

  const Seat(
      {super.key,
      required this.isBooked,
      required this.label,
      required this.onSelect});

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isBooked
          ? null
          : () {
              setState(() {
                isSelected = !isSelected;
                widget.onSelect(isSelected);
              });
            },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isSelected
                ? seatSelectedColor
                : widget.isBooked
                    ? seatBookedColor
                    : seatAvailableColor,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: widget.isBooked
                ? null
                : [
                    const BoxShadow(
                        offset: Offset(-4, -4),
                        color: Colors.white,
                        blurRadius: 5.0,
                        spreadRadius: 2.0),
                    BoxShadow(
                        offset: Offset(4, 4),
                        color: Colors.grey.shade400,
                        blurRadius: 5.0,
                        spreadRadius: 2.0)
                  ]),
        child: Text(
          widget.label,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        ),
      ),
    );
  }
}
