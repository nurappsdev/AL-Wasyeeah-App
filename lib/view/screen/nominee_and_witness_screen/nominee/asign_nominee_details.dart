



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/nomineee/nominee_controller.dart';
import '../../../../helpers/helpers.dart';
import '../../../../models/models.dart';
import '../../../../models/nominee/search_asign_nominee_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class AsignNomineeDetails extends StatelessWidget {
  AsignNomineeDetails({super.key});
  final SearchAsignResponseModel user = Get.arguments as SearchAsignResponseModel;
  final String type = Get.parameters["type"] ?? "";
  @override
  Widget build(BuildContext context) {
    NomineeController controller = Get.put(NomineeController());
    print(type);
    return Scaffold(
      appBar: AppBar(title: CustomText(text: type == "WITNESS" ?"Witness Profile Details".tr:"Nominee Profile Details".tr,fontsize: 18.sp,),),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                              radius: 30,
                            ),
                            title: Text(
                              "${user.name}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4), // Shadow color with opacity
                          blurRadius: 10.0, // Softness of the shadow
                          offset: Offset(0.5, 1), // Position of the shadow (x, y)
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, //
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: CustomText(
                              text: "Personal Details".tr,
                              fontsize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 10.h),

                          /// Relation Row
                          _buildRow("Relation:", "${user.relation ?? "N/A"}"),


                          /// Mobile Row
                          _buildRow("Mobile:","${user.mobile ?? "N/A"}"),
                          _buildRow("Profession:","${user.profession ?? "N/A"}"),

                          /// Email Row
                          _buildRow("Email:", "${user.email ?? "N/A"}"),

                          /// Marital Status Row
                          _buildRow("Marital Status:", "${user.maritalStatus ?? "N/A"}"),



                          /// Mother's Name Row
                          _buildRow("Mother’s Name:", "${user.motherName ?? "N/A"}"),

                          /// Father's Name Row
                          _buildRow("Father’s Name:", "${user.fatherName ?? "N/A"}"),

                          /// Buttons
                          SizedBox(height: 30.h),
                          Obx(()=>
                           CustomButtonCommon(
                             loading: controller.isAssignYou.value,
                              title: type == "WITNESS" ? "Assign Witness" : "Assign Nominee",
                              onpress: () {
                                controller.assignNomineeWitnessData(
                                  email: controller.nominessData.value?.email.toString(),
                                  type: type,
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align label and value
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              text: label.tr,
              fontsize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start, // Align text to the start (left)
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomText(
              text: value.tr,
              fontsize: 16.sp,
              maxline: 2,
              textAlign: TextAlign.start, // Align text to the end (right)
            ),
          ),
        ],
      ),
    );
  }
}
