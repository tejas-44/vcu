import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('studentslistXI');

class Attendance extends StatefulWidget {
  final String uid;

  Attendance({Key key,@required this.uid});
  @override
  _AttendanceState createState() => _AttendanceState(uid: uid);
}

class _AttendanceState extends State<Attendance> {
final String uid;

_AttendanceState({Key key,@required this.uid});

@override
void initState() {
  getUserById();
  super.initState();

}

 getUserById() {
  usersRef.doc(uid).get().then((DocumentSnapshot doc){
    print(doc.data());
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(uid),
              Text('You Have Entered Attendance'),
              MaterialButton(onPressed: () {}, color: Colors.black,)
            ],
          ),
        ),
      ),
    );
  }

}
