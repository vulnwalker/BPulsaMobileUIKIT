import 'package:flutter/material.dart';
import 'package:bpulsa/model/menu.dart';
import 'package:bpulsa/utils/uidata.dart';

class MenuViewModel {
  List<Menu> menuItems;

  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
        title: "Profile",
        menuColor: Color(0xff050505),
        icon: Icons.person,
        image: UIData.profileImage,
        targetPage: "View Profile",
      ),
      Menu(
        title: "Tukar Point",
        menuColor: Color(0xffc8c4bd),
        icon: Icons.shopping_cart,
        image: UIData.shoppingImage,
        targetPage: "Tukar Point"
        ),
      Menu(
        title: "Login",
        menuColor: Color(0xffc7d8f4),
        icon: Icons.send,
        image: UIData.loginImage,
        targetPage: "Shopping List"
      ),
      Menu(
        title: "Timeline",
        menuColor: Color(0xff7f5741),
        icon: Icons.timeline,
        image: UIData.timelineImage,
        targetPage: "Feed"
      ),
      Menu(
        title: "Dashboard",
        menuColor: Color(0xff261d33),
        icon: Icons.dashboard,
        image: UIData.dashboardImage,
        targetPage: "Dashboard 1"
      ),
      Menu(
        title: "Settings",
        menuColor: Color(0xff2a8ccf),
        icon: Icons.settings,
        image: UIData.settingsImage,
        targetPage: "Device Settings"
      ),
      Menu(
        title: "No Item",
        menuColor: Color(0xffe19b6b),
        icon: Icons.not_interested,
        image: UIData.blankImage,
        targetPage: "No Search Result"
      ),
      Menu(
        title: "Payment",
        menuColor: Color(0xffddcec2),
        icon: Icons.payment,
        image: UIData.paymentImage,
        targetPage: "Credit Card"
      ),
    ];
  }
}
