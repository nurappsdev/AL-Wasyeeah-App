// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final UserProfile? userProfile;
  final dynamic socialMediaLink;
  final ParentInfo? parentInfo;
  final List<SpouseInfo>? spouseInfo;
  final List<ChildInfo>? childInfo;
  final List<SiblingInfo>? siblingInfo;
  final List<BankInfo>? bankInfo;
  final List<WealthInfo>? wealthInfo;
  final dynamic shareMarketInfo;
  final List<ReceivableInfo>? receivableInfo;
  final List<PayableInfo>? payableInfo;

  ProfileModel({
    this.userProfile,
    this.socialMediaLink,
    this.parentInfo,
    this.spouseInfo,
    this.childInfo,
    this.siblingInfo,
    this.bankInfo,
    this.wealthInfo,
    this.shareMarketInfo,
    this.receivableInfo,
    this.payableInfo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userProfile: json["userProfile"] == null
            ? null
            : UserProfile.fromJson(json["userProfile"]),
        socialMediaLink: json["socialMediaLink"],
        parentInfo: json["parentInfo"] == null
            ? null
            : ParentInfo.fromJson(json["parentInfo"]),
        spouseInfo: json["spouseInfo"] == null
            ? []
            : List<SpouseInfo>.from(
                json["spouseInfo"]!.map((x) => SpouseInfo.fromJson(x))),
        childInfo: json["childInfo"] == null
            ? []
            : List<ChildInfo>.from(
                json["childInfo"]!.map((x) => ChildInfo.fromJson(x))),
        siblingInfo: json["siblingInfo"] == null
            ? []
            : List<SiblingInfo>.from(
                json["siblingInfo"]!.map((x) => SiblingInfo.fromJson(x))),
        bankInfo: json["bankInfo"] == null
            ? []
            : List<BankInfo>.from(
                json["bankInfo"]!.map((x) => BankInfo.fromJson(x))),
        wealthInfo: json["wealthInfo"] == null
            ? []
            : List<WealthInfo>.from(
                json["wealthInfo"]!.map((x) => WealthInfo.fromJson(x))),
        shareMarketInfo: json["shareMarketInfo"],
        receivableInfo: json["receivableInfo"] == null
            ? []
            : List<ReceivableInfo>.from(
                json["receivableInfo"]!.map((x) => ReceivableInfo.fromJson(x))),
        payableInfo: json["payableInfo"] == null
            ? []
            : List<PayableInfo>.from(
                json["payableInfo"]!.map((x) => PayableInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userProfile": userProfile?.toJson(),
        "socialMediaLink": socialMediaLink,
        "parentInfo": parentInfo?.toJson(),
        "spouseInfo": spouseInfo == null
            ? []
            : List<dynamic>.from(spouseInfo!.map((x) => x.toJson())),
        "childInfo": childInfo == null
            ? []
            : List<dynamic>.from(childInfo!.map((x) => x.toJson())),
        "siblingInfo": siblingInfo == null
            ? []
            : List<dynamic>.from(siblingInfo!.map((x) => x.toJson())),
        "bankInfo": bankInfo == null
            ? []
            : List<dynamic>.from(bankInfo!.map((x) => x.toJson())),
        "wealthInfo": wealthInfo == null
            ? []
            : List<dynamic>.from(wealthInfo!.map((x) => x.toJson())),
        "shareMarketInfo": shareMarketInfo,
        "receivableInfo": receivableInfo == null
            ? []
            : List<dynamic>.from(receivableInfo!.map((x) => x.toJson())),
        "payableInfo": payableInfo == null
            ? []
            : List<dynamic>.from(payableInfo!.map((x) => x.toJson())),
      };
}

class BankInfo {
  final int? userBankInfoId;
  final int? userId;
  final String? bankId;
  final String? branchId;
  final String? bankAccNo;
  final double? accBalance;

  BankInfo({
    this.userBankInfoId,
    this.userId,
    this.bankId,
    this.branchId,
    this.bankAccNo,
    this.accBalance,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        userBankInfoId: json["userBankInfoId"],
        userId: json["userId"],
        bankId: json["bankId"],
        branchId: json["branchId"],
        bankAccNo: json["bankAccNo"],
        accBalance: json["accBalance"],
      );

  Map<String, dynamic> toJson() => {
        "userBankInfoId": userBankInfoId,
        "userId": userId,
        "bankId": bankId,
        "branchId": branchId,
        "bankAccNo": bankAccNo,
        "accBalance": accBalance,
      };
}

class ChildInfo {
  final int? childId;
  final String? childName;
  final int? genderId;
  final int? professionId;
  final int? nationalityId;
  final DateTime? dob;
  final String? nid;
  final String? nidPaperUrl;
  final String? mobile;
  final String? email;
  final bool? existing;
  final int? userId;
  final dynamic nidFile;

  ChildInfo({
    this.childId,
    this.childName,
    this.genderId,
    this.professionId,
    this.nationalityId,
    this.dob,
    this.nid,
    this.nidPaperUrl,
    this.mobile,
    this.email,
    this.existing,
    this.userId,
    this.nidFile,
  });

  factory ChildInfo.fromJson(Map<String, dynamic> json) => ChildInfo(
        childId: json["childId"],
        childName: json["childName"],
        genderId: json["genderId"],
        professionId: json["professionId"],
        nationalityId: json["nationalityId"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        nid: json["nid"],
        nidPaperUrl: json["nidPaperUrl"],
        mobile: json["mobile"],
        email: json["email"],
        existing: json["existing"],
        userId: json["userId"],
        nidFile: json["nidFile"],
      );

  Map<String, dynamic> toJson() => {
        "childId": childId,
        "childName": childName,
        "genderId": genderId,
        "professionId": professionId,
        "nationalityId": nationalityId,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "nid": nid,
        "nidPaperUrl": nidPaperUrl,
        "mobile": mobile,
        "email": email,
        "existing": existing,
        "userId": userId,
        "nidFile": nidFile,
      };
}

class ParentInfo {
  final int? parentId;
  final int? userId;
  final String? fatherName;
  final int? fatherProfessionId;
  final int? fatherNationalityId;
  final String? fatherNid;
  final String? fatherNidUrl;
  final dynamic fatherWhatsAppNumber;
  final bool? fatherExisting;
  final String? motherName;
  final int? motherProfessionId;
  final int? motherNationalityId;
  final String? motherNid;
  final String? motherNidUrl;
  final dynamic motherWhatsAppNumber;
  final bool? motherExisting;
  final dynamic fatherNidFile;
  final dynamic motherNidFile;

  ParentInfo({
    this.parentId,
    this.userId,
    this.fatherName,
    this.fatherProfessionId,
    this.fatherNationalityId,
    this.fatherNid,
    this.fatherNidUrl,
    this.fatherWhatsAppNumber,
    this.fatherExisting,
    this.motherName,
    this.motherProfessionId,
    this.motherNationalityId,
    this.motherNid,
    this.motherNidUrl,
    this.motherWhatsAppNumber,
    this.motherExisting,
    this.fatherNidFile,
    this.motherNidFile,
  });

  factory ParentInfo.fromJson(Map<String, dynamic> json) => ParentInfo(
        parentId: json["parentId"],
        userId: json["userId"],
        fatherName: json["fatherName"],
        fatherProfessionId: json["fatherProfessionId"],
        fatherNationalityId: json["fatherNationalityId"],
        fatherNid: json["fatherNID"],
        fatherNidUrl: json["fatherNIDUrl"],
        fatherWhatsAppNumber: json["fatherWhatsAppNumber"],
        fatherExisting: json["fatherExisting"],
        motherName: json["motherName"],
        motherProfessionId: json["motherProfessionId"],
        motherNationalityId: json["motherNationalityId"],
        motherNid: json["motherNID"],
        motherNidUrl: json["motherNIDUrl"],
        motherWhatsAppNumber: json["motherWhatsAppNumber"],
        motherExisting: json["motherExisting"],
        fatherNidFile: json["fatherNIDFile"],
        motherNidFile: json["motherNIDFile"],
      );

  Map<String, dynamic> toJson() => {
        "parentId": parentId,
        "userId": userId,
        "fatherName": fatherName,
        "fatherProfessionId": fatherProfessionId,
        "fatherNationalityId": fatherNationalityId,
        "fatherNID": fatherNid,
        "fatherNIDUrl": fatherNidUrl,
        "fatherWhatsAppNumber": fatherWhatsAppNumber,
        "fatherExisting": fatherExisting,
        "motherName": motherName,
        "motherProfessionId": motherProfessionId,
        "motherNationalityId": motherNationalityId,
        "motherNID": motherNid,
        "motherNIDUrl": motherNidUrl,
        "motherWhatsAppNumber": motherWhatsAppNumber,
        "motherExisting": motherExisting,
        "fatherNIDFile": fatherNidFile,
        "motherNIDFile": motherNidFile,
      };
}

class PayableInfo {
  final int? payId;
  final int? userId;
  final double? payableAmount;
  final String? payablePerson;
  final String? payablePersonMobile;

  PayableInfo({
    this.payId,
    this.userId,
    this.payableAmount,
    this.payablePerson,
    this.payablePersonMobile,
  });

  factory PayableInfo.fromJson(Map<String, dynamic> json) => PayableInfo(
        payId: json["payId"],
        userId: json["userId"],
        payableAmount: json["payableAmount"],
        payablePerson: json["payablePerson"],
        payablePersonMobile: json["payablePersonMobile"],
      );

  Map<String, dynamic> toJson() => {
        "payId": payId,
        "userId": userId,
        "payableAmount": payableAmount,
        "payablePerson": payablePerson,
        "payablePersonMobile": payablePersonMobile,
      };
}

class ReceivableInfo {
  final int? recId;
  final int? userId;
  final double? receivableAmount;
  final String? receivablePerson;
  final String? receivablePersonMobile;

  ReceivableInfo({
    this.recId,
    this.userId,
    this.receivableAmount,
    this.receivablePerson,
    this.receivablePersonMobile,
  });

  factory ReceivableInfo.fromJson(Map<String, dynamic> json) => ReceivableInfo(
        recId: json["recId"],
        userId: json["userId"],
        receivableAmount: json["receivableAmount"],
        receivablePerson: json["receivablePerson"],
        receivablePersonMobile: json["receivablePersonMobile"],
      );

  Map<String, dynamic> toJson() => {
        "recId": recId,
        "userId": userId,
        "receivableAmount": receivableAmount,
        "receivablePerson": receivablePerson,
        "receivablePersonMobile": receivablePersonMobile,
      };
}

class SiblingInfo {
  final int? siblingId;
  final String? siblingName;
  final int? genderId;
  final int? professionId;
  final int? nationalityId;
  final String? nid;
  final DateTime? dob;
  final bool? existing;
  final String? nidPaperUrl;
  final dynamic whatsAppNumber;
  final String? email;
  final String? mobile;
  final dynamic socialMediaLink;
  final int? userId;
  final dynamic nidFile;

  SiblingInfo({
    this.siblingId,
    this.siblingName,
    this.genderId,
    this.professionId,
    this.nationalityId,
    this.nid,
    this.dob,
    this.existing,
    this.nidPaperUrl,
    this.whatsAppNumber,
    this.email,
    this.mobile,
    this.socialMediaLink,
    this.userId,
    this.nidFile,
  });

  factory SiblingInfo.fromJson(Map<String, dynamic> json) => SiblingInfo(
        siblingId: json["siblingId"],
        siblingName: json["siblingName"],
        genderId: json["genderId"],
        professionId: json["professionId"],
        nationalityId: json["nationalityId"],
        nid: json["nid"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        existing: json["existing"],
        nidPaperUrl: json["nidPaperUrl"],
        whatsAppNumber: json["whatsAppNumber"],
        email: json["email"],
        mobile: json["mobile"],
        socialMediaLink: json["socialMediaLink"],
        userId: json["userId"],
        nidFile: json["nidFile"],
      );

  Map<String, dynamic> toJson() => {
        "siblingId": siblingId,
        "siblingName": siblingName,
        "genderId": genderId,
        "professionId": professionId,
        "nationalityId": nationalityId,
        "nid": nid,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "existing": existing,
        "nidPaperUrl": nidPaperUrl,
        "whatsAppNumber": whatsAppNumber,
        "email": email,
        "mobile": mobile,
        "socialMediaLink": socialMediaLink,
        "userId": userId,
        "nidFile": nidFile,
      };
}

class SpouseInfo {
  final int? spouseId;
  final String? spouseName;
  final int? professionId;
  final int? nationalityId;
  final String? nid;
  final String? nidPaperUrl;
  final dynamic passport;
  final dynamic passportPaperUrl;
  final String? mobile;
  final String? email;
  final bool? existing;
  final int? userId;
  final dynamic spouseNidFile;
  final dynamic spousePassportFile;

  SpouseInfo({
    this.spouseId,
    this.spouseName,
    this.professionId,
    this.nationalityId,
    this.nid,
    this.nidPaperUrl,
    this.passport,
    this.passportPaperUrl,
    this.mobile,
    this.email,
    this.existing,
    this.userId,
    this.spouseNidFile,
    this.spousePassportFile,
  });

  factory SpouseInfo.fromJson(Map<String, dynamic> json) => SpouseInfo(
        spouseId: json["spouseId"],
        spouseName: json["spouseName"],
        professionId: json["professionId"],
        nationalityId: json["nationalityId"],
        nid: json["nid"],
        nidPaperUrl: json["nidPaperUrl"],
        passport: json["passport"],
        passportPaperUrl: json["passportPaperUrl"],
        mobile: json["mobile"],
        email: json["email"],
        existing: json["existing"],
        userId: json["userId"],
        spouseNidFile: json["spouseNIDFile"],
        spousePassportFile: json["spousePassportFile"],
      );

  Map<String, dynamic> toJson() => {
        "spouseId": spouseId,
        "spouseName": spouseName,
        "professionId": professionId,
        "nationalityId": nationalityId,
        "nid": nid,
        "nidPaperUrl": nidPaperUrl,
        "passport": passport,
        "passportPaperUrl": passportPaperUrl,
        "mobile": mobile,
        "email": email,
        "existing": existing,
        "userId": userId,
        "spouseNIDFile": spouseNidFile,
        "spousePassportFile": spousePassportFile,
      };
}

class UserProfile {
  final int? userProfileId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? dob;
  final int? nid;
  final String? nidPaperUrl;
  final dynamic passportNo;
  final String? passportPaperUrl;
  final dynamic passportExpDate;
  final int? maritalStatusId;
  final int? professionId;
  final int? countryCode;
  final int? multipleCitizenCode;
  final String? multipleCitizenPassportNo;
  final String? tin;
  final String? tinPaperUrl;
  final String? nationality;
  final String? mobile;
  final String? gender;
  final dynamic religion;
  final String? district;
  final String? presentAddress;
  final String? permanentAddress;
  final String? profilePictureUrl;
  final int? overseasCountryCode;
  final String? overseasVillage;
  final String? signInSource;
  final String? isActive;
  final int? userTypeId;
  final dynamic insertBy;
  final dynamic insertAt;
  final int? updateBy;
  final dynamic nidFile;
  final dynamic passportFile;
  final dynamic tinFile;
  final dynamic profileFile;

  UserProfile({
    this.userProfileId,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.nid,
    this.nidPaperUrl,
    this.passportNo,
    this.passportPaperUrl,
    this.passportExpDate,
    this.maritalStatusId,
    this.professionId,
    this.countryCode,
    this.multipleCitizenCode,
    this.multipleCitizenPassportNo,
    this.tin,
    this.tinPaperUrl,
    this.nationality,
    this.mobile,
    this.gender,
    this.religion,
    this.district,
    this.presentAddress,
    this.permanentAddress,
    this.profilePictureUrl,
    this.overseasCountryCode,
    this.overseasVillage,
    this.signInSource,
    this.isActive,
    this.userTypeId,
    this.insertBy,
    this.insertAt,
    this.updateBy,
    this.nidFile,
    this.passportFile,
    this.tinFile,
    this.profileFile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userProfileId: json["userProfileId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        nid: json["nid"],
        nidPaperUrl: json["nidPaperUrl"],
        passportNo: json["passportNo"],
        passportPaperUrl: json["passportPaperUrl"],
        passportExpDate: json["passportExpDate"],
        maritalStatusId: json["maritalStatusId"],
        professionId: json["professionId"],
        countryCode: json["countryCode"],
        multipleCitizenCode: json["multipleCitizenCode"],
        multipleCitizenPassportNo:
            json["multipleCitizenPassportNo"]?.toString(),
        tin: json["tin"],
        tinPaperUrl: json["tinPaperUrl"],
        nationality: json["nationality"],
        mobile: json["mobile"],
        gender: json["gender"],
        religion: json["religion"],
        district: json["district"],
        presentAddress: json["presentAddress"],
        permanentAddress: json["permanentAddress"],
        profilePictureUrl: json["profilePictureUrl"],
        overseasCountryCode: json["overseasCountryCode"],
        overseasVillage: json["overseasVillage"],
        signInSource: json["signInSource"],
        isActive: json["isActive"],
        userTypeId: json["userTypeId"],
        insertBy: json["insertBy"],
        insertAt: json["insertAt"],
        updateBy: json["updateBy"],
        nidFile: json["nidFile"],
        passportFile: json["passportFile"],
        tinFile: json["tinFile"],
        profileFile: json["profileFile"],
      );

  Map<String, dynamic> toJson() => {
        "userProfileId": userProfileId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "nid": nid,
        "nidPaperUrl": nidPaperUrl,
        "passportNo": passportNo,
        "passportPaperUrl": passportPaperUrl,
        "passportExpDate": passportExpDate,
        "maritalStatusId": maritalStatusId,
        "professionId": professionId,
        "countryCode": countryCode,
        "multipleCitizenCode": multipleCitizenCode,
        "multipleCitizenPassportNo": multipleCitizenPassportNo,
        "tin": tin,
        "tinPaperUrl": tinPaperUrl,
        "nationality": nationality,
        "mobile": mobile,
        "gender": gender,
        "religion": religion,
        "district": district,
        "presentAddress": presentAddress,
        "permanentAddress": permanentAddress,
        "profilePictureUrl": profilePictureUrl,
        "overseasCountryCode": overseasCountryCode,
        "overseasVillage": overseasVillage,
        "signInSource": signInSource,
        "isActive": isActive,
        "userTypeId": userTypeId,
        "insertBy": insertBy,
        "insertAt": insertAt,
        "updateBy": updateBy,
        "nidFile": nidFile,
        "passportFile": passportFile,
        "tinFile": tinFile,
        "profileFile": profileFile,
      };
}

class WealthInfo {
  final int? userId;
  final int? wealthId;
  final int? documentTypeId;
  final String? documentPaperUrl;
  final String? amount;
  final String? location;
  final String? note;
  final dynamic documentFile;

  WealthInfo({
    this.userId,
    this.wealthId,
    this.documentTypeId,
    this.documentPaperUrl,
    this.amount,
    this.location,
    this.note,
    this.documentFile,
  });

  factory WealthInfo.fromJson(Map<String, dynamic> json) => WealthInfo(
        userId: json["userId"],
        wealthId: json["wealthId"],
        documentTypeId: json["documentTypeId"],
        documentPaperUrl: json["documentPaperUrl"],
        amount: json["amount"],
        location: json["location"],
        note: json["note"],
        documentFile: json["documentFile"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "wealthId": wealthId,
        "documentTypeId": documentTypeId,
        "documentPaperUrl": documentPaperUrl,
        "amount": amount,
        "location": location,
        "note": note,
        "documentFile": documentFile,
      };
}
