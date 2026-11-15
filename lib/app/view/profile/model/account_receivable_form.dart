import 'package:flutter/material.dart';
import 'package:wasiyyat/app/view/profile/model/profile_model.dart';

class AccountReceivableForm {
  ReceivableInfo? original;
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

  AccountReceivableForm copy() {
    final newForm = AccountReceivableForm();
    newForm.original = original;
    newForm.amount.text = amount.text;
    newForm.personName.text = personName.text;
    newForm.personMobile.text = personMobile.text;
    return newForm;
  }
}
