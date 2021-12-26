import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/new_form_add.dart';
import 'package:internship_managing_system/student/saved_forms.dart';
import 'package:internship_managing_system/student/student_home_page.dart';
import 'package:internship_managing_system/student/student_forms.dart';
class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  var currentPage = DrawerSections.taslaklar;

 @override
  Widget build(BuildContext context) {
   FormAdd formAdd =  FormAdd();

   var container;
   if (currentPage == DrawerSections.hastaEtkilesim) {
     container = StudentHomePage();
   } else if (currentPage == DrawerSections.taslaklar) {
     container = const SavedForms(); //TODO: FormAdd kaldır.
   }

    return  Scaffold(
        body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
                  myDrawerList()
            ],
          ),
        ),
      ),

    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Hasta Etkileşim Kaydı", Icons.dashboard_outlined,
              currentPage == DrawerSections.hastaEtkilesim ? true : false),
          menuItem(2, "Tıbbi Uygulama Kaydı", Icons.local_hospital,
              currentPage == DrawerSections.tibbiUygulama ? true : false),
          menuItem(3, "Taslaklar", Icons.event,
              currentPage == DrawerSections.taslaklar ? true : false),
          const Divider(),
          menuItem(4, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(5, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          const Divider(),
          menuItem(6, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(7, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }


  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.hastaEtkilesim;
            } else if (id == 2) {
              currentPage = DrawerSections.tibbiUygulama;
            } else if (id == 3) {
              currentPage = DrawerSections.taslaklar;
            } else if (id == 4) {
              currentPage = DrawerSections.settings;
            } else if (id == 5) {
              currentPage = DrawerSections.notifications;
            } else if (id == 6) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 7) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
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
  hastaEtkilesim,
  tibbiUygulama,
  taslaklar,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}
