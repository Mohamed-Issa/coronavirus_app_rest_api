import 'package:coronavirus_rest_api/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/api_services.dart';
import 'package:coronavirus_rest_api/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
//import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
//import 'package:intl/intl.dart';

void main() {
  // Intl.defaultLocale = 'en_GB';
  // await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) =>
          DataRepository(apiServices: APIServices(api: API.sandBox())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xff101010),
          cardColor: Color(0xff222222),
        ),
        home: DashBoard(),
      ),
    );
  }
}
