import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get remindItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("At time of event"), value: "0"),
    const DropdownMenuItem(child: Text("5 minutes before"), value: "5"),
    const DropdownMenuItem(child: Text("10 minutes before"), value: "10"),
    const DropdownMenuItem(child: Text("15 minutes before"), value: "15"),
    const DropdownMenuItem(child: Text("30 minutes before"), value: "30"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get repeatItems {
  List<DropdownMenuItem<String>> repeatMenuItems = [
    const DropdownMenuItem(child: Text("Never"), value: "Never"),
    const DropdownMenuItem(child: Text("Every Day"), value: "Every Day"),
    const DropdownMenuItem(child: Text("Every 2 Week"), value: "Every 2 Week"),
    const DropdownMenuItem(child: Text("Every Month"), value: "Every Month"),
    const DropdownMenuItem(child: Text("Every Year"), value: "Every Year"),
  ];
  return repeatMenuItems;
}
