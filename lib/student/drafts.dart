import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:provider/provider.dart';

class Drafts extends StatelessWidget {
  bool isChecked = false;
  bool handleLongPress() {
    isChecked = !isChecked;
    return isChecked;
  }

  @override
  Widget build(BuildContext context) {
    List<FormData> _forms = Provider.of<FormList>(context).getDraftList();
    return Scaffold(
      backgroundColor: const Color(0xffffe0b2), //const Color(0xff7986cb),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 2,
        ),
        itemCount: _forms.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomListTile(formData: _forms[index], index: index);
        },
      ),
    );
  }
}
