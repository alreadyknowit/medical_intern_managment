import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/form_view.dart';
import 'package:internship_managing_system/student/models/form_data.dart';
import 'package:internship_managing_system/student/models/form_list.dart';
import 'package:provider/provider.dart';

class AttendingPhysician extends StatefulWidget {
  AttendingPhysician({Key? key}) : super(key: key);

  @override
  _AttendingPhysicianState createState() => _AttendingPhysicianState();
}

class _AttendingPhysicianState extends State<AttendingPhysician> {
  @override
  Widget build(BuildContext context) {

    FormData data = FormData();
    final forms = Provider.of<FormList>(context).getSentList();
    forms.add(data);
    final formData = Provider.of<FormData>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
            children: [
          SizedBox(
            height: size.height/1.2,
            width: size.width /1.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Container(
                    child: FormView(
                      formData: data,
                    ),
                  ),
                  Row(
                    mainAxisSize:MainAxisSize.max,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text("Onayla")),
                      ElevatedButton(onPressed: () {}, child: Text("Reddet")),
                    ],
                  ),
                ]);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
