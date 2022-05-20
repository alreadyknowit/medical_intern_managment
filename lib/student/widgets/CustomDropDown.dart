import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';

class CustomDropDown extends StatefulWidget {
  List itemList;
  String hintText;
  Function onChanged;
  CustomDropDown(this.itemList, this.hintText, this.onChanged);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;
  late int selectedCourseId;
  @override
  void initState() {
    if (widget.itemList is List<Course>) {
      dropdownValue = widget.itemList[0].courseName;
    } else if (widget.itemList is List<String>) {
      dropdownValue = widget.itemList[0];
    } else if (widget.itemList is List<Speciality>) {
      dropdownValue = widget.itemList[0].name;
    } else if (widget.itemList is List<Institute>) {
      dropdownValue = widget.itemList[0].instituteName;
    } else if (widget.itemList is List<AttendingPhysician>) {
      dropdownValue = widget.itemList[0].attendingName;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          Text(
            widget.hintText,
            style: TEXT_STYLE,
          ),
          Padding(
            padding: const EdgeInsets.all(PADDING_VALUE),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonFormField(
                key: PageStorageKey<BuildContext>(context),
                decoration: const InputDecoration(border: InputBorder.none),
                isExpanded: true,
                validator: (val) =>
                    val == null ? 'Lütfen ${widget.hintText} giriniz' : null,
                value: dropdownValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: ICON_COLOR,
                ),
                iconSize: 24,
                elevation: 16,
                dropdownColor: Colors.grey[800],
                style: TEXT_STYLE,
                onChanged: (val) {
                  setState(() {
                    if (val is Course) {
                      Provider.of<PatientLog>(context, listen: false)
                          .setCourse(val);
                      widget.onChanged(val);
                    } else if (val is AttendingPhysician) {
                      Provider.of<PatientLog>(context, listen: false)
                          .setAttendingPhysician(val);
                      widget.onChanged(val);
                    } else if (val is Speciality) {
                      Provider.of<PatientLog>(context, listen: false)
                          .setSpeciality(val);
                      widget.onChanged(val);
                    } else if (val is Institute) {
                      Provider.of<PatientLog>(context, listen: false)
                          .setInstute(val);
                      widget.onChanged(val);
                    } else if (val is Course) {
                      Provider.of<PatientLog>(context, listen: false)
                          .setCourse(val);
                      widget.onChanged(val);
                    } else if (val is Cinsiyet) {
                      Provider.of<PatientLog>(context, listen: false)
                          .setCinsiyet(val);
                      widget.onChanged(val);
                    }
                    dropdownValue != val;
                  });
                  print(val);
                },
                items: widget.itemList
                    .map<DropdownMenuItem<String>>((dynamic val) {
                  String text = "";
                  if (val is Course) {
                    text = val.courseName;
                  } else if (val is AttendingPhysician) {
                    text = val.attendingName;
                  } else if (val is String) {
                    text = val;
                  } else if (val is Speciality) {
                    text = val.name;
                  } else if (val is Institute) {
                    text = val.instituteName;
                  }
                  return DropdownMenuItem<String>(
                    value: text,
                    child: Center(
                      child: Text(
                        text,
                        style: TEXT_STYLE,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
