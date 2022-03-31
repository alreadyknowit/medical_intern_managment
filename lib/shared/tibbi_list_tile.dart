import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/tibbi_form_data.dart';
import 'package:internship_managing_system/shared/tibbi_form_view.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';

import 'constants.dart';

class TibbiCustomListTile extends StatelessWidget {
  final TibbiFormData tibbiFormData;
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

    void pushToFormView(TibbiFormData tibbiFormData) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TibbiFormView(tibbiFormData: tibbiFormData),
            settings: RouteSettings(
              arguments: tibbiFormArguments,
            )),
      );
    }

    void whichPage() {
      pushToFormView(tibbiFormData);
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
            child: Text(tibbiFormData.getTarih()),
          ),
          title: Text(tibbiFormData.getStajTuru()),
          subtitle: Text(tibbiFormData.getDoktor()),
          isThreeLine: true,
        ),
      ),
    );
  }
}
