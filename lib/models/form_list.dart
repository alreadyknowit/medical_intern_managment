import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/models/form_data.dart';

class FormList with ChangeNotifier {
  //final List<FormData> _draftList = [];
  final List<FormData> _sentList = [];/*
  void addDraftList(FormData form) {
    _draftList.add(form);
    notifyListeners();
  }
*/
  void addSentList(FormData form) {
    _sentList.add(form);
    notifyListeners();
  }
/*
  void updateDraftList(int index, FormData data) {
    _draftList.removeAt(index);
    _draftList.insert(index, data);
    notifyListeners();
  }*/
/*
  void deleteFormInstance(int index) {
    _draftList.removeAt(index);
    notifyListeners();
  }
*/
 // List<FormData> getDraftList() => _draftList;
  List<FormData> getSentList() => _sentList;
}
