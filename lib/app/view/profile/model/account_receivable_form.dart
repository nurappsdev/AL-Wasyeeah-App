import 'package:flutter/material.dart';

class AccountReceivableForm {
  // int? recId;
  // int? userId;

  final TextEditingController amount = TextEditingController();
  final TextEditingController personName = TextEditingController();
  final TextEditingController personMobile = TextEditingController();

  //AccountReceivableForm({this.recId, this.userId});

  void dispose() {
    amount.dispose();
    personName.dispose();
    personMobile.dispose();
  }
}
