import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:provider/provider.dart';

class Drafts extends StatelessWidget {
  bool isChecked = false;
  bool handleLongPress() {
    isChecked = !isChecked;
    return isChecked;
  }
  //TODO:Taslağa kaydedilen veriyi tekrar taslağa kaydettiğimizde veya gönderdiğimizde boş olarak gönderiyor.
  @override
  Widget build(BuildContext context) {
    List<FormData> _forms = Provider.of<FormList>(context).getDraftList();
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 2,
          color: LIGHT_BUTTON_COLOR,
        ),
        itemCount: _forms.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomListTile(formData: _forms[index], index: index);
        },
      ),
    );
  }
}
