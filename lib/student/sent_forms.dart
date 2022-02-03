import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/models/form_list.dart';
import 'package:internship_managing_system/student/models/form_data.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:provider/provider.dart';
import '../shared/form_view.dart';
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

    void pushToFormPage(FormData formData) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormView(formData: formData,)));
    }


    List<FormData> _forms = Provider.of<FormList>(context).getSentList();
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 5,
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
