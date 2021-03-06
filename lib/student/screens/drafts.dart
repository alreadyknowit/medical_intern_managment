import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import '../../model/PatientLog.dart';

class Drafts extends StatefulWidget {
  const Drafts({Key? key}) : super(key: key);

  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  final SQFLiteHelper _helper = SQFLiteHelper.instance;

  @override
  void initState() {
    super.initState();
   _refresh();
  }

  Future<void> _refresh() async {
    await _helper.getForms().then((value) {
      setState(() {
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PatientLog>>(
          future:_helper.getForms() ,
          builder: (BuildContext context,
              AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "Henüz kaydedilmiş taslak bulunmamaktadır.",
                textAlign: TextAlign.center,
                style: TEXT_STYLE,
              ));
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Sanırım bir şeyler ters gitti.',
                style: TEXT_STYLE,
              ));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              List<PatientLog> l = snapshot.data;
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
                      PatientLog log = snapshot.data![index];
                      return CustomListTile(
                        formData: snapshot.data![index],
                        index: index,
                        routeTo: 1,
                        isDeletable: true,
                      );
                    },
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator()
            );
          }),
    );
  }
}
