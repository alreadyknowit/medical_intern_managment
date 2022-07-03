import 'package:flutter/material.dart';
import 'package:internship_managing_system/attending_physician/screens/form_decision.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/form_view.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/student/screens/hasta_etkilesim_kaydi/showDraft.dart';

import '../model/PatientLog.dart';

class CustomListTile extends StatelessWidget {
  final PatientLog formData;
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

    void pushToFormView(PatientLog formData) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormView(formData: formData),
            settings: RouteSettings(
              arguments: arguments,
            )),
      );
    }

    void fromDraft() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowDraft(patientLogFromDraft: formData),
            settings: RouteSettings(
              arguments: arguments,
            )),
      );
    }

    void pushToDecisionPage() {
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
        fromDraft();
      } else if (routeTo == 2) {
        pushToFormView(formData);
      } else if (routeTo == 3) {
        pushToDecisionPage();
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
            child: Text(formData.createdAt.toString()),
          ),
          title: Text(formData.speciality?.name ?? "Null"),
          subtitle: Text(formData.attendingPhysician?.attendingName ?? "Null"),
          isThreeLine: true,
        ),
      ),
    );
  }
}
