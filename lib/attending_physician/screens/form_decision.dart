import 'package:flutter/material.dart';

import '../../model/PatientLog.dart';
import '../../shared/custom_alert.dart';
import '../../shared/custom_snackbar.dart';
import '../../shared/form_view.dart';
import '../services/AttendingDatabaseHelper.dart';

class FormDecision extends StatelessWidget {
  final PatientLog formData;

  FormDecision({Key? key, required this.formData}) : super(key: key);
  final AttendingDatabaseHelper _dbHelper = AttendingDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      formData.setStatus('accept');
      bool res = await _dbHelper.updateFormStatus(formData);
      if (res) {
        Navigator.pop(context);
        customSnackBar(context, 'Form başarıyla onaylandı');
      } else {
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
                height: MediaQuery.of(context).size.height * 0.8,
                child: formViewBody(formData)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: 150,
              child: ElevatedButton(
                onPressed: () => handleSubmit(),
                child: const Text('Onayla'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
