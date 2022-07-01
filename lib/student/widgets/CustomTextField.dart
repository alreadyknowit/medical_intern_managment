import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';

import '../../shared/constants.dart';

class CustomTextField extends StatefulWidget {
  int minLine;
  String hintText;
  int maxLength;
  Function onChanged;
  String? initialVal;
  TextEditingController controller;
  double height;

  CustomTextField(this.controller,
      this.minLine, this.hintText, this.maxLength, this.onChanged, this.height);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PADDING_VALUE),
      child: Column(
        children: [
          SizedBox(
            child: Text(
              widget.hintText,
              style: TEXT_STYLE,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: widget.height,
            child: TextFormField(
              controller: widget.controller,
              validator: (value) =>
                  value == null || value.isEmpty ? "Should not be empty" : null,
              onChanged: (input) => widget.onChanged(input),
              autofocus: false,
              textAlignVertical: TextAlignVertical.bottom,
              style: TEXT_STYLE.copyWith(fontSize: 16),
              maxLength: widget.maxLength,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: widget.minLine,
              expands: false,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                // labelStyle:kTextStyle.copyWith(fontSize: 16, color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
