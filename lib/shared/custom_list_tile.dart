import 'package:flutter/material.dart';
import 'package:internship_managing_system/attending_physician/screens/form_decision.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/form_view.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/student/screens/hasta_etkilesim_kayd%C4%B1/form_page.dart';

class CustomListTile extends StatelessWidget {
  final FormData formData;
  final int index;
  final int routeTo;
  final bool? isDeletable;
  const CustomListTile(
      {Key? key,
      required this.formData,
      required this.index,
      required this.routeTo,
      this.isDeletable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    FormArguments arguments = FormArguments(
        formData: formData, index: index, isDeletable: isDeletable);

    void pushToFormView(FormData formData) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormView(formData: formData),
            settings: RouteSettings(
              arguments: arguments,
            )),
      );
    }

    void pushToFormPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FormPage(),
            settings: RouteSettings(
              arguments: arguments,
            )),
      );
    }

    void pushToDesicionPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormDecision(formData: formData),
            settings: RouteSettings(
              arguments: arguments,
            )),
      );
    }

    void whichPage() {
      if (routeTo == 1) {
        pushToFormPage();
      } else if (routeTo == 2) {
        pushToFormView(formData);
      } else if (routeTo == 3) {
        pushToDesicionPage();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: LIGHT_BUTTON_COLOR,
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
          onTap: () => whichPage(),
          leading: SizedBox(
            width: 80,
            child: Text(formData.getTarih()),
          ),
          title: Text(formData.getStajTuru()),
          subtitle: Text(formData.getDoktor()),
          isThreeLine: true,
        ),
      ),
    );
  }
}
