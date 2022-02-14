import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/models/form_data.dart';

class FormList with ChangeNotifier {
  final List<FormData> _sentList = [];

  void addSentList(FormData form) {
    _sentList.add(form);
    notifyListeners();
  }
  List<FormData> getSentList() => _sentList;
}
