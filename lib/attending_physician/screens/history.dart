import 'package:flutter/material.dart';
import '../services/AttendingDatabaseHelper.dart';
import '../../models/form_data.dart';
import '../../shared/constants.dart';
import '../../shared/custom_list_tile.dart';
import '../../shared/custom_spinkit.dart';

class HistoryForms extends StatefulWidget {
  const HistoryForms({Key? key}) : super(key: key);

  @override
  _HistoryFormsState createState() => _HistoryFormsState();
}

class _HistoryFormsState extends State<HistoryForms> {
 // final AttendingMySqlHelper _mySqlHelper = AttendingMySqlHelper();
  final AttendingDatabaseHelper _dbHelper = AttendingDatabaseHelper();
  Future<void> _refresh() async {
    await _dbHelper.fetchFormsFromDatabase('/reject').then((value) {
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reddedilen Formlar'),
      ),
      body: FutureBuilder<List<FormData>?>(
          future:_dbHelper.fetchFormsFromDatabase('/reject'),
          builder:
              (BuildContext context, AsyncSnapshot<List<FormData>?> snapshot) {
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
                        text: '🧭 🏳️\u200d🌈', // emoji characters
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
                        routeTo:3,
                        isDeletable: false,
                      );
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
