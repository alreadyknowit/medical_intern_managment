import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';

class PendingForms extends StatefulWidget {
  const PendingForms({Key? key}) : super(key: key);

  @override
  State<PendingForms> createState() => _PendingFormsState();
}

class _PendingFormsState extends State<PendingForms> {
  final StudentDatabaseHelper _dbHelper= StudentDatabaseHelper();
  int limit=50;
  Future<void> _refresh() async {

    await _dbHelper.fetchFormsFromDatabase("/waiting").then((value) {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
          future: _dbHelper.fetchFormsFromDatabase("/waiting"),
          builder:
              (BuildContext context, AsyncSnapshot snapshot) {
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
                      return CustomListTile(
                          formData: list[index], index: index,routeTo: 1, isDeletable: false,);
                    },
                  ),
                ),
              );
            }
            return  Center(
              child: spinkit,
            );
          }),
    );
  }
}
