/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';

import '../../model/Institute.dart';
import '../../shared/constants.dart';

class InstituteDropDown extends StatefulWidget {
  const InstituteDropDown({Key? key}) : super(key: key);

  @override
  _InstituteDropDownState createState() => _InstituteDropDownState();
}

class _InstituteDropDownState extends State<InstituteDropDown> {
  String? _selectedInstitute = "Ins1";
  List<Institute> institutes = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          Text(
            "Institute",
            style: TEXT_STYLE,
          ),
          Padding(
            padding: EdgeInsets.all(PADDING_VALUE),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonFormField(
                  key: PageStorageKey<BuildContext>(context),
                  decoration: const InputDecoration(border: InputBorder.none),
                  isExpanded: true,
                  validator: (val) => val == null ? 'Institute Name' : null,
                  value: _selectedInstitute,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: ICON_COLOR,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Colors.grey[800],
                  style: TEXT_STYLE,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInstitute = newValue!;
                      for (int i = 0; i < institutes.length; i++) {
                        if (institutes[i].instituteName == _selectedInstitute)
                          id = institutes[i].id;
                      }
                      _patientLog.setInstute;
                    });
                  },
                  items: institutes.map((item) {
                    return DropdownMenuItem(
                      child: Text(item.instituteName),
                      value: item.instituteName,
                    );
                  }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
*/
