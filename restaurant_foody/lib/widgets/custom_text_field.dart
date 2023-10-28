import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget
{
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecre,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.black, width: 1.0), // Add this line for border
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.purple.withOpacity(0.25),
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }

}
