
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class CustomDropdown extends StatelessWidget {
  final String label; // Optional label for the dropdown
  final RxString? selectedValue; // Observable selected value
  final List<String>? items; // List of items to display in the dropdown

  const CustomDropdown({
    Key? key,
    this.label = "",
     this.selectedValue,
     this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey key = GlobalKey();
    return Padding(
      padding:  EdgeInsets.all(5.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 6.h),
          Obx(
                () => GestureDetector(
              key: key,
              onTap: () async {
                // Get widget's position
                final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
                final position = renderBox.localToGlobal(Offset.zero);

                // Show popup menu aligned to the right
                final value = await showMenu<String>(

                  context: Get.context!,
                  position: RelativeRect.fromLTRB(
                    position.dx + renderBox.size.width - 150,  // Adjust this value for precise alignment
                    position.dy + renderBox.size.height,
                    position.dx + renderBox.size.width,
                    0,
                  ),
                  items: items!.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                );

                // Set the selected value if user picked an option
                if (value != null) {
                  selectedValue?.value = value;
                  print(selectedValue?.value);
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(text: selectedValue?.value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '$label',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                    suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(color: AppColors.secondaryPrimaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(color:Color(0xff4A8D74), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

