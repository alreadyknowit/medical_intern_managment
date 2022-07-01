import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';
import '../../shared/constants.dart';

class CustomDropDown extends StatefulWidget {
  List itemList;
  String hintText;
  Function onChanged;
  String? selectedVal;
  CustomDropDown(this.selectedVal,this.itemList, this.hintText, this.onChanged);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;
  late int selectedCourseId;
  @override
  void initState() {
    dropdownValue =widget.selectedVal ?? widget.itemList[0];

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
                    widget.onChanged(val);

                    dropdownValue != val;
                  });
                },
                items: widget.itemList
                    .map<DropdownMenuItem<String>>((dynamic val) {
                  String text = "";

                  text = val;

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
