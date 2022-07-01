import 'dart:core';

import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/PatientLog.dart ';
import '../../shared/constants.dart';
import '../services/StudentDatabaseHelper.dart';
import '../widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String selectedValue;
  List<dynamic> courseID = [];

  Future _getCourses() async {
    await StudentDatabaseHelper().fetchCourses().then((response) {
//      print(data);
      setState(() {
        courses = response;
        _selectedCourse = courses[0].courseName;
      });
    });
  }

  Map<String, dynamic> map = {};

  late List<Course> courseList;

  late TooltipBehavior _tooltipBehaviour;

  @override
  void initState() {
    _getCourses();
    getCourseData();
    _tooltipBehaviour = TooltipBehavior(enable: true);

    super.initState();
  }

  List<Course> courses = [];
  List<Speciality> specialities = [];
  late int idCourse;
  late int idSpecialities;
  String? _selectedCourse = "Course1";
  String? _selectedSpeciality = "";

  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              children: [
                Text(
                  "Courses",
                  style: TEXT_STYLE,
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING_VALUE),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonFormField(
                        key: PageStorageKey<BuildContext>(context),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        isExpanded: true,
                        validator: (val) => val == null ? 'Course Name' : null,
                        value: _selectedCourse,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: ICON_COLOR,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        dropdownColor: Colors.grey[800],
                        style: TEXT_STYLE,
                        onChanged: (newValue) {
                          setState(() {
                            getCourseData();
                            _selectedCourse = newValue.toString();
                            for (int i = 0; i < courses.length; i++) {
                              if (courses[i].courseName == _selectedCourse) {
                                idCourse = courses[i].id;
                              }
                            }
                            _getSpecialities(idCourse);
                            if (newValue is Course) {
                              Provider.of<PatientLog>(context, listen: false)
                                  .setCourse(newValue);
                            }
                            _selectedCourse != newValue;
                          });

                          print(newValue);
                          print(specialityData);
                        },
                        items: courses.map((item) {
                          return DropdownMenuItem(
                            child: Text(item.courseName),
                            value: item.courseName,
                          );
                        }).toList()),
                  ),
                ),
              ],
            ),
          ),
          // CustomDropDown(courses, "Course"),
          // TODO : Bir önce ki seçilen menünün itemlerini gösteriyor düzeltilmesi lazım.
          const SizedBox(height: 20),
          /*ChartWidget(
              tooltipBehaviour: _tooltipBehaviour,
              chartData: _chartData,
              gerekliFormSayisi: _gerekliFormSayisi),*/
          SfCartesianChart(
            title: ChartTitle(text: "Specilities"),
            legend: Legend(isVisible: true, position: LegendPosition.top),
            tooltipBehavior: _tooltipBehaviour,
            series: <ChartSeries>[
              StackedBar100Series<ExpenseData, String>(
                  color: Colors.red,
                  dataSource: specialityData,
                  xValueMapper: (ExpenseData exp, _) => exp.specialityName,
                  yValueMapper: (ExpenseData exp, _) => exp.gerekliForm,
                  name: 'Gerekli Form'),
              StackedBar100Series<ExpenseData, String>(
                  color: Colors.blue,
                  dataSource: specialityData,
                  xValueMapper: (ExpenseData exp, _) => exp.specialityName,
                  yValueMapper: (ExpenseData exp, _) => exp.onaylananForm,
                  name: 'Onaylanan Form'),
            ],
            primaryXAxis: CategoryAxis(),
          )
        ],
      ),
    ));
  }

//Onaylanan raporlar gösterilecek, kalan rapor sayısı kaç rapor gönderilmesi gerekiyorsa o sayıdan çıkarılıp eklenecek

  Speciality speciality = Speciality(
    id: 1,
    name: "name",
  );
  List<ExpenseData> specialityData = [];

  Future _getSpecialities(int id) async {
    List<Speciality> newList = [];
    await StudentDatabaseHelper().fetchSpeciality().then((response) {
      setState(() {
        for (int i = 0; i < response.length; i++) {
          if (response[i].id == id) {
            newList.add(response[i]);
            specialities = newList;
          }
        }

        _selectedSpeciality = specialities[0].name;
      });
    });

    return specialities;
  }

  List<ExpenseData> getCourseData() {
    List<ExpenseData> newSpecialityData = [];
    setState(() {
      for (int i = 0; i < specialities.length; i++) {
        newSpecialityData.add(ExpenseData(specialities[i].name, 25, 13));

        specialityData = newSpecialityData;
      }
    });
    return specialityData;
  }
}

class ExpenseData {
  ExpenseData(this.specialityName, this.gerekliForm, this.onaylananForm);
  late String specialityName;
  late int gerekliForm;
  late int onaylananForm;
}
