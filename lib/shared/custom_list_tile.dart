import 'package:flutter/material.dart';
import 'package:internship_managing_system/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/student/form_page.dart';

class CustomListTile extends StatefulWidget {
  final FormData formData;
  final int index;
  const CustomListTile({Key? key, required this.formData, required this.index})
      : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    FormArguments arguments =
        FormArguments(formData: widget.formData, index: widget.index);
    void pushToFormPage(FormData formData) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FormPage(),
            settings: RouteSettings(
              arguments: arguments,
            )),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color(0xffF9A825),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 6,
        child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          style: ListTileStyle.list,
          tileColor: const Color(0xffF9A825),
          hoverColor: Colors.orange,
          onTap: () => pushToFormPage(widget.formData),
          leading: Text(widget.formData.getKayitNo()),
          title: Text(widget.formData.getStajTuru()),
          subtitle: Text(widget.formData.getDoktor()),
          isThreeLine: true,
        ),
      ),
    );
  }
}
