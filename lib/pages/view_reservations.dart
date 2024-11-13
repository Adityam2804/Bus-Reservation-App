import 'package:bus_reservation/customwidgets/reservation_item_body_view.dart';
import 'package:bus_reservation/customwidgets/reservation_item_header_view.dart';
import 'package:bus_reservation/customwidgets/searchbox.dart';
import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/providers/AppDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewReservations extends StatefulWidget {
  const ViewReservations({super.key});

  @override
  State<ViewReservations> createState() => _ViewReservationsState();
}

class _ViewReservationsState extends State<ViewReservations> {
  bool isFirst = true;
  List<ReservationExpansionItem> items = [];
  @override
  void didChangeDependencies() {
    if (isFirst) {
      _getData();
    }
    super.didChangeDependencies();
  }

  _getData() async {
    final reservations =
        await Provider.of<Appdataprovider>(context, listen: false)
            .getReservations();
    items = Provider.of<Appdataprovider>(context, listen: false)
        .getExpansionItems(reservations);
    setState(() {
      //  isFirst = false;
    });
  }

  void _search(String number) async {
    final data = await Provider.of<Appdataprovider>(context, listen: false)
        .getReservationByMobile(number);
    items = Provider.of<Appdataprovider>(context, listen: false)
        .getExpansionItems(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Reservations'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Searchbox(onSubmit: (value) {
              _search(value);
            }),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  items[panelIndex].isExpanded = isExpanded;
                  print('$panelIndex and $isExpanded');
                });
              },
              children: items
                  .map((item) => ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(header: item.header),
                      body: ReservationItemBodyView(
                        body: item.body,
                      )))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
