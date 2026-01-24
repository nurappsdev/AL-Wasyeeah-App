import 'package:flutter/material.dart';

class AccountReceivableForm {
  final TextEditingController amount = TextEditingController();
  final TextEditingController personName = TextEditingController();
  final TextEditingController personMobile = TextEditingController();

  void dispose() {
    amount.dispose();
    personName.dispose();
    personMobile.dispose();
  }
}
