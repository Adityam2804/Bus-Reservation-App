import 'package:bus_reservation/datasource/data_source.dart';
import 'package:bus_reservation/datasource/dummy_data_source.dart';
import 'package:bus_reservation/models/bus_model.dart';
import 'package:bus_reservation/models/bus_reservation.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/but_route.dart';
import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/models/response_model.dart';
import 'package:bus_reservation/pages/add_schedule.dart';
import 'package:flutter/material.dart';

class Appdataprovider extends ChangeNotifier {
  List<BusReservation> _reservationList = [];
  final DataSource _dataSource = DummyDataSource();

  Future<List<BusRoute>> getAllRoutes() {
    return _dataSource.getAllRoutes();
  }

  Future<List<Bus>> getAllBus() {
    return _dataSource.getAllBus();
  }

  Future<List<BusReservation>> getReservations() async {
    _reservationList = await _dataSource.getAllReservation();
    notifyListeners();
    return _reservationList;
  }

  Future<List<BusReservation>> getReservationByMobile(String mobile) async {
    return _dataSource.getReservationsByMobile(mobile);
  }

  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    return _dataSource.addSchedule(busSchedule);
  }

  Future<ResponseModel> addRoute(BusRoute busRoute) {
    return _dataSource.addRoute(busRoute);
  }

  Future<ResponseModel> addBus(Bus bus) {
    return _dataSource.addBus(bus);
  }

  Future<ResponseModel> addReservation(BusReservation reservation) {
    return _dataSource.addReservation(reservation);
  }

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

  List<ReservationExpansionItem> getExpansionItems(
      List<BusReservation> reservationList) {
    return List.generate(reservationList.length, (index) {
      final reservation = reservationList[index];
      return ReservationExpansionItem(
          header: ReservationExpansionHeader(
              reservationId: reservation.reservationId,
              departureDate: reservation.departureDate,
              schedule: reservation.busSchedule,
              timestamp: reservation.timestamp,
              reservationStatus: reservation.reservationStatus),
          body: ReservationExpansionBody(
              customer: reservation.customer,
              totalSeatBooked: reservation.totalSeatBooked,
              seatNumbers: reservation.seatNumbers,
              totalPrice: reservation.totalPrice));
    });
  }
}
