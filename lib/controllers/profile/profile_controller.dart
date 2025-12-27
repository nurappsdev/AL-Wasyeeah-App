import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/helpers/file_picker_util.dart';
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

import '../../services/services.dart';
import 'package:al_wasyeah/helpers/file_download_util.dart';
import 'profile_enum.dart';
import 'spouse_form.dart';
import 'child_form.dart';
import 'personal_form.dart';
import 'address_form.dart';
import 'parent_form.dart';

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

  RxMap<ProfileDownloadType, bool> isDownloadingMap =
      <ProfileDownloadType, bool>{}.obs;
  RxMap<ProfileDownloadType, double> downloadProgressMap =
      <ProfileDownloadType, double>{}.obs;

  RxMap<ProfilePickerType, PickedFileResult> pickedFileMap =
      <ProfilePickerType, PickedFileResult>{}.obs;

  // Spouse List Management
  RxList<SpouseForm> spouseList = <SpouseForm>[].obs;

  // Children List Management
  RxList<ChildForm> childrenList = <ChildForm>[].obs;

  final step1formKey = GlobalKey<FormState>();
  final step2formKey = GlobalKey<FormState>();
  @override
  void onInit() async {
    getProfilePageData();
    super.onInit();
  }

  void onStepTapped(int step) {
    currentStep(step);
    pageController.animateToPage(
      step,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void pickFile(ProfilePickerType type) async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      pickedFileMap[type] = result;
    }
  }

  Future<bool> downloadFile({
    required String? urlPath,
    required String filePrefix,
    required ProfileDownloadType type,
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
    log("$filePrefix File Path: $filePath");

    FileDownloadUtil.downloadFile(
      filePath,
      fileName,
      (progress) {
        downloadProgressMap[type] = progress;

        if (progress >= 100) {
          isDownloadingMap[type] = false;
          log("Download $filePrefix Successful");
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

  // Child File Logic
  void pickChildFile(ChildForm form, {required ProfilePickerType type}) async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      if (type == ProfilePickerType.childNidOrPassport) {
        form.selectedNidFile.value = result;
      }
    }
  }

  Future<void> downloadChildFile(ChildForm form,
      {required ProfileDownloadType type}) async {
    if (type != ProfileDownloadType.childNidOrPassport) return;
    String? urlPath = form.nidUrl;
    if (urlPath == null) return;

    form.isDownloadingNid.value = true;
    form.nidDownloadProgress.value = 0.0;

    final String fileName =
        'Child_NID_${form.name.text}_${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';
    final String filePath = '${ApiConstants.imageUrl}$urlPath';

    await FileDownloadUtil.downloadFile(
      filePath,
      fileName,
      (prog) {
        form.nidDownloadProgress.value = prog;
        if (prog >= 100) {
          form.isDownloadingNid.value = false;
        }
      },
    ).catchError((e) {
      form.isDownloadingNid.value = false;
    });
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
      // If needed we can call API to delete if it's an existing item
      item.dispose();
      spouseList.removeAt(index);
    }
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

  Future<void> getWealthList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.wealthList,
      );
      wealthList(wealthListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
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

    personalForm.value.selectedGender.value =
        genderList.firstWhereOrNull((e) => e.genderId == user.gender);

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
        final form = SpouseForm(
          nameVal: spouse.spouseName,
          nidVal: spouse.nid,
          passportVal: spouse.passport?.toString() ?? '',
          mobileVal: spouse.mobile,
          emailVal: spouse.email,
          nidUrl: spouse.nidPaperUrl,
          passportUrl: spouse.passportPaperUrl?.toString(),
          isAliveVal: spouse.existing ?? true,
        );

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

  @override
  void onClose() {
    personalForm.value.dispose();
    addressForm.value.dispose();
    parentForm.value.dispose();
    super.onClose();
  }
}










/*
   var response = await ApiClient.getData(
        ApiConstants.getProfile,
      );

      profileModel(profileModelFromJson(jsonEncode(response.body)));
      // first name
      firstNameController.value.text =
          profileModel.value.userProfile!.firstName ?? "";
      // last name
      lastNameController.value.text =
          profileModel.value.userProfile!.lastName ?? "";
      // marital status
      selectedMarried.value = maritalList.firstWhere((element) =>
          element.maritalId == profileModel.value.userProfile!.maritalStatusId);
      // country
      selectedCountry.value = countryList.firstWhere((element) =>
          element.countryId == profileModel.value.userProfile!.countryCode);
      // district
      districtController.value.text =
          profileModel.value.userProfile!.district ?? "";
      // nid
      nidController.value.text = profileModel.value.userProfile!.nid.toString();
      // passport
      citizenshipPassportOrNIDController.value.text =
          profileModel.value.userProfile!.passportNo ?? "";
      selectedProfession.value = professionList.firstWhere((element) =>
          element.professionId == profileModel.value.userProfile!.professionId);
      // country
      selectedCountry.value = countryList.firstWhere((element) =>
          element.countryId == profileModel.value.userProfile!.countryCode);
      // gender
      selectedGender.value = genderList.firstWhere((element) =>
          element.genderId ==
          int.parse(profileModel.value.userProfile!.gender.toString()));
      // tin number
      tinController.value.text = profileModel.value.userProfile!.tin ?? "";
      // multi citizen passport
      multiCitizenPassportController.value.text =
          profileModel.value.userProfile!.multipleCitizenPassportNo ?? "";
      // present zip code
      presentZipCodeController.value.text =
          profileModel.value.userProfile!.presentAddress?.split(',')[0] ?? "";
      // present village
      presentVillageController.value.text =
          profileModel.value.userProfile!.presentAddress?.split(',')[1] ?? "";
      presentRoadController.value.text =
          profileModel.value.userProfile!.presentAddress?.split(',')[2] ?? "";

      // overseas country
      selectedOverseasCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.userProfile!.overseasCountryCode);

      // overseas village
      overseasVillageController.value.text =
          profileModel.value.userProfile!.overseasVillage ?? "";

      // father name
      fatherNameController.value.text =
          profileModel.value.parentInfo?.fatherName ?? "";
      // father profession
      selectedFatherProfession.value = professionList.firstWhere((element) =>
          element.professionId ==
          profileModel.value.parentInfo?.fatherProfessionId);
      // father country
      selectedFatherCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.parentInfo?.fatherNationalityId);
      // father passport or nid
      fatherPassOrNIDController.value.text =
          profileModel.value.parentInfo?.fatherNid.toString() ?? "";
      // father alive dead
      isFatherAlive.value =
          profileModel.value.parentInfo?.fatherExisting ?? false;
      // mother name
      motherNameController.value.text =
          profileModel.value.parentInfo?.motherName ?? "";

      // mother profession
      selectedMotherProfession.value = professionList.firstWhere((element) =>
          element.professionId ==
          profileModel.value.parentInfo?.motherProfessionId);
      // mother country
      selectedMotherCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.parentInfo?.motherNationalityId);
      // mother passport or nid
      motherPassOrNIDController.value.text =
          profileModel.value.parentInfo?.motherNid.toString() ?? "";
      // mother alive dead
      isMotherAlive.value =
          profileModel.value.parentInfo?.motherExisting ?? false;
      // Spouse
      spouseList.clear();
      if (profileModel.value.spouseInfo != null) {
        for (var spouse in profileModel.value.spouseInfo!) {
          spouseList.add(SpouseForm(
            spouseId: spouse.spouseId,
            userId: spouse.userId,
            existing: spouse.existing,
            nameVal: spouse.spouseName,
            nidVal: spouse.nid,
            passportVal:
                spouse.passport != null ? spouse.passport.toString() : '',
            mobileVal: spouse.mobile,
            emailVal: spouse.email,
            nidUrl: spouse.nidPaperUrl,
            passportUrl: spouse.passportPaperUrl != null
                ? spouse.passportPaperUrl.toString()
                : null,
            isAliveVal: true,
          ));

          if (spouseList.last.profession.value == null &&
              spouse.professionId != null) {
            spouseList.last.profession.value = professionList
                .firstWhereOrNull((p) => p.professionId == spouse.professionId);
          }
          if (spouseList.last.nationality.value == null &&
              spouse.nationalityId != null) {
            spouseList.last.nationality.value = countryList
                .firstWhereOrNull((c) => c.countryId == spouse.nationalityId);
          }
        }
      } else {
        spouseList.add(SpouseForm());
      }

      // Populate Children List
      childrenList.clear();
      if (profileModel.value.childInfo != null) {
        for (var child in profileModel.value.childInfo!) {
          ChildForm form = ChildForm();
          form.name.text = child.childName ?? "";
          form.nid.text = child.nid ?? "";
          form.mobile.text = child.mobile ?? "";
          form.email.text = child.email ?? "";
          if (child.dob != null) {
            form.selectedDob.value = child.dob;
          }
          form.nidUrl = child.nidPaperUrl;
          form.isAlive.value = child.existing ?? true;

          if (child.professionId != null) {
            form.profession.value = professionList
                .firstWhereOrNull((e) => e.professionId == child.professionId);
          }
          if (child.nationalityId != null) {
            form.nationality.value = countryList
                .firstWhereOrNull((e) => e.countryId == child.nationalityId);
          }
          if (child.genderId != null) {
            form.gender.value = genderList
                .firstWhereOrNull((e) => e.genderId == child.genderId);
          }

          childrenList.add(form);
        }
      } else {
        childrenList.add(ChildForm());
      }

      if (profileModel.value.userProfile!.multipleCitizenCode != null) {
        selectedMultiCitizenCountry.value = countryList.firstWhere((element) =>
            element.countryId ==
            profileModel.value.userProfile!.multipleCitizenCode);
      }

      selectedBank(
        bankList.firstWhere(
          (element) => profileModel.value.bankInfo!.any(
            (bank) => bank.bankId == element.bankId,
          ),
        ),
      );

      selectedWealth(
        wealthList.firstWhere(
          (element) => profileModel.value.wealthInfo!.any(
            (wealth) => wealth.wealthId == element.wealthId,
          ),
        ),
      );
 */