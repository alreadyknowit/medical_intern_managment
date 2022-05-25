import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';

class CourseDropDown extends StatefulWidget {
  List itemList;
  String hintText;
  Function onChanged;

  CourseDropDown(this.itemList, this.hintText, this.onChanged);

  @override
  _CourseDropDownState createState() => _CourseDropDownState();
}

class _CourseDropDownState extends State<CourseDropDown> {
  late String dropdownValue;
  String? _selectedInstitute = "Ins1";
  List<Institute> institutes = [];
  late int id;
  @override
  void initState() {
    dropdownValue = widget.itemList[0].courseName;

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
                      _selectedInstitute = val.toString();
                      for (int i = 0; i < widget.itemList.length; i++) {
                        if (institutes[i].instituteName == _selectedInstitute) {
                          id = institutes[i].id;
                        }
                      }
                      if (val is Institute) {
                        Provider.of<PatientLog>(context, listen: false)
                            .setInstute(val);
                        widget.onChanged(val);
                      }
                      dropdownValue != val;
                    });
                    print(val);
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
