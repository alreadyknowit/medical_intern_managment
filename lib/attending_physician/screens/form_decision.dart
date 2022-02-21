import 'package:flutter/material.dart';
import 'package:internship_managing_system/attending_physician/screens/history.dart';
import 'package:internship_managing_system/attending_physician/services/AttendingMySqlHelper.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_alert.dart';
import 'package:internship_managing_system/shared/custom_snackbar.dart';
import 'package:internship_managing_system/shared/form_view.dart';
import 'package:internship_managing_system/student/services/MySqlHelper.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';

import '../../models/form_data.dart';

class FormDecision extends StatelessWidget {
  FormData formData;
  FormDecision({Key? key, required this.formData}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    handleSubmit()async {
      formData.setStatus('accept');
      bool res= await _helper.update(formData);
      if(res){
        Navigator.pop(context);
        customSnackBar(context,'Form başarıyla onaylandı' );

      } else{
        errorAlert(context);
      }
    }
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: formViewBody(formData)),
            SizedBox(height: 20,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.08,
              width: 150,
              child: ElevatedButton(
                onPressed: () =>handleSubmit(),
                child: Text('Onayla'),
              ),
            )
          ],
        ),
      ),
    );
  }
 final AttendingMySqlHelper _helper =AttendingMySqlHelper();

}
