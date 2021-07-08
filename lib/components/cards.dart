import 'package:flutter/material.dart';
import 'package:vcu/attendance.dart';

// final List<String> _listItem = [
//   'assets/images/two.png',
//   'assets/images/three.png',
//   'assets/images/four.png',
//   'assets/images/one.png',
// ];// final List<Widget> listUrl = [
//   Text('Attendance()'),
//   Text('Assignment()'),
//   Text('Report()'),
//   Text('Schedule()'),// ];
class CardsOnHome {
  final int id;
  final String assetName;
  final String nav;
  CardsOnHome({this.assetName,this.nav,this.id});
}

List<CardsOnHome> cardsInfo = [
  CardsOnHome(
    id: 1,
    assetName: 'assets/images/two.png',
    nav: 'Attendance',
  ),
  CardsOnHome(
    id: 2,
    assetName: 'assets/images/three.png',
    nav: 'Navigator.push(context,PageRouteBuilder(pageBuilder: (c, a1, a2) => Assignment(),transitionsBuilder: (c, anim, a2, child) =>FadeTransition(opacity: anim, child: child),transitionDuration: Duration(milliseconds: 1200),),);',
  ),
  CardsOnHome(
    id: 3,
    assetName: 'assets/images/four.png',
    nav: 'Navigator.push(context,PageRouteBuilder(pageBuilder: (c, a1, a2) => Report(),transitionsBuilder: (c, anim, a2, child) =>FadeTransition(opacity: anim, child: child),transitionDuration: Duration(milliseconds: 1200),),);',
  ),
  CardsOnHome(
    id: 4,
    assetName: 'assets/images/one.png',
    nav: 'Navigator.push(context,PageRouteBuilder(pageBuilder: (c, a1, a2) => Schedule(),transitionsBuilder: (c, anim, a2, child) =>FadeTransition(opacity: anim, child: child),transitionDuration: Duration(milliseconds: 1200),),);',
  )
];