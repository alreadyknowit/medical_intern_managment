import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:provider/provider.dart';

class SentForms extends StatefulWidget {
  const SentForms({Key? key}) : super(key: key);

  @override
  State<SentForms> createState() => _SentFormsState();
}

class _SentFormsState extends State<SentForms> {
  late bool isChecked;
  @override
  void initState() {
    super.initState();
  isChecked =false;
  }

  bool handleLongPress(){
    setState(() {
      isChecked = !isChecked;

    });


    print("long pressed");
    return isChecked;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: when clicking on a list tile item need to push to the FormView page.
    List<FormData> _forms = Provider.of<FormList>(context).getSentList();
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 5,
          color: LIGHT_BUTTON_COLOR,
        ),
        itemCount: _forms.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomListTile(
              formData:_forms[index],
              index:index);
        },
      ),
    );
  }
}
