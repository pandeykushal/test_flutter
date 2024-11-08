import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/export_provider.dart';
import '../../view_model/utils/export_utils.dart';
import '../export_view.dart';

class TravelDetail extends StatelessWidget {
  const TravelDetail({super.key});
  static const String routeName = "/travelDetail";
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const TravelDetail());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "TravelDetail"),
      body: Consumer<DatePickerProvider>(
        builder: (context, homeProvider, child) {
          return ListView.builder(
            itemCount: homeProvider.travelDetailsList?.length ?? 0,
            itemBuilder: (context, k) {
              final travelList = homeProvider.travelDetailsList?[k];
              return ListTile(
                // trailing: Text(travelList?.travelAgenda ?? ""),
                leading: Image.network(travelList?.groupPhoto ?? "",
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    CustomImageGetter.logo,
                  );
                }),
                title: Text(travelList?.travel?.name ?? ""),
                subtitle: Text(travelList?.travel?.description ?? ""),
              );
            },
          );
        },
      ),
    );
  }
}
