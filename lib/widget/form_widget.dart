import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? hintText;
  final String? labelText;
  final double fontSize;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final String? initValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
          maxLines: 1,
          initialValue: initValue,
          style: TextStyle(
              fontSize: fontSize, fontWeight: fontWeight, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            fillColor: Colors.grey[200],
            filled: true,
            labelText: labelText,
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            hintText: hintText,
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }

  const FormWidget({
    Key? key,
    this.onTap,
    this.controller,
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.initValue,
    this.hintText,
    this.labelText,
    this.fontSize = 26.0,
    this.validator,
    this.onChanged,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);
}
