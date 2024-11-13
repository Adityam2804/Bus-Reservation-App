import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeNameAddBusPage);
            },
            leading: const Icon(Icons.bus_alert),
            title: const Text('Add Bus'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeNameAddRoutePage);
            },
            leading: const Icon(Icons.route_rounded),
            title: const Text('Add Route'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeNameAddSchedulePage);
            },
            leading: const Icon(Icons.schedule_rounded),
            title: const Text('Add Schedule'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeNameReservationPage);
            },
            leading: const Icon(Icons.mobile_friendly_rounded),
            title: const Text('View Reservations'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeNameLoginPage);
            },
            leading: const Icon(Icons.login),
            title: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
