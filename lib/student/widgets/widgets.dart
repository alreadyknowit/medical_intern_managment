import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../shared/constants.dart';

//TypeAhead Auto Complete Widget
const PADDING_VALUE = 16.0;
Widget customTypeAhead(List<String> listItems, TextEditingController controller,
     String? stajTuru,String labelText) {
  //check if the typed item is in the list
  List<String> getSuggestions(String query) {
    return List.of(listItems).where((item) {
      final queryLower = query.toLowerCase();
      final itemLower = item.toLowerCase();
      return itemLower.contains(queryLower);
    }).toList();
  }

  return Padding(
    padding: const EdgeInsets.all(PADDING_VALUE),
    child: Column(
      children: [
        Text(
          labelText,
          style: TEXT_STYLE,
        ),
        TypeAheadFormField<String?>(
          onSuggestionSelected: (String? val) =>controller.text = val!,
          itemBuilder: (context, String? suggestion) {
            return ListTile(
              title: Text(suggestion!),
            );
          },
          suggestionsCallback: getSuggestions,
          validator: (value) {
            bool isInTheList=false;
            for(var item in listItems){
              if(item==value) {
                isInTheList=true;
              }
            }
            if (value == null || value.isEmpty || isInTheList==false) {
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

//DropDownWidget
Container customDropDown(
    String? dropdownValue, List<String> listItems, String text, Function myFunc) {
  return Container(
    margin: const EdgeInsets.all(4),
    child: Column(
      children: [
        Text(
          text,
          style: TEXT_STYLE,
        ),
        Padding(
          padding: const EdgeInsets.all(PADDING_VALUE),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: InputBorder.none),
              isExpanded: true,
              validator: (val) => val == null  || val.isEmpty ? 'Lütfen $text giriniz' :null ,
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_downward,
                color: ICON_COLOR,
              ),
              iconSize: 24,
              elevation: 16,
              dropdownColor: Colors.grey[800],
              style: TEXT_STYLE,
              onChanged: (val) => myFunc(val),
              items: listItems.map<DropdownMenuItem<String>>((String? val) {
                return DropdownMenuItem(
                  value: val == null ? val = dropdownValue : val = val,
                  child: Center(
                    child: Text(
                      val ?? listItems[0],
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
Widget customTextField(
    int minLine,
    String text,
    int? maxLength,
    Function function,
    Function regexFunction,
    TextEditingController controller,
    double height) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: PADDING_VALUE),
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
