import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_managing_system/DBURL.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String selectedValue;
  List<dynamic> courseID = [];

  Future getCourseNames() async {
    var response = await http.get(Uri.parse("${DBURL.url}/staj_kodu.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        courseID = jsonData;
      });
    }
    print(courseID);
  }

  Map<String, dynamic> map = {};
  late int? _gerekliFormSayisi = 18;
  late int? _onaylananFormSayisi = 3;
  late List<GDPData> _chartData;
  late List<Course> courseList;
  late List<ExpenseData> _specialityData;
  late TooltipBehavior _tooltipBehaviour;

  @override
  void initState() {
    _specialityData = getCourseData();
    _chartData = getChartData(_gerekliFormSayisi!, _onaylananFormSayisi!);
    _tooltipBehaviour = TooltipBehavior(enable: true);
    getCourseNames();
    super.initState();
  }

  List<Course> courses = [
    Course(id: 1, courseName: "Course1"),
    Course(id: 2, courseName: "Course2"),
    Course(id: 3, courseName: "Course3")
  ];
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          // CustomDropDown(courses, "Course"),
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
                  dataSource: _specialityData,
                  xValueMapper: (ExpenseData exp, _) => exp.specialityName,
                  yValueMapper: (ExpenseData exp, _) => exp.gerekliForm,
                  name: 'Gerekli Form'),
              StackedBar100Series<ExpenseData, String>(
                  color: Colors.blue,
                  dataSource: _specialityData,
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
  List<GDPData> getChartData(int gerekliFormSayisi, int _onaylananFormSayisi) {
    this._onaylananFormSayisi = _onaylananFormSayisi;
    _gerekliFormSayisi = _gerekliFormSayisi;
    final List<GDPData> chartData = [
      GDPData('Onaylanan Rapor Sayısı', _onaylananFormSayisi),
      GDPData('Kalan Rapor Sayısı', _gerekliFormSayisi! - _onaylananFormSayisi),
    ];
    return chartData;
  }

  List<ExpenseData> getCourseData() {
    List<ExpenseData> specialityData = [
      ExpenseData("Kardiyoloji", 25, 13),
      ExpenseData("Üroloji", 25, 11),
      ExpenseData("Genel Cerrah", 33, 13),
      ExpenseData("Acil", 45, 13),
      ExpenseData("Başhekimlik", 25, 11),
    ];
    return specialityData;
  }
}

class ExpenseData {
  ExpenseData(this.specialityName, this.gerekliForm, this.onaylananForm);
  late String specialityName;
  late int gerekliForm;
  late int onaylananForm;
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    Key? key,
    required TooltipBehavior tooltipBehaviour,
    required List<GDPData> chartData,
    required int? gerekliFormSayisi,
  })  : _tooltipBehaviour = tooltipBehaviour,
        _chartData = chartData,
        _gerekliFormSayisi = gerekliFormSayisi,
        super(key: key);

  final TooltipBehavior _tooltipBehaviour;
  final List<GDPData> _chartData;
  final int? _gerekliFormSayisi;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 300,
          child: SfCircularChart(
            palette: const [Colors.greenAccent, Colors.blueGrey],
            title: ChartTitle(
              text: 'Hasta Etkileşim Kaydı',
            ),
            legend: Legend(
              isVisible: true,
            ),
            tooltipBehavior: _tooltipBehaviour,
            series: <CircularSeries>[
              DoughnutSeries<GDPData, String>(
                  dataSource: _chartData,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
          ),
        ),
        Text(
          "Gönderilmesi Gereken Toplam Rapor sayısı: $_gerekliFormSayisi",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 35),
        const Divider(
            color: Colors.white10, thickness: 2, indent: 10, endIndent: 10),
        Container(
          height: 600,
          child: SfCircularChart(
            palette: <Color>[Colors.brown, Colors.cyan],
            title: ChartTitle(
              text: 'Tıbbi Uygulama Kaydı',
            ),
            legend: Legend(
              isVisible: true,
            ),
            tooltipBehavior: _tooltipBehaviour,
            series: <CircularSeries>[
              DoughnutSeries<GDPData, String>(
                  dataSource: _chartData,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
          ),
        ),
        Text(
          "Gönderilmesi Gereken Toplam Rapor sayısı: $_gerekliFormSayisi",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

class GDPData {
  String continent = "ssadas";
  int gdp = 1213;
  GDPData(this.continent, this.gdp);
}
