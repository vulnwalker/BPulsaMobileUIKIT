import 'package:flutter/material.dart';
import 'package:bpulsa/ui/page/dashboard/dashboard_one.page.dart';
import 'package:bpulsa/ui/page/dashboard/dashboard_two_page.dart';
import 'package:bpulsa/ui/page/home_page.dart';
import 'package:bpulsa/ui/page/login/login.dart';
import 'package:bpulsa/ui/page/notfound/notfound_page.dart';
import 'package:bpulsa/ui/page/payment/credit_card_page.dart';
import 'package:bpulsa/ui/page/payment/payment_success_page.dart';
import 'package:bpulsa/ui/page/profile/profile_one_page.dart';
import 'package:bpulsa/ui/page/profile/profile_two_page.dart';
import 'package:bpulsa/ui/page/settings/settings_one_page.dart';
import 'package:bpulsa/ui/page/shopping/product_detail_page.dart';
import 'package:bpulsa/ui/page/shopping/shopping_details_page.dart';
import 'package:bpulsa/ui/page/shopping/shopping_one_page.dart';
import 'package:bpulsa/ui/page/timeline/timeline_one_page.dart';
import 'package:bpulsa/ui/page/timeline/timeline_two_page.dart';
import 'package:bpulsa/CheckRoute.dart';
import 'package:bpulsa/ui/page/tukarpoint/TukarPoint.dart';

import 'package:bpulsa/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyApp extends StatelessWidget {
  final materialApp = MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
          primaryColor: Colors.blue,
          fontFamily: UIData.quickFont,
          primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: CheckRoute(),
      // initialRoute: UIData.notFoundRoute,

      //routes
      routes: <String, WidgetBuilder>{
        UIData.checkRoute: (BuildContext context) => CheckRoute(),
        UIData.tukarPointRoute: (BuildContext context) => TukarPoint(),
        UIData.homeRoute: (BuildContext context) => HomePage(),
        UIData.profileOneRoute: (BuildContext context) => ProfileOnePage(),
        UIData.profileTwoRoute: (BuildContext context) => ProfileTwoPage(),
        UIData.timelineOneRoute: (BuildContext context) => TimelineOnePage(),
        UIData.timelineTwoRoute: (BuildContext context) => TimelineTwoPage(),
        UIData.notFoundRoute: (BuildContext context) => NotFoundPage(),
        UIData.settingsOneRoute: (BuildContext context) => SettingsOnePage(),
        UIData.shoppingOneRoute: (BuildContext context) => ShoppingOnePage(),
        UIData.shoppingTwoRoute: (BuildContext context) =>
            ShoppingDetailsPage(),
        UIData.shoppingThreeRoute: (BuildContext context) =>
            ProductDetailPage(),
        // UIData.loginOneRoute: (BuildContext context) => LoginPage(),
        UIData.loginRoute: (BuildContext context) => LoginPage(),
        UIData.paymentOneRoute: (BuildContext context) => CreditCardPage(),
        UIData.paymentTwoRoute: (BuildContext context) => PaymentSuccessPage(),
        UIData.dashboardOneRoute: (BuildContext context) => DashboardOnePage(),
        UIData.dashboardTwoRoute: (BuildContext context) => DashboardTwoPage(),
      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
                icon: FontAwesomeIcons.solidSmile,
                title: UIData.coming_soon,
                message: "Under Development",
                iconColor: Colors.green,
              )));

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}
