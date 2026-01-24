import 'package:al_wasyeah/models/profile_info_model/bank_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/branch_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankForm {
  final Rxn<BankModel> bank = Rxn<BankModel>();
  final Rxn<BranchModel> branch = Rxn<BranchModel>();
  final RxList<BranchModel> branchList = <BranchModel>[].obs;

  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountBalance = TextEditingController();

  void dispose() {
    accountName.dispose();
    accountBalance.dispose();
  }
}
