import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:internship_managing_system/student/services/MySqlHelper.dart';
import 'package:provider/provider.dart';

class SentForms extends StatefulWidget {
  const SentForms({Key? key}) : super(key: key);

  @override
  State<SentForms> createState() => _SentFormsState();
}

class _SentFormsState extends State<SentForms> {
  final MySqlHelper _mySqlHelper = MySqlHelper();
  Future<void> _refresh() async {
    print('refresh method is called');
    await _mySqlHelper.fetchWaitingForms().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FormData>?>(
          future: _mySqlHelper.fetchWaitingForms(),
          builder:
              (BuildContext context, AsyncSnapshot<List<FormData>?> snapshot) {
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
                          formData: snapshot.data![index], index: index);
                    },
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
