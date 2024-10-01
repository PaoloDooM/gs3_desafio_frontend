import 'package:flutter/material.dart';

abstract class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  CustomFormState createState();
}

abstract class CustomFormState<T extends CustomForm> extends State<T> {
  void setDisableForm(bool value);

  dynamic submit();

  @override
  Widget build(BuildContext context);
}
