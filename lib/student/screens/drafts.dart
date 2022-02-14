import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';

import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';

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
    _helper.getForms();
  }

  Future<void> _refresh() async {
    await  _helper.getForms();
  }
//TODO: RefreshIndicator not working.
//TODO:When the list changed nothing is happening until the draft section is rebuilt
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FormData>?>(
          future: _helper.getForms(),
          builder:
              (BuildContext context, AsyncSnapshot<List<FormData>?> snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                  child: Text("Henüz kaydedilmiş taslak bulunmamaktadır."));
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Bir şeyler ters gitti.',
                style: TEXT_STYLE,
              ));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return RefreshIndicator(
             triggerMode: RefreshIndicatorTriggerMode.anywhere,
                backgroundColor: Colors.grey[700],
                color: LIGHT_BUTTON_COLOR,
                onRefresh: _refresh,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomListTile(
                        formData: snapshot.data![index], index: index);
                  },
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
