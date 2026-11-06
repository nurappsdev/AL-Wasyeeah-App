import 'package:flutter/material.dart';

class AccountPayableForm {
  int? payId;
  int? userId;

  final TextEditingController amount = TextEditingController();
  final TextEditingController personName = TextEditingController();
  final TextEditingController personMobile = TextEditingController();

  void dispose() {
    amount.dispose();
    personName.dispose();
    personMobile.dispose();
  }
}
