
class GetUserResponseModel {
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
  final int? multipleCitizenPassportNo;
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

  GetUserResponseModel({
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

  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) => GetUserResponseModel(
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
    multipleCitizenPassportNo: json["multipleCitizenPassportNo"],
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
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
