import 'package:flutter/material.dart';
import 'package:np_com_pandeykushal/view/components/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/export_provider.dart';

class Travel extends StatelessWidget {
  const Travel({super.key});
  static const String routeName = "/travel";
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const Travel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "travel",
      ),
      body: Consumer<DatePickerProvider>(
        builder: (context, homeProvider, child) {
          return ListView.builder(
            itemCount: homeProvider.travelList?.length ?? 0,
            itemBuilder: (context, k) {
              return ListTile(
                leading:
                    Text(homeProvider.travelList?[k].id?.toString() ?? 'No ID'),
                title: Text(homeProvider.travelList?[k].name ?? ""),
                subtitle: Text(homeProvider.travelList?[k].description ?? ""),
              );
            },
          );
        },
      ),
    
    
    );
  }
}
