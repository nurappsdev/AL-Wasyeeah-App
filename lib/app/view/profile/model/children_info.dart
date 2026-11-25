
import 'package:flutter/material.dart';

class ChildrenInfo {
  int? childId;
  String? childName;
  int? genderId;
  int? professionId;
  int? nationalityId;
  DateTime? dob;
  String? nid;
  String? nidPaperUrl;
  String? mobile;
  String? email;
  bool? existing;
  int? userId;

  String? nidFile;

  // Controllers for form fields
  TextEditingController childNameController;
  TextEditingController mobileController;
  TextEditingController emailController;
  TextEditingController nidController;
  TextEditingController dobController;

  ChildrenInfo({
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
  })
      : childNameController = TextEditingController(text: childName ?? ''),
        mobileController = TextEditingController(text: mobile ?? ''),
        emailController = TextEditingController(text: email ?? ''),
        nidController = TextEditingController(text: nid ?? ''),
        dobController = TextEditingController(
          text: dob != null ? "${dob.toLocal()}".split(' ')[0] : '',
        );

  ChildrenInfo copyWith({
    int? childId,
    String? childName,
    int? genderId,
    int? professionId,
    int? nationalityId,
    DateTime? dob,
    String? nid,
    String? nidPaperUrl,
    String? mobile,
    String? email,
    bool? existing,
    int? userId,
    String? nidFile,
  }) {
    return ChildrenInfo(
      childId: childId ?? this.childId,
      childName: childName ?? this.childName,
      genderId: genderId ?? this.genderId,
      professionId: professionId ?? this.professionId,
      nationalityId: nationalityId ?? this.nationalityId,
      dob: dob ?? this.dob,
      nid: nid ?? this.nid,
      nidPaperUrl: nidPaperUrl ?? this.nidPaperUrl,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      existing: existing ?? this.existing,
      userId: userId ?? this.userId,
      nidFile: nidFile ?? this.nidFile,
    );
  }
}