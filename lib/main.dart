import 'package:flutter/material.dart';
import 'package:flutter_yacht_booking_app/pages/checkout_screen.dart';
import 'package:flutter_yacht_booking_app/pages/home_page_screen.dart';
import 'package:flutter_yacht_booking_app/pages/yatch_detai_screenl.dart';
import 'package:flutter_yacht_booking_app/scopedModel/connected_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'helper/customRoute.dart';
import 'model/yatch.dart';

/*
Title:Entry Point of a Application
Purpose:Entry Point of a Application
Created By:Kalpesh Khandla
*/  

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final YatchModel yatchModel = YatchModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: yatchModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'OpenSans',
          ),
          routes: <String, WidgetBuilder>{
            '/': (_) => MyHomePage(),
            '/detail': (_) => YatchDetailScreen(),
            '/checkout': (_) => CheckoutScreen()
          },
          onGenerateRoute: (RouteSettings settings) {
            Yatch yatch;
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] == '') {
              return null;
            }
            if (pathElements[0] == 'detail') {
              final String planetId = pathElements[1];
              yatch = yatchModel.allYatch.firstWhere((x) {
                return x.id == planetId;
              });
              return CustomRoute<bool>(
                builder: (BuildContext context) =>
                    YatchDetailScreen(yatch: yatch),
              );
            } else if (pathElements[0] == 'checkout') {
              final String planetId = pathElements[1];
              yatch = yatchModel.allYatch.firstWhere((x) {
                return x.id == planetId;
              });
              return CustomRoute<bool>(
                builder: (BuildContext context) => CheckoutScreen(model: yatch),
              );
            } else
              return CustomRoute<bool>(
                builder: (BuildContext context) => CheckoutScreen(model: yatch),
              );
          },
          title: 'Yatch Booking App',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, YatchModel model) {
        return Scaffold(
          body: HomePageScreen(model),
        );
      },
    );
  }
}
