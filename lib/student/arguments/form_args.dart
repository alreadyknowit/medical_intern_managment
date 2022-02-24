import 'package:internship_managing_system/models/form_data.dart';

class FormArguments{
  FormData formData;
  int index;
  bool? isDeletable;
  FormArguments({required this.formData, required this.index,  this.isDeletable});

}