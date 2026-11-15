import 'package:wasiyyat/app/view/profile/model/bank_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/branch_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/view/profile/model/profile_model.dart';

class BankForm {
  BankInfo? original;
  // int? userBankInfoId;
  // int? userId;

  final Rxn<BankModel> bank = Rxn<BankModel>();
  final Rxn<BranchModel> branch = Rxn<BranchModel>();
  final RxList<BranchModel> branchList = <BranchModel>[].obs;

  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountBalance = TextEditingController();

  //BankForm({this.userBankInfoId, this.userId});

  void dispose() {
    accountName.dispose();
    accountBalance.dispose();
  }

  BankForm copy() {
    final newForm = BankForm();
    newForm.bank.value = bank.value;
    newForm.branch.value = branch.value;
    newForm.branchList.assignAll(branchList);
    newForm.accountName.text = accountName.text;
    newForm.accountBalance.text = accountBalance.text;
    newForm.original = original;
    return newForm;
  }
}
