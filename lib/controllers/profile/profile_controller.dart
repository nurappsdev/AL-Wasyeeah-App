import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/models/profile_info_model/document_type_form.dart';
import 'package:al_wasyeah/models/profile_info_model/sibling_form.dart';
import 'package:al_wasyeah/models/profile_info_model/branch_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:al_wasyeah/models/profile_info_model/bank_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profile_model.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_list_model.dart';
import 'package:get/get.dart';

import 'dart:io';
import '../../utils/app_colors.dart';
import '../../utils/app_en_strings.dart';
import '../../utils/app_constant.dart';
import '../../services/services.dart';
import 'package:al_wasyeah/models/profile_info_model/account_payable_form.dart';
import 'package:al_wasyeah/models/profile_info_model/account_receivable_form.dart';
import 'package:al_wasyeah/models/profile_info_model/bank_form.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_form.dart';
import 'package:al_wasyeah/helpers/file_download_util.dart';
import '../../models/profile_info_model/address_form.dart';
import '../../models/profile_info_model/child_form.dart';
import '../../models/profile_info_model/parent_form.dart';
import '../../models/profile_info_model/personal_form.dart';
import '../../models/profile_info_model/spouse_form.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentStep = 0.obs;
  Rx<RxStatus> status = RxStatus.loading().obs;
  RxList<MaritalModel> maritalList = <MaritalModel>[].obs;
  RxList<ProfessionModel> professionList = <ProfessionModel>[].obs;
  RxList<GenderModel> genderList = <GenderModel>[].obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  RxList<BankModel> bankList = <BankModel>[].obs;

  RxList<WealthModel> wealthList = <WealthModel>[].obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  Rx<PersonalForm> personalForm = PersonalForm().obs;
  Rx<AddressForm> addressForm = AddressForm().obs;
  Rx<ParentForm> parentForm = ParentForm().obs;

  RxMap<String, bool> isDownloadingMap = <String, bool>{}.obs;
  RxMap<String, double> downloadProgressMap = <String, double>{}.obs;

  // Spouse List Management
  RxList<SpouseForm> spouseList = <SpouseForm>[].obs;

  // Children List Management
  RxList<ChildForm> childrenList = <ChildForm>[].obs;
  RxList<SiblingForm> siblingList = <SiblingForm>[].obs;

  // Step 5 Lists
  RxList<BankForm> bankListForm = <BankForm>[].obs;
  RxList<WealthForm> wealthListForm = <WealthForm>[].obs;
  RxList<DocumentTypeForm> documentTypeListForm = <DocumentTypeForm>[].obs;
  RxList<AccountReceivableForm> receivableListForm =
      <AccountReceivableForm>[].obs;
  RxList<AccountPayableForm> payableListForm = <AccountPayableForm>[].obs;

  final step1formKey = GlobalKey<FormState>();
  final step2formKey = GlobalKey<FormState>();
  final step3formKey = GlobalKey<FormState>();
  final step4formKey = GlobalKey<FormState>();
  final step5formKey = GlobalKey<FormState>();

  void onStepTapped(int step) {
    currentStep(step);
    pageController.animateToPage(
      step,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<bool> downloadFile({
    required String? urlPath,
    required String filePrefix,
    required String type,
  }) async {
    if (urlPath == null) {
      return false;
    }

    isDownloadingMap[type] = true;
    downloadProgressMap[type] = 0.0;

    final completer = Completer<bool>();

    final String fileName =
        '${filePrefix}_${profileModel.value.userProfile?.firstName ?? "User"}_'
        '${profileModel.value.userProfile?.lastName ?? ""}_'
        '${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';

    final String filePath = '${ApiConstants.imageUrl}$urlPath';

    FileDownloadUtil.downloadFile(
      filePath,
      fileName,
      (progress) {
        downloadProgressMap[type] = progress;

        if (progress >= 100) {
          isDownloadingMap[type] = false;
          log("Download $filePrefix Successful");
        }

        if (progress == 100) {
          completer.complete(true);
        }
      },
    ).catchError((e) {
      isDownloadingMap[type] = false;
      log('Download $filePrefix failed: $e');
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });

    return completer.future;
  }

  Future<void> getMaritalList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.maritalList,
      );
      maritalList(maritalListModelFromJson(jsonEncode(response.body)));
    } catch (e, s) {
      log("Marital List Error: $e\nStacktrace: $s");
    }
  }

  Future<void> getGenderList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.genderList,
      );

      genderList(genderListModelFromJson(jsonEncode(response.body)));
      log("Gender list: ${genderList.toJson()}");
    } catch (e, s) {
      log("Gender List Error: $e\nStacktrace: $s");
    }
  }

  Future<void> getProfessionList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.professionList,
      );
      professionList(professionListFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getCountryList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.countryList,
      );
      countryList(countryListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getBankList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.bankList,
      );
      bankList(bankListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<List<BranchModel>> getBranchList(String bankId) async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.branchList + "?bankId=$bankId",
      );
      return branchListModelFromJson(jsonEncode(response.body));
    } catch (e) {
      return [];
    }
  }

  Future<void> getWealthList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.wealthList,
      );
      wealthList(wealthListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<List<DocumentTypeForm>> getDocumentTypeList(String wealthId) async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.documentTypeList + "?lang=en&wealthId=$wealthId",
      );
      return documentTypeListFromJson(jsonEncode(response.body));
    } catch (e) {
      return [];
    }
  }

  Future<void> getProfile() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.getProfile,
      );

      profileModel(profileModelFromJson(jsonEncode(response.body)));
      _mapPersonalInfo();
      _mapAddressInfo();
      _mapParentInfo();
      _mapSpouseInfo();
      _mapChildrenInfo();
      _mapSiblingInfo();
      _mapBankInfo();
      _mapWealthInfo();
      _mapReceivableInfo();
      _mapPayableInfo();
    } catch (e, s) {
      log("Error: $e\nStacktrace: $s");
    }
  }

  getProfilePageData() async {
    try {
      status(RxStatus.loading());
      await getMaritalList();
      await getProfessionList();
      await getCountryList();
      await getGenderList();
      await getBankList();
      await getWealthList();
      await getProfile();
      status(RxStatus.success());
    } catch (e) {
      status(RxStatus.error());
    }
  }

  void _mapPersonalInfo() {
    final user = profileModel.value.userProfile!;
    personalForm.value.firstName.text = user.firstName ?? '';
    personalForm.value.lastName.text = user.lastName ?? '';
    personalForm.value.district.text = user.district ?? '';
    personalForm.value.nid.text = user.nid?.toString() ?? '';
    personalForm.value.tin.text = user.tin ?? '';
    personalForm.value.multiCitizenPassport.text =
        user.multipleCitizenPassportNo ?? '';

    personalForm.value.selectedMarried.value = maritalList
        .firstWhereOrNull((e) => e.maritalId == user.maritalStatusId);

    personalForm.value.selectedProfession.value = professionList
        .firstWhereOrNull((e) => e.professionId == user.professionId);

    personalForm.value.selectedCountry.value =
        countryList.firstWhereOrNull((e) => e.countryId == user.countryCode);

    personalForm.value.selectedGender.value = genderList
        .firstWhereOrNull((e) => e.genderId.toString() == user.gender);

    personalForm.value.selectedMultiCitizenCountry.value = countryList
        .firstWhereOrNull((e) => e.countryId == user.multipleCitizenCode);

    personalForm.value.nidUrl = user.nidPaperUrl;
    personalForm.value.tinUrl = user.tinPaperUrl;
    personalForm.value.multiCitizenUrl = user.passportPaperUrl;
  }

  void _mapAddressInfo() {
    final user = profileModel.value.userProfile!;

    if (user.presentAddress != null) {
      final parts = user.presentAddress!.split(',');
      addressForm.value.presentZipCode.text = parts.elementAtOrNull(0) ?? '';
      addressForm.value.presentVillage.text = parts.elementAtOrNull(1) ?? '';
      addressForm.value.presentRoad.text = parts.elementAtOrNull(2) ?? '';
    }

    addressForm.value.overseasVillage.text = user.overseasVillage ?? '';

    addressForm.value.selectedOverseasCountry.value = countryList
        .firstWhereOrNull((e) => e.countryId == user.overseasCountryCode);
  }

  void _mapParentInfo() {
    final parent = profileModel.value.parentInfo;
    if (parent == null) return;

    // Father
    parentForm.value.fatherName.text = parent.fatherName ?? '';
    parentForm.value.fatherPassOrNID.text = parent.fatherNid?.toString() ?? '';
    parentForm.value.isFatherAlive.value = parent.fatherExisting ?? false;
    parentForm.value.fatherNidUrl = parent.fatherNidUrl;

    parentForm.value.selectedFatherProfession.value = professionList
        .firstWhereOrNull((e) => e.professionId == parent.fatherProfessionId);

    parentForm.value.selectedFatherCountry.value = countryList
        .firstWhereOrNull((e) => e.countryId == parent.fatherNationalityId);

    // Mother
    parentForm.value.motherName.text = parent.motherName ?? '';
    parentForm.value.motherPassOrNID.text = parent.motherNid?.toString() ?? '';
    parentForm.value.isMotherAlive.value = parent.motherExisting ?? false;
    parentForm.value.motherNidUrl = parent.motherNidUrl;

    parentForm.value.selectedMotherProfession.value = professionList
        .firstWhereOrNull((e) => e.professionId == parent.motherProfessionId);

    parentForm.value.selectedMotherCountry.value = countryList
        .firstWhereOrNull((e) => e.countryId == parent.motherNationalityId);
  }

  void _mapSpouseInfo() {
    spouseList.clear();

    final spouses = profileModel.value.spouseInfo;

    if (spouses != null && spouses.isNotEmpty) {
      for (final spouse in spouses) {
        final form = SpouseForm();

        /// Text fields
        form.name.text = spouse.spouseName ?? '';
        form.nid.text = spouse.nid ?? '';
        form.passport.text = spouse.passport?.toString() ?? '';
        form.mobile.text = spouse.mobile ?? '';
        form.email.text = spouse.email ?? '';

        /// Alive / Dead
        form.isAlive.value = spouse.existing ?? true;

        /// API file URLs
        form.nidUrl = spouse.nidPaperUrl;
        form.passportUrl = spouse.passportPaperUrl?.toString();

        /// Profession
        if (spouse.professionId != null) {
          form.profession.value = professionList.firstWhereOrNull(
            (p) => p.professionId == spouse.professionId,
          );
        }

        /// Nationality
        if (spouse.nationalityId != null) {
          form.nationality.value = countryList.firstWhereOrNull(
            (c) => c.countryId == spouse.nationalityId,
          );
        }

        spouseList.add(form);
      }
    } else {
      /// Always keep one empty spouse form
      spouseList.add(SpouseForm());
    }
  }

  void _mapChildrenInfo() {
    childrenList.clear();

    final children = profileModel.value.childInfo;

    if (children != null && children.isNotEmpty) {
      for (final child in children) {
        final form = ChildForm();

        /// Text fields
        form.name.text = child.childName ?? '';
        form.nid.text = child.nid ?? '';
        form.mobile.text = child.mobile ?? '';
        form.email.text = child.email ?? '';

        /// DOB
        if (child.dob != null) {
          form.selectedDob.value = child.dob;
        }

        /// Status
        form.isAlive.value = child.existing ?? true;

        /// File URLs
        form.nidUrl = child.nidPaperUrl;

        /// Profession
        if (child.professionId != null) {
          form.profession.value = professionList.firstWhereOrNull(
            (p) => p.professionId == child.professionId,
          );
        }

        /// Nationality
        if (child.nationalityId != null) {
          form.nationality.value = countryList.firstWhereOrNull(
            (c) => c.countryId == child.nationalityId,
          );
        }

        /// Gender
        if (child.genderId != null) {
          form.gender.value = genderList.firstWhereOrNull(
            (g) => g.genderId == child.genderId,
          );
        }

        childrenList.add(form);
      }
    } else {
      /// Always keep one empty child form
      childrenList.add(ChildForm());
    }
  }

  void addChild() {
    childrenList.add(ChildForm());
  }

  void removeChild(int index) {
    if (index >= 0 && index < childrenList.length) {
      childrenList[index].dispose();
      childrenList.removeAt(index);
    }
  }

  void addSpouse() {
    spouseList.add(SpouseForm());
  }

  void removeSpouse(int index) {
    if (index >= 0 && index < spouseList.length) {
      final item = spouseList[index];
      item.dispose();
      spouseList.removeAt(index);
    }
  }

  void _mapSiblingInfo() {
    siblingList.clear();

    final siblings = profileModel.value.siblingInfo;

    if (siblings != null && siblings.isNotEmpty) {
      for (final sibling in siblings) {
        final form = SiblingForm();

        /// Text fields
        form.name.text = sibling.siblingName ?? '';
        form.nid.text = sibling.nid ?? '';
        form.mobile.text = sibling.mobile ?? '';
        form.email.text = sibling.email ?? '';

        /// DOB
        if (sibling.dob != null) {
          form.selectedDob.value = sibling.dob;
        }

        /// Status
        form.isAlive.value = sibling.existing ?? true;

        /// File URLs
        form.nidUrl = sibling.nidPaperUrl;

        /// Profession
        if (sibling.professionId != null) {
          form.profession.value = professionList.firstWhereOrNull(
            (p) => p.professionId == sibling.professionId,
          );
        }

        /// Nationality
        if (sibling.nationalityId != null) {
          form.nationality.value = countryList.firstWhereOrNull(
            (c) => c.countryId == sibling.nationalityId,
          );
        }

        /// Gender
        if (sibling.genderId != null) {
          form.gender.value = genderList.firstWhereOrNull(
            (g) => g.genderId == sibling.genderId,
          );
        }

        siblingList.add(form);
      }
    } else {
      /// Always keep one empty sibling form
      siblingList.add(SiblingForm());
    }
  }

  void addSibling() {
    siblingList.add(SiblingForm());
  }

  void removeSibling(int index) {
    if (index >= 0 && index < siblingList.length) {
      siblingList[index].dispose();
      siblingList.removeAt(index);
    }
  }

  // Bank Info Management
  void _mapBankInfo() async {
    bankListForm.clear();
    final banks = profileModel.value.bankInfo;
    if (banks != null && banks.isNotEmpty) {
      for (final bank in banks) {
        final form = BankForm();
        form.bank.value =
            bankList.firstWhereOrNull((e) => e.bankId == bank.bankId);
        var branches = await getBranchList(bank.bankId.toString());
        form.branchList.value = branches;

        if (bank.branchId != null) {
          form.branch.value = branches.firstWhereOrNull(
            (b) => b.branchId == bank.branchId,
          );
        }

        form.accountName.text = bank.bankAccNo ?? '';
        form.accountBalance.text = bank.accBalance?.toString() ?? '';
        bankListForm.add(form);
      }
    } else {
      bankListForm.add(BankForm());
    }
  }

  void addBank() {
    bankListForm.add(BankForm());
  }

  void removeBank(int index) {
    if (index >= 0 && index < bankListForm.length) {
      bankListForm[index].dispose();
      bankListForm.removeAt(index);
    }
  }

  void onBankChanged(BankForm form, BankModel? bank) async {
    form.bank.value = bank;
    form.branch.value = null;
    form.branchList.clear();

    if (bank != null && bank.bankId != null) {
      var branches = await getBranchList(bank.bankId.toString());
      form.branchList.value = branches;
    }
  }

  // Wealth Info Management
  void _mapWealthInfo() async {
    wealthListForm.clear();
    final wealths = profileModel.value.wealthInfo;

    if (wealths != null && wealths.isNotEmpty) {
      for (final wealth in wealths) {
        final form = WealthForm();
        form.wealth.value =
            wealthList.firstWhereOrNull((e) => e.wealthId == wealth.wealthId);

        if (wealth.wealthId != null) {
          var docTypes = await getDocumentTypeList(wealth.wealthId.toString());
          form.documentTypeList.value = docTypes;

          if (wealth.documentTypeId != null) {
            form.selectedDocumentType.value = docTypes.firstWhereOrNull(
              (d) => d.documentTypeId == wealth.documentTypeId,
            );
          }
        }

        form.landArea.text =
            wealth.amount ?? ''; // Assuming 'amount' maps to 'Land Area'
        form.location.text = wealth.location ?? '';
        form.note.text = wealth.note ?? '';
        form.documentUrl = wealth.documentPaperUrl;

        wealthListForm.add(form);
      }
    } else {
      wealthListForm.add(WealthForm());
    }
  }

  void addWealth() {
    wealthListForm.add(WealthForm());
  }

  void removeWealth(int index) {
    if (index >= 0 && index < wealthListForm.length) {
      wealthListForm[index].dispose();
      wealthListForm.removeAt(index);
    }
  }

  void onWealthChanged(WealthForm form, WealthModel? wealth) async {
    form.wealth.value = wealth;
    form.selectedDocumentType.value = null;
    form.documentTypeList.clear();

    if (wealth != null && wealth.wealthId != null) {
      var docTypes = await getDocumentTypeList(wealth.wealthId.toString());
      form.documentTypeList.value = docTypes;
    }
  }

  // Account Receivable Management
  void _mapReceivableInfo() {
    receivableListForm.clear();
    final receivables = profileModel.value.receivableInfo;

    if (receivables != null && receivables.isNotEmpty) {
      for (final rec in receivables) {
        final form = AccountReceivableForm();
        form.amount.text = rec.receivableAmount?.toString() ?? '';
        form.personName.text = rec.receivablePerson ?? '';
        form.personMobile.text = rec.receivablePersonMobile ?? '';
        receivableListForm.add(form);
      }
    } else {
      receivableListForm.add(AccountReceivableForm());
    }
  }

  void addReceivable() {
    receivableListForm.add(AccountReceivableForm());
  }

  void removeReceivable(int index) {
    if (index >= 0 && index < receivableListForm.length) {
      receivableListForm[index].dispose();
      receivableListForm.removeAt(index);
    }
  }

  // Account Payable Management
  void _mapPayableInfo() {
    payableListForm.clear();
    final payables = profileModel.value.payableInfo;

    if (payables != null && payables.isNotEmpty) {
      for (final pay in payables) {
        final form = AccountPayableForm();
        form.amount.text = pay.payableAmount?.toString() ?? '';
        form.personName.text = pay.payablePerson ?? '';
        form.personMobile.text = pay.payablePersonMobile ?? '';
        payableListForm.add(form);
      }
    } else {
      payableListForm.add(AccountPayableForm());
    }
  }

  void addPayable() {
    payableListForm.add(AccountPayableForm());
  }

  void removePayable(int index) {
    if (index >= 0 && index < payableListForm.length) {
      payableListForm[index].dispose();
      payableListForm.removeAt(index);
    }
  }

  Future<String?> _fileToBase64(File? file) async {
    if (file == null) return null;
    try {
      List<int> fileBytes = await file.readAsBytes();
      return base64Encode(fileBytes);
    } catch (e) {
      log("Error converting file to base64: $e");
      return null;
    }
  }

  Future<void> submitProfile() async {
    try {
      status(RxStatus.loading());

      final personal = personalForm.value;
      final address = addressForm.value;
      final parent = parentForm.value;

      // 1. Map UserProfile
      final userProfile = UserProfile(
        userProfileId: profileModel.value.userProfile?.userProfileId,
        firstName: personal.firstName.text,
        lastName: personal.lastName.text,
        maritalStatusId: personal.selectedMarried.value?.maritalId,
        professionId: personal.selectedProfession.value?.professionId,
        countryCode: personal.selectedCountry.value?.countryId,
        district: personal.district.text,
        gender: personal.selectedGender.value?.genderId.toString(),
        nid: int.tryParse(personal.nid.text),
        tin: personal.tin.text,
        multipleCitizenCode:
            personal.selectedMultiCitizenCountry.value?.countryId,
        multipleCitizenPassportNo: personal.multiCitizenPassport.text,
        presentAddress:
            "${address.presentZipCode.text},${address.presentVillage.text},${address.presentRoad.text}",
        permanentAddress: address.isPresentAddressAsPermanentAddress.value
            ? "${address.presentZipCode.text},${address.presentVillage.text},${address.presentRoad.text}"
            : "${address.permanentZipCode.text},${address.permanentVillage.text},${address.permanentRoad.text}",
        overseasCountryCode: address.selectedOverseasCountry.value?.countryId,
        overseasVillage: address.overseasVillage.text,
        nidFile: await _fileToBase64(personal.selectedNidFile.value?.file),
        tinFile: await _fileToBase64(personal.selectedTinFile.value?.file),
        passportFile:
            await _fileToBase64(personal.selectedMultiCitizenFile.value?.file),
      );

      // 2. Map ParentInfo
      final parentInfo = ParentInfo(
        parentId: profileModel.value.parentInfo?.parentId,
        fatherName: parent.fatherName.text,
        fatherProfessionId: parent.selectedFatherProfession.value?.professionId,
        fatherNationalityId: parent.selectedFatherCountry.value?.countryId,
        fatherNid: parent.fatherPassOrNID.text,
        fatherExisting: parent.isFatherAlive.value,
        motherName: parent.motherName.text,
        motherProfessionId: parent.selectedMotherProfession.value?.professionId,
        motherNationalityId: parent.selectedMotherCountry.value?.countryId,
        motherNid: parent.motherPassOrNID.text,
        motherExisting: parent.isMotherAlive.value,
        fatherNidFile:
            await _fileToBase64(parent.selectedFatherFile.value?.file),
        motherNidFile:
            await _fileToBase64(parent.selectedMotherFile.value?.file),
      );

      // 3. Map SpouseInfo
      List<SpouseInfo> spouses = [];
      for (var form in spouseList) {
        if (form.name.text.isEmpty) continue;
        spouses.add(SpouseInfo(
          spouseName: form.name.text,
          professionId: form.profession.value?.professionId,
          nationalityId: form.nationality.value?.countryId,
          nid: form.nid.text,
          passport: form.passport.text,
          mobile: form.mobile.text,
          email: form.email.text,
          existing: form.isAlive.value,
          spouseNidFile: await _fileToBase64(form.selectedNidFile.value?.file),
          spousePassportFile:
              await _fileToBase64(form.selectedPassportFile.value?.file),
        ));
      }

      // 4. Map ChildInfo
      List<ChildInfo> children = [];
      for (var form in childrenList) {
        if (form.name.text.isEmpty) continue;
        children.add(ChildInfo(
          childName: form.name.text,
          professionId: form.profession.value?.professionId,
          nationalityId: form.nationality.value?.countryId,
          genderId: form.gender.value?.genderId,
          dob: form.selectedDob.value,
          nid: form.nid.text,
          mobile: form.mobile.text,
          email: form.email.text,
          existing: form.isAlive.value,
          nidFile: await _fileToBase64(form.selectedNidFile.value?.file),
        ));
      }

      // 5. Map SiblingInfo
      List<SiblingInfo> siblings = [];
      for (var form in siblingList) {
        if (form.name.text.isEmpty) continue;
        siblings.add(SiblingInfo(
          siblingName: form.name.text,
          professionId: form.profession.value?.professionId,
          nationalityId: form.nationality.value?.countryId,
          genderId: form.gender.value?.genderId,
          dob: form.selectedDob.value,
          nid: form.nid.text,
          mobile: form.mobile.text,
          email: form.email.text,
          existing: form.isAlive.value,
          nidFile: await _fileToBase64(form.selectedNidFile.value?.file),
        ));
      }

      // 6. Map BankInfo
      List<BankInfo> banks = [];
      for (var form in bankListForm) {
        if (form.bank.value == null) continue;
        banks.add(BankInfo(
          bankId: form.bank.value?.bankId.toString(),
          branchId: form.branch.value?.branchId.toString(),
          bankAccNo: form.accountName.text,
          accBalance: double.tryParse(form.accountBalance.text),
        ));
      }

      // 7. Map WealthInfo
      List<WealthInfo> wealths = [];
      for (var form in wealthListForm) {
        if (form.wealth.value == null) continue;
        wealths.add(WealthInfo(
          wealthId: form.wealth.value?.wealthId,
          documentTypeId: form.selectedDocumentType.value?.documentTypeId,
          amount: form.landArea.text,
          location: form.location.text,
          note: form.note.text,
          documentFile: await _fileToBase64(form.documentFile.value?.file),
        ));
      }

      // 8. Map ReceivableInfo
      List<ReceivableInfo> receivables = [];
      for (var form in receivableListForm) {
        if (form.amount.text.isEmpty) continue;
        receivables.add(ReceivableInfo(
          receivableAmount: double.tryParse(form.amount.text),
          receivablePerson: form.personName.text,
          receivablePersonMobile: form.personMobile.text,
        ));
      }

      // 9. Map PayableInfo
      List<PayableInfo> payables = [];
      for (var form in payableListForm) {
        if (form.amount.text.isEmpty) continue;
        payables.add(PayableInfo(
          payableAmount: double.tryParse(form.amount.text),
          payablePerson: form.personName.text,
          payablePersonMobile: form.personMobile.text,
        ));
      }

      final submitData = ProfileModel(
        userProfile: userProfile,
        parentInfo: parentInfo,
        spouseInfo: spouses,
        childInfo: children,
        siblingInfo: siblings,
        bankInfo: banks,
        wealthInfo: wealths,
        receivableInfo: receivables,
        payableInfo: payables,
      );

      var response = await ApiClient.postData(
        ApiConstants.profileUpdate,
        submitData.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: AppString.profileUpdatedSuccessfully.tr);
        await getProfile(); // Refresh local data
      } else {
        Fluttertoast.showToast(msg: "Update failed: ${response.statusText}".tr);
      }
    } catch (e, s) {
      log("Error during submission: $e\n$s");
      Fluttertoast.showToast(msg: AppString.somethingWentWrong.tr);
    } finally {
      status(RxStatus.success());
    }
  }

  @override
  void onInit() async {
    getProfilePageData();
    super.onInit();
  }

  @override
  void onClose() {
    personalForm.value.dispose();
    addressForm.value.dispose();
    parentForm.value.dispose();
    for (final form in spouseList) {
      form.dispose();
    }
    for (final form in childrenList) {
      form.dispose();
    }
    for (final form in siblingList) {
      form.dispose();
    }
    for (final form in bankListForm) {
      form.dispose();
    }
    for (final form in wealthListForm) {
      form.dispose();
    }
    for (final form in receivableListForm) {
      form.dispose();
    }
    for (final form in payableListForm) {
      form.dispose();
    }
    super.onClose();
  }
}
