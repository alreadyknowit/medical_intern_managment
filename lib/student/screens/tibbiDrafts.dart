import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/tibbi_list_tile.dart';

import '../../shared/constants.dart';
import '../services/SQFLiteHelper.dart';

class TibbiDrafts extends StatefulWidget {
  const TibbiDrafts({Key? key}) : super(key: key);

  @override
  _TibbiDraftsState createState() => _TibbiDraftsState();
}

class _TibbiDraftsState extends State<TibbiDrafts> {
  final SQFLiteHelper _helper = SQFLiteHelper.instance;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    await _helper.getTibbiForms().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProcedureLog>>(
          future: _helper.getTibbiForms(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              List<ProcedureLog> l = snapshot.data;
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
                      ProcedureLog log = snapshot.data![index];
                      return TibbiCustomListTile(
                        tibbiFormData: snapshot.data![index],
                        index: index,
                        routeTo: 1,
                        isDeletable: true,
                      );
                    },
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
