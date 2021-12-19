import 'package:flutter/material.dart';
import 'package:internship_managing_system/constants.dart';
import 'package:internship_managing_system/models/new_form_add.dart';

import 'package:internship_managing_system/models/form_data.dart';

import 'form_page.dart';

class StudentProfile extends StatelessWidget {
   FormAdd formAdd =  FormAdd();
  StudentProfile({required this.formAdd});
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    // formAdd.addNewFormToList(widget.form);

    void pushToFormPage(FormData formData) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  FormPage(formData: formData,)));
    }

    //String kayitNo=Provider.of<FormData>(context).kayitNo;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text('Forms'),
        centerTitle: true,
        titleSpacing: 1.2,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Text('image'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: buildAnalysisContainer(Colors.green, 'Sent', 0),
                    ),
                    Expanded(
                      child: buildAnalysisContainer(
                          Colors.yellowAccent, 'Approvved', 1),
                    ),
                    Expanded(
                      child:
                          buildAnalysisContainer(Colors.blueAccent, 'Draft', 2),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 5,
                      color: Colors.blueAccent,
                    ),
                    itemCount: formAdd.getForms().length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentListViewInstanceContainer(
                          const Color.fromARGB(50, 200, 130, 240),
                          pushToFormPage,
                          formAdd.getForms()[index]);
                    },
                  ),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 5,
                      color: Colors.blueAccent,
                    ),
                    itemCount: formAdd.getForms().length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentListViewInstanceContainer(Colors.deepPurple,
                          pushToFormPage, formAdd.getForms()[index]);
                    },
                  ),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 5,
                      color: Colors.blueAccent,
                    ),
                    itemCount: formAdd.getForms().length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentListViewInstanceContainer(Colors.indigo,
                          pushToFormPage, formAdd.getForms()[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector studentListViewInstanceContainer(
      Color color, Function function, FormData formData) {
    return GestureDetector(
      onTap: () => function(formData),
      child: Container(
        height: 100,
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kayıt No: ${formData.kayitNo}',
              style: kTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tarih: ${formData.kayitNo}',
                  style: kTextStyle.copyWith(fontSize: 15),
                ) //TODO: implement DateTime to 'tarih' instance
              ],
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildAnalysisContainer(
      Color color, String text, int nextPage) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(nextPage,
            duration: const Duration(milliseconds: 250),
            curve: Curves.bounceInOut);
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: color,
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
