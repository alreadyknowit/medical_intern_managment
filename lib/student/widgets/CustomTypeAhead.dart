/*import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';

import '../../shared/constants.dart';

class CustomTypeAhead extends StatefulWidget {
  List itemList;
  String labelText;

  CustomTypeAhead(this.itemList, this.labelText);

  @override
  _CustomTypeAheadState createState() => _CustomTypeAheadState();
}

class _CustomTypeAheadState extends State<CustomTypeAhead> {
  //check if the typed item is in the list
  List<dynamic> getSuggestions(String query) {
    if (widget.itemList is List<Course>) {
      return List.of(widget.itemList).where((item) {
        final queryLower = query.toLowerCase();
        final itemLower = item.toLowerCase();
        return itemLower.contains(queryLower);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PADDING_VALUE),
      child: Column(
        children: [
          Text(
            labelText,
            style: TEXT_STYLE,
          ),
          TypeAheadFormField<String?>(
            onSuggestionSelected: (String? val) => controller.text = val!,
            itemBuilder: (context, String? suggestion) {
              return ListTile(
                title: Text(suggestion!),
              );
            },
            suggestionsCallback: getSuggestions,
            validator: (value) {
              bool isInTheList = false;
              for (var item in listItems) {
                if (item == value) {
                  isInTheList = true;
                }
              }
              if (value == null || value.isEmpty || isInTheList == false) {
                return 'Lütfen ${labelText.toLowerCase()} seçiniz';
              } else {
                return null;
              }
            },
            textFieldConfiguration: TextFieldConfiguration(
                controller: controller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: TEXT_COLOR,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: TEXT_COLOR,
                    )))),
          ),
        ],
      ),
    );
  }
}
*/
