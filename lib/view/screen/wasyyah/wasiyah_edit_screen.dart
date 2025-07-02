import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class WasiyahEditScreen extends StatefulWidget {
   WasiyahEditScreen({super.key});

  @override
  State<WasiyahEditScreen> createState() => _WasiyahEditScreenState();
}

class _WasiyahEditScreenState extends State<WasiyahEditScreen> {
  GetWasyyahResponseModel waseeyaResponseModel = Get.arguments as GetWasyyahResponseModel;
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      if (waseeyaResponseModel != null) {
        titleController.text = waseeyaResponseModel.title ?? "";
        contentController.text = waseeyaResponseModel.content ?? "";

      }
    });
    super.initState();
  }
  WasyyahController wasyyahController = Get.put(WasyyahController());
  @override
  Widget build(BuildContext context) {
    print(titleController.text);
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Wasiyah Edit".tr,fontsize: 18.sp,),),
          body: Container(
            height: Get.height,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: titleController,
                        hintText: "User Name".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        maxLine: 2,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter User Name'.tr;
                          }
                          return null;

                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: contentController,
                        hintText: "User Name".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        maxLine: 20,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter User Name'.tr;
                          }
                          return null;

                        },
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(title: "Cancel".tr, onpress: () {Get.back();},width: 100.w,height: 40.h,color: Colors.red,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(()=>
                             CustomButton(
                               loading: wasyyahController.isUpdateWasseya.value == true,
                              title: "Save".tr, onpress: (){
                              wasyyahController.updateWasyyahData(
                                  orderSeq: waseeyaResponseModel.orderSeq!.toInt(),
                                  visible: waseeyaResponseModel.visible.toString(),
                                  title: titleController.text.toString(),
                                  requestKey: waseeyaResponseModel.requestKey.toString(),
                                  content: contentController.text);
                            },width: 100.w,height: 40.h,color: AppColors.primaryColor,),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

    );
  }
}
