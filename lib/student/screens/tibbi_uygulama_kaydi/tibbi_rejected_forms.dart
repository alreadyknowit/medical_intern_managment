import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';

import '../../../shared/constants.dart';
import '../../../shared/tibbi_list_tile.dart';

class TibbiRejectedForms extends StatefulWidget {
  const TibbiRejectedForms({Key? key}) : super(key: key);

  @override
  _TibbiRejectedFormsState createState() => _TibbiRejectedFormsState();
}

class _TibbiRejectedFormsState extends State<TibbiRejectedForms> {
  final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
  Future<void> _refresh() async {
    await _dbHelper.fetchTibbiFormsFromDatabase("reject").then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProcedureLog>?>(
          future: _dbHelper.fetchTibbiFormsFromDatabase('reject'),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProcedureLog>?> snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "Henüz reddedilen formunuz bulunmamaktadır.",
                textAlign: TextAlign.center,
                style: TEXT_STYLE,
              ));
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Sanırım bir şeyler ters gitti', // non-emoji characters
                      ),
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
                      return TibbiCustomListTile(
                          tibbiFormData: snapshot.data![index],
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
