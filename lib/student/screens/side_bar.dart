import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internship_managing_system/student/screens/tibbiDrafts.dart';
import 'package:internship_managing_system/student/screens/tibbi_uygulama_kaydi/t%C4%B1bbi_etkilesim_kayd%C4%B1.dart';
import 'package:internship_managing_system/student/screens/tibbi_uygulama_kaydi/tibbi_accepted_forms.dart';
import 'package:internship_managing_system/student/screens/tibbi_uygulama_kaydi/tibbi_pending_forms.dart';
import 'package:internship_managing_system/student/screens/tibbi_uygulama_kaydi/tibbi_rejected_forms.dart';

import '../../shared/constants.dart';
import '../not_managed/notifications.dart';
import '../not_managed/settings.dart';
import '../services/SQFLiteHelper.dart';
import 'dashboard.dart';
import 'drafts.dart';
import 'hasta_etkilesim_kaydi/accepted_forms.dart';
import 'hasta_etkilesim_kaydi/form_page.dart';
import 'hasta_etkilesim_kaydi/pending_forms.dart';
import 'hasta_etkilesim_kaydi/rejected_forms.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  //TODO: The list item counter is not refreshing when it changed.
  var currentPage = DrawerSections.hastaEtkilesim;
  Text? title;
  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  @override
  void initState() {
    super.initState();
    getCounter();
  }

  //int counter = 0;
  getCounter() async {
    return await 1; // _helper.getForms().then((value) => value.length);
  }

  @override
  Widget build(BuildContext context) {
    dynamic container;
    if (currentPage == DrawerSections.hastaEtkilesim) {
      title = const Text("Hasta Etkileşim Formu");
      container = FormPage();
    } else if (currentPage == DrawerSections.taslaklar) {
      title = const Text("Taslaklar");
      container = Drafts();
    } else if (currentPage == DrawerSections.tibbiTaslaklar) {
      title = const Text("Tibbi Uyuglama Taslaklar");
      container = TibbiDrafts();
    } else if (currentPage == DrawerSections.tibbiUygulama) {
      title = const Text("Tıbbi Uygulama Kaydı");
      container = TibbiUygulama();
    } else if (currentPage == DrawerSections.gonderilenFormlar) {
      title = const Text("Onay Bekleyen Fromlar");
      container = const PendingForms();
    } else if (currentPage == DrawerSections.onaylananFormlar) {
      title = const Text("Onaylanan Formlar");
      container = const AcceptedForms();
    } else if (currentPage == DrawerSections.reddedilenFormlar) {
      title = const Text("Reddedilen Formlar");
      container = const RejectedForms();
    } else if (currentPage == DrawerSections.settings) {
      title = const Text("Ayarlar");
      container = const Settings();
    } else if (currentPage == DrawerSections.tibbiAcceptedForms) {
      title = const Text("Tibbi Kabul Edilen Formlar");
      container = const TibbiAcceptedForms();
    } else if (currentPage == DrawerSections.tibbiGonderilenFormlar) {
      title = const Text("Tibbi Onay Bekleyenler");
      container = const TibbiPendingForms();
    } else if (currentPage == DrawerSections.tibbiRejectedForms) {
      title = const Text("Tibbi Reddedilen Formlar");
      container = const TibbiRejectedForms();
    } else if (currentPage == DrawerSections.notifications) {
      title = const Text("Bildirimler");
      container = const Notifications();
    } else if (currentPage == DrawerSections.dashboard) {
      title = const Text(" Dashboard");
      container = Dashboard();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title,
      ),
      body: container,
      drawer: Drawer(
        child: ListView(
          children: [myDrawerList(getCounter())],
        ),
      ),
    );
  }

  Widget myDrawerList(Future<dynamic> res) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(
              0, "Internship Application", FontAwesomeIcons.bookMedical, false),
          const Divider(),
          menuItem(11, "Dashboard", FontAwesomeIcons.chartPie,
              currentPage == DrawerSections.dashboard ? true : false),
          const Divider(),
          ExpansionTile(
            title: const Text(
              "Hasta Etkileşim Kaydı",
            ),
            leading: const Icon(FontAwesomeIcons.map),
            children: [
              menuItem(1, "Hasta Etkileşim Kaydı", FontAwesomeIcons.map,
                  currentPage == DrawerSections.hastaEtkilesim ? true : false),
              menuItem(
                  3,
                  "Onay Bekleyen Formlar",
                  FontAwesomeIcons.ellipsisH,
                  currentPage == DrawerSections.gonderilenFormlar
                      ? true
                      : false),
              menuItem(
                  4,
                  "Onaylanan Formlar",
                  FontAwesomeIcons.heart,
                  currentPage == DrawerSections.onaylananFormlar
                      ? true
                      : false),
              menuItem(
                  5,
                  "Reddedilen Formlar",
                  FontAwesomeIcons.exclamationTriangle,
                  currentPage == DrawerSections.reddedilenFormlar
                      ? true
                      : false),
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: const Text("Tibbi Uygulama Kaydı"),
            leading: const Icon(FontAwesomeIcons.stethoscope),
            children: [
              menuItem(2, "Tıbbi Uygulama Kaydı", FontAwesomeIcons.stethoscope,
                  currentPage == DrawerSections.tibbiUygulama ? true : false),
              menuItem(
                  12,
                  "Onay Bekleyen Formlar",
                  FontAwesomeIcons.ellipsisH,
                  currentPage == DrawerSections.tibbiGonderilenFormlar
                      ? true
                      : false),
              menuItem(
                  13,
                  "Onaylanan Formlar",
                  FontAwesomeIcons.heart,
                  currentPage == DrawerSections.tibbiAcceptedForms
                      ? true
                      : false),
              menuItem(
                  14,
                  "Reddilen Formlar",
                  FontAwesomeIcons.exclamationTriangle,
                  currentPage == DrawerSections.tibbiRejectedForms
                      ? true
                      : false),
              menuItem(15, "Taslaklar", FontAwesomeIcons.database,
                  currentPage == DrawerSections.tibbiTaslaklar ? true : false),
            ],
          ),
          const Divider(),
          menuItem(6, "Taslaklar(0))", FontAwesomeIcons.database,
              currentPage == DrawerSections.taslaklar ? true : false),
          const Divider(),
          menuItem(7, "Ayarlar", FontAwesomeIcons.wrench,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(8, "Bildirimler", FontAwesomeIcons.bell,
              currentPage == DrawerSections.notifications ? true : false),
          const Divider(),
          menuItem(9, "Gizlilik Politikası", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(10, "Geri Bildirim", FontAwesomeIcons.comment,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? const Color(0xff5f5f5) : const Color(0xf000000),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.hastaEtkilesim;
            } else if (id == 2) {
              currentPage = DrawerSections.tibbiUygulama;
            } else if (id == 3) {
              currentPage = DrawerSections.gonderilenFormlar;
            } else if (id == 4) {
              currentPage = DrawerSections.onaylananFormlar;
            } else if (id == 5) {
              currentPage = DrawerSections.reddedilenFormlar;
            } else if (id == 6) {
              currentPage = DrawerSections.taslaklar;
            } else if (id == 7) {
              currentPage = DrawerSections.settings;
            } else if (id == 8) {
              currentPage = DrawerSections.notifications;
            } else if (id == 9) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 10) {
              currentPage = DrawerSections.send_feedback;
            } else if (id == 11) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 12) {
              currentPage = DrawerSections.tibbiGonderilenFormlar;
            } else if (id == 13) {
              currentPage = DrawerSections.tibbiAcceptedForms;
            } else if (id == 14) {
              currentPage = DrawerSections.tibbiRejectedForms;
            } else if (id == 15) {
              currentPage = DrawerSections.tibbiTaslaklar;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(icon, size: 20, color: ICON_COLOR),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TEXT_STYLE,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  tibbiAcceptedForms,
  tibbiRejectedForms,
  hastaEtkilesim,
  tibbiUygulama,
  gonderilenFormlar,
  onaylananFormlar,
  reddedilenFormlar,
  taslaklar,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
  dashboard,
  tibbiGonderilenFormlar,
  tibbiTaslaklar
}
