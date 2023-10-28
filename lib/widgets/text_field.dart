import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget
{
  final String? hint;
  final TextEditingController? controller;

  MyTextField({this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8),
    //   child: TextFormField(
    //     controller: controller,
    //     decoration: InputDecoration.collapsed(hintText: hint),
    //     validator: (value) => value!.isEmpty ? "Field can not be empty" : null,
    //   ),
    // );
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusColor: Theme.of(context).primaryColor,
          hintText: "     " + hint!,
        ),
        validator: (value) => value!.isEmpty ? "Field can not be empty" : null,
      ),
    );
  }
}
