import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/models/form_data.dart';


class FormAdd with ChangeNotifier{

  final List<FormData> _list =[];
  void addNewFormToList(FormData form){
    _list.add(form);
    notifyListeners();
  }
  List<FormData> getForms()=>_list;
}