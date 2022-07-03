import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/tibbi_form_view.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';

import 'constants.dart';

class TibbiCustomListTile extends StatelessWidget {
  final ProcedureLog tibbiFormData;
  final int index;
  final int routeTo;
  final bool? isDeletable;

  const TibbiCustomListTile(
      {Key? key,
      required this.tibbiFormData,
      required this.index,
      required this.routeTo,
      this.isDeletable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TibbiFormArguments tibbiFormArguments = TibbiFormArguments(
        tibbiFormData: tibbiFormData, index: index, isDeletable: isDeletable);

    void pushToFormView(ProcedureLog tibbiFormData) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TibbiFormView(tibbiFormData: tibbiFormData),
            settings: RouteSettings(
              arguments: tibbiFormArguments,
            )),
      );
    }

    void fromDraft() {}

    void pushToDecisionPage() {}

    void whichPage() {
      if (routeTo == 1) {
        fromDraft();
      } else if (routeTo == 2) {
        pushToFormView(tibbiFormData);
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
            child: Text(tibbiFormData.createdAt.toString()),
          ),
          title: Text(tibbiFormData.speciality?.name ?? "Null"),
          subtitle:
              Text(tibbiFormData.attendingPhysician?.attendingName ?? "Null"),
          isThreeLine: true,
        ),
      ),
    );
  }
}
