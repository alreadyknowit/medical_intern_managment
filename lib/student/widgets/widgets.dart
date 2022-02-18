import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../shared/constants.dart';

//TypeAhead Auto Complete Widget

Widget customTypeAhead(List<String> listItems) {
  //check if the typed item is in the list
  List<String> getSuggestions(String query) {
    return List.of(listItems).where((item) {
      final queryLower = query.toLowerCase();
      final itemLower = item.toLowerCase();
      return itemLower.contains(queryLower);
    }).toList();
  }

  return TypeAheadFormField<String?>(
      onSuggestionSelected: (val) {

      },
      itemBuilder: (context, String? suggestion) {
        return ListTile(
          title: Text(suggestion!),
        );
      },
      suggestionsCallback: getSuggestions);
}

//DropDownWidget
Container myDropDownContainer(
    String initialVal, List<String> listItems, String text, Function myFunc) {
  return Container(
    margin: const EdgeInsets.all(8),
    child: Column(
      children: [
        Text(
          text,
          style: TEXT_STYLE,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: InputBorder.none),
              isExpanded: true,
              value: initialVal,
              icon: const Icon(
                Icons.arrow_downward,
                color: ICON_COLOR,
              ),
              // validator: (val) => val==null? 'Seçim zorunludur!'  : null,
              iconSize: 24,
              elevation: 16,
              dropdownColor: Colors.grey[800],
              style: TEXT_STYLE,
              onChanged: (val) => myFunc(val),
              items: listItems.map<DropdownMenuItem<String>>((String? val) {
                return DropdownMenuItem(
                  value: val == null ? val = initialVal : val = val,
                  child: Center(
                    child: Text(
                      val,
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

//Kullanıcı kaydet butonuna basarsa local olarak kaydedecek
ElevatedButton submitButton(
    IconData icon, BuildContext context, String title, Function handleSubmit) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY_BUTTON_COLOR,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      minimumSize: const Size(120, double.infinity), //////// HERE
    ),
    onPressed: () => handleSubmit(),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Text(title),
    ),
  );
}

//TextFieldWidget
Padding myTextFieldRow(
    int minLine,
    String text,
    int? maxLength,
    Function function,
    Function regexFunction,
    TextEditingController controller,
    double height) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        SizedBox(
          child: Text(
            text,
            style: TEXT_STYLE,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: height,
          child: TextFormField(
            controller: controller,
            validator: (value) => regexFunction(value),
            onChanged: (input) => function(input.toString()),
            autofocus: false,
            textAlignVertical: TextAlignVertical.bottom,
            style: TEXT_STYLE.copyWith(fontSize: 16),
            maxLength: maxLength,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            minLines: minLine,
            expands: false,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              // labelStyle:kTextStyle.copyWith(fontSize: 16, color: Colors.white54),
            ),
          ),
        ),
      ],
    ),
  );
}
