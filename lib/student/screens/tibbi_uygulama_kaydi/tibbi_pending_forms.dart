import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';

import '../../../shared/tibbi_list_tile.dart';

class TibbiPendingForms extends StatefulWidget {
  const TibbiPendingForms({Key? key}) : super(key: key);

  @override
  State<TibbiPendingForms> createState() => _TibbiPendingFormsState();
}

class _TibbiPendingFormsState extends State<TibbiPendingForms> {
  final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
  int limit = 50;
  Future<void> _refresh() async {
    await _dbHelper.fetchTibbiFormsFromDatabase("/waiting").then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
          future: _dbHelper.fetchTibbiFormsFromDatabase("/tibbi/waiting"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "Henüz gönderilmiş formunuz bulunmamaktadır.",
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
                      //TODO: emoji
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
              List<dynamic> list = snapshot.data;

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
                    itemCount: list.length,
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
            return Center(
              child: spinkit,
            );
          }),
    );
  }
}
