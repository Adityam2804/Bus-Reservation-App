import 'package:bus_reservation/datasource/data_source.dart';
import 'package:bus_reservation/datasource/temp_db.dart';
import 'package:bus_reservation/models/app_user.dart';
import 'package:bus_reservation/models/auth_response_model.dart';
import 'package:bus_reservation/models/bus_model.dart';
import 'package:bus_reservation/models/bus_reservation.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/but_route.dart';
import 'package:bus_reservation/models/response_model.dart';

class DummyDataSource extends DataSource {
  @override
  Future<ResponseModel> addBus(Bus bus) {
    // TODO: implement addBus
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) {
    // TODO: implement addReservation
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) {
    // TODO: implement addRoute
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    // TODO: implement addSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<Bus>> getAllBus() {
    // TODO: implement getAllBus
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getAllReservation() {
    // TODO: implement getAllReservation
    throw UnimplementedError();
  }

  @override
  Future<List<BusRoute>> getAllRoutes() {
    // TODO: implement getAllRoutes
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) {
    // TODO: implement getReservationsByMobile
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) {
    // TODO: implement getReservationsByScheduleAndDepartureDate
    throw UnimplementedError();
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    BusRoute route;
    try {
      route = TempDB.tableRoute.firstWhere((element) =>
          element.cityFrom == cityFrom && element.cityTo == cityTo);
      return route;
      // ignore: unused_catch_clause
    } on StateError catch (error) {
      return null;
    }
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return TempDB.tableSchedule
        .where((route) => route.busRoute.routeName == routeName)
        .toList();
  }

  @override
  Future<AuthResponseModel?> login(AppUser user) {
    // TODO: implement login
    throw UnimplementedError();
  }
}