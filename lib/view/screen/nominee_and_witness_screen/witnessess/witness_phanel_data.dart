import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controllers.dart';

// class WitnessPhanelData extends StatelessWidget {
//    WitnessPhanelData({super.key});
//   WitnessController witnessController = Get.put(WitnessController());
//
//   @override
//   Widget build(BuildContext context) {
//     final requestKey = Get.arguments;
//     witnessController.fetchContextsData(requestKey);
//     print("requestKey${requestKey}");
//     return Scaffold(
//
//     );
//   }
// }

import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_image.dart';
import '../../../widgets/widgets.dart';

class WitnessPhanelData extends StatefulWidget {
  WitnessPhanelData({super.key});

  @override
  State<WitnessPhanelData> createState() => _WitnessPhanelDataState();
}

class _WitnessPhanelDataState extends State<WitnessPhanelData> {
  WitnessController witnessController = Get.find<WitnessController>();
  @override
  Widget build(BuildContext context) {
    final requestKey = Get.arguments;
    witnessController.fetchContextsData(requestKey);
    print("requestKey${requestKey}");
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: Image.asset(
                          AppImages.backImg, // your image
                          fit: BoxFit.cover,
                          height: 260,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 30,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.whiteColor,
                        ))),
                Positioned(
                    top: 100,
                    left: 8,
                    right: 8,
                    child: CustomText(
                      text: 'witnessPanel'.tr,
                      fontWeight: FontWeight.w600,
                      fontsize: 32,
                      color: AppColors.primaryColor,
                    )),
                Positioned(
                  top: 212,
                  left: 8,
                  right: 8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Column(
                      children: [
                        // First tile
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            backgroundColor: Colors.white,
                            tilePadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            leading: Icon(Icons.email,
                                color: AppColors.primaryColor),
                            title: Text(
                              'email'.tr,
                              style: TextStyle(
                                color: Color(0xFF205072),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: InkWell(
                                    onTap: () async {
                                      final Uri emailUrl = Uri(
                                        scheme: 'mailto',
                                        path: 'info@carerfinderau.com',
                                        query:
                                            'subject=Support Inquiry&body=Hello, I need assistance with...',
                                      );
                                      if (await launchUrl(emailUrl)) {
                                        await launchUrl(emailUrl);
                                      } else {
                                        debugPrint(
                                            'Could not launch email client');
                                      }
                                    },
                                    child: CustomText(
                                      text: "info@carerfinderau.com",
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.start,
                                      fontsize: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Second tile
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            backgroundColor: Colors.white,
                            tilePadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            leading: Icon(Icons.local_phone_rounded,
                                color: AppColors.primaryColor),
                            title: Text(
                              'phoneString'.tr,
                              style: TextStyle(
                                color: Color(0xFF205072),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: InkWell(
                                    onTap: () async {
                                      final Uri url =
                                          Uri.parse('tel:(880)1634425785');
                                      if (await launchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        debugPrint(
                                            'Could not launch phone dialer');
                                      }
                                    },
                                    child: CustomText(
                                      text: "(880)1634425785",
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.start,
                                      fontsize: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Third tile
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            backgroundColor: Colors.white,
                            tilePadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            leading: Icon(Icons.language_sharp,
                                color: AppColors.primaryColor),
                            title: Text(
                              'website'.tr,
                              style: TextStyle(
                                color: Color(0xFF205072),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: InkWell(
                                    onTap: () {
                                      String rawLink =
                                          "https://carerfinderau.com";

                                      if (!rawLink.startsWith('http://') &&
                                          !rawLink.startsWith('https://')) {
                                        rawLink = 'https://' + rawLink;
                                      }

                                      final url = Uri.parse(rawLink);
                                      launchUrl(url);

                                      print("link link::::::$rawLink");
                                    },
                                    child: CustomText(
                                      text: "https://carerfinderau.com",
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.start,
                                      fontsize: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Other tiles below
          ],
        ),
      ),
    );
  }
}
