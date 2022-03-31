import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int? _gerekliFormSayisi = 18;
  late int? _onaylananFormSayisi = 3;
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehaviour;

  @override
  void initState() {
    _chartData = getChartData(_gerekliFormSayisi!, _onaylananFormSayisi!);
    _tooltipBehaviour = TooltipBehavior(enable: true);
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        Container(
          height: 600,
          child: SfCircularChart(
            palette: <Color>[Colors.greenAccent, Colors.blueGrey],
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
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
