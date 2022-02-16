import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import '../../shared/form_view.dart';
import '../services/MySqlHelper.dart';

import '../../models/form_data.dart';
import '../../shared/constants.dart';
import '../../shared/custom_list_tile.dart';

class RejectedForms extends StatefulWidget {
  const RejectedForms({Key? key}) : super(key: key);

  @override
  _RejectedFormsState createState() => _RejectedFormsState();
}

class _RejectedFormsState extends State<RejectedForms> {
  final MySqlHelper _mySqlHelper = MySqlHelper();
  final _status ='reject';
  final _limit=20;
  Future<void> _refresh() async {
    await _mySqlHelper.fetchForms(_status,_limit).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FormData>?>(
          future: _mySqlHelper.fetchForms(_status,_limit),
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
                          formData: snapshot.data![index], index: index,isFormView: true,);
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
