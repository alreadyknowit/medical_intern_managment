import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';

import '../../../model/PatientLog.dart';
import '../../../shared/constants.dart';
import '../../../shared/custom_list_tile.dart';

class AcceptedForms extends StatefulWidget {
  const AcceptedForms({Key? key}) : super(key: key);

  @override
  _AcceptedFormsState createState() => _AcceptedFormsState();
}

class _AcceptedFormsState extends State<AcceptedForms> {
  final StudentDatabaseHelper dbHelper = StudentDatabaseHelper();
  Future<List<PatientLog>>? fromDatabase;
  Future<void> _refresh() async {
    await dbHelper.fetchFormsFromDatabase('/accepted').then((value) {
      setState(() {
        fromDatabase = (dbHelper.fetchFormsFromDatabase('/accepted')
            as Future<List<PatientLog>>?)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PatientLog>>(
          future: fromDatabase,
          builder:
              (BuildContext context, AsyncSnapshot<List<PatientLog>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "Henüz kabul edilen formunuz bulunmamaktadır.",
                textAlign: TextAlign.center,
                style: TEXT_STYLE,
              ));
            }
            if (snapshot.hasError) {
              return Center(
                child: RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Sanırım bir şeyler ters gitti', // non-emoji characters
                      ),
                      //TODO:Emoji eklenecek
                      TextSpan(
                        text: ' 🧭', // emoji characters
                        style: TextStyle(
                          fontFamily: 'EmojiOne',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return RefreshIndicator(
                backgroundColor: Colors.grey[700],
                color: LIGHT_BUTTON_COLOR,
                onRefresh: _refresh,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomListTile(
                          formData: snapshot.data![index],
                          index: index,
                          routeTo: 2);
                    },
                  ),
                ),
              );
            }
            return spinkit;
          }),
    );
  }
}
