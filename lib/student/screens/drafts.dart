import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_list_tile.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';


class Drafts extends StatelessWidget {
  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  bool isChecked = false;
  bool handleLongPress() {
    isChecked = !isChecked;
    return isChecked;
  }
  //TODO:Taslağa kaydedilen veriyi tekrar taslağa kaydettiğimizde veya gönderdiğimizde boş olarak gönderiyor.
  @override
  Widget build(BuildContext context) {
   // List<FormData> _forms = Provider.of<FormList>(context).getDraftList();
    return Scaffold(
      body: FutureBuilder<List<FormData>?>(
        future:_helper.getForms(),
        builder: (BuildContext context, AsyncSnapshot<List<FormData>?> snapshot) {
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child:  Text("Henüz kaydedilmiş taslak bulunmamaktadır."));
          }
          if (snapshot.hasError) {
            return  Center(child:  Text('Bir şeyler ters gitti.', style: TEXT_STYLE,));
          }if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 2,
                color: LIGHT_BUTTON_COLOR,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomListTile(formData: snapshot.data![index], index: index);
              },
            );
          }
          return Text("loading");
        }
      ),
    );
  }
}
