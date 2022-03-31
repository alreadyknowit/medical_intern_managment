import 'package:flutter/material.dart';

import '../../models/form_data.dart';
import '../../shared/custom_alert.dart';
import '../../shared/custom_snackbar.dart';
import '../../shared/form_view.dart';
import '../services/AttendingDatabaseHelper.dart';

class FormDecision extends StatelessWidget {
  final FormData formData;

  FormDecision({Key? key, required this.formData}) : super(key: key);
  final AttendingDatabaseHelper _dbHelper = AttendingDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      formData.setStatus('accept');
      bool res = await _dbHelper.updateFromStatus(formData);
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
