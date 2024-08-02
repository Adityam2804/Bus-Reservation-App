import 'package:bus_reservation/datasource/data_source.dart';
import 'package:bus_reservation/datasource/dummy_data_source.dart';
import 'package:bus_reservation/models/bus_reservation.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/but_route.dart';
import 'package:flutter/material.dart';

class Appdataprovider extends ChangeNotifier {
  final DataSource _dataSource = DummyDataSource();

  Future<BusRoute?> getBusRouteFromCityToCity(String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return await _dataSource.getSchedulesByRouteName(routeName);
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    return await _dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }
}
