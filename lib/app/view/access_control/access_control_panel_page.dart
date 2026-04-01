import 'dart:developer';

import 'package:al_wasyeah/app/view/access_control/controller/access_control_controller.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/core/utils/extensions.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/view/access_control/model/witness_nominee_context_data_model.dart';
import 'package:al_wasyeah/app/view/profile/controller/profile_controller.dart';
import 'package:al_wasyeah/app/view/property_distribution_calculation/model/property_destribution_result_model.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/services/pdf/pdf_service.dart';
import 'package:al_wasyeah/app/view/wasiyyah/model/wasyyah_model.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AccessControlPanelPage extends StatefulWidget {
  const AccessControlPanelPage({super.key});

  @override
  State<AccessControlPanelPage> createState() => _AccessControlPanelPageState();
}

class _AccessControlPanelPageState extends State<AccessControlPanelPage> {
  final AccessControlController accessControlController = Get.find<AccessControlController>();

  String? _wasyyahPdfPath;
  int _pdfTotalPages = 0;
  int _pdfCurrentPage = 0;
  bool _pdfIsReady = false;
  String? _pdfError;
  bool _isGeneratingPdf = false;

  @override
  void initState() {
    String data = Get.arguments;
    accessControlController.fetchContextsPanelData(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.access_control_panel,
      ),
      body: Obx(() {
        final status = accessControlController.contextsPanelDataStatus.value;

        if (status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (status.isEmpty || status.isError) {
          return Center(
            child: Text(status.errorMessage ?? AppLocalizations.of(context)!.no_data),
          );
        }

        final data = accessControlController.witnessNomineeContextData.value;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              if (data.zakat != null) _buildZakatCard(data.zakat!, context),
              if (data.propertyResult != null && data.propertyResult!.isNotEmpty) ...[
                _buildPieChartSection(data.propertyResult!),
                _buildResultCards(data.propertyResult!),
              ],
              if (data.wasiyaaContent != null && data.wasiyaaContent!.isNotEmpty && data.wasiyaaContent!.any((e) => e.visible == "Y")) ...[
                _buildWasiyyahPdfPreview(data.wasiyaaContent!),
              ],
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  final List<Color> _chartColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  Widget _buildZakatCard(Zakat zakat, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: AppColors.primaryColor),
                SizedBox(width: 8.w),
                Text(
                  AppLocalizations.of(context)!.zakat_information,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            _resultRow(AppLocalizations.of(context)!.total_asset, "${zakat.totalAsset?.toLocal()} ${zakat.currencyCode ?? ''}"),
            _resultRow(AppLocalizations.of(context)!.zakat_amount, "${zakat.zakatAmount?.toLocal()} ${zakat.currencyCode ?? ''}"),
            if (zakat.lastCalculate != null) _resultRow(AppLocalizations.of(context)!.last_calculated, DateFormat('dd MMM yyyy', Get.locale.toString()).format(zakat.lastCalculate!)),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartSection(List<PropertydistributionResultModel> propertyResult) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          SizedBox(
            height: 250.h,
            child: PieChart(
              PieChartData(
                sections: propertyResult.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;

                  final percentage = (data.portionPart ?? 0) * 100;
                  return PieChartSectionData(
                    color: _chartColors[index % _chartColors.length],
                    value: percentage,
                    title: '${percentage.toLocal()}%',
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            children: propertyResult.asMap().entries.map((entry) {
              final index = entry.key;
              final data = entry.value;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: _chartColors[index % _chartColors.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _getRelativeName(data.relativeName, context),
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCards(List<PropertydistributionResultModel> propertyResult) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: propertyResult.length,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemBuilder: (context, index) {
        final PropertydistributionResultModel data = propertyResult[index];
        return Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 24.h,
                      color: _chartColors[index % _chartColors.length],
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _getRelativeName(data.relativeName, context),
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                _resultRow(AppLocalizations.of(context)!.share_portion, "${((data.portionPart ?? 0) * 100).toLocal()}%"),
                if (data.landPart != null && data.landPart! > 0) _resultRow(AppLocalizations.of(context)!.land_portion, "${data.landPart?.toLocal()} ${AppLocalizations.of(context)!.decimal}"),
                if (data.goldPart != null && data.goldPart! > 0) _resultRow(AppLocalizations.of(context)!.gold_portion, "${data.goldPart?.toLocal()} ${AppLocalizations.of(context)!.gram_vori}"),
                if (data.silverPart != null && data.silverPart! > 0) _resultRow(AppLocalizations.of(context)!.silver_portion, "${data.silverPart?.toLocal()} ${AppLocalizations.of(context)!.gram_vori}"),
                if (data.currencyPart != null && data.currencyPart! > 0) _resultRow(AppLocalizations.of(context)!.total_money, "${data.currencyPart?.toLocal()} ${AppLocalizations.of(context)!.taka}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
          Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _getRelativeName(String? name, BuildContext context) {
    if (name == null) {
      return AppLocalizations.of(context)!.n_a;
    }

    final locale = Localizations.localeOf(context).languageCode;
    final match = RegExp(r'\((\d+)\)').firstMatch(name);

    if (match != null) {
      final numberStr = match.group(1);
      final number = int.tryParse(numberStr ?? '');

      if (number != null) {
        final formattedNumber = NumberFormat.decimalPattern(locale).format(number);
        return name.replaceFirst(
          match.group(0)!,
          '($formattedNumber)',
        );
      }
    }

    return name;
  }

  Future<void> _ensureWasyyahPdf(List<WasyyahContentModel> content) async {
    final profileController = Get.find<ProfileController>();
    final personalData = profileController.personalForm;
    final user = profileController.profileModel;
    final qrData = {
      "name": "${personalData.value.firstName} ${personalData.value.lastName}",
      "email": user.value.userProfile?.email ?? "N/A",
      "phone": user.value.userProfile?.mobile ?? "N/A",
      "date_of_birthday": user.value.userProfile?.dob ?? "N/A",
      "profession": personalData.value.selectedProfession.value?.profession ?? "N/A",
      "gender": personalData.value.selectedGender.value?.gender ?? "N/A",
      "maritialStatus": personalData.value.selectedMarried.value?.maritalType ?? "N/A",
      "permanent_address": user.value.userProfile?.permanentAddress ?? "N/A",
      "present_address": user.value.userProfile?.presentAddress ?? "N/A",
      "country": personalData.value.selectedCountry.value?.country ?? "N/A",
      "nid": personalData.value.nid,
      "tin": personalData.value.tin,
    };

    if (_isGeneratingPdf || _wasyyahPdfPath != null) return;

    setState(() {
      _isGeneratingPdf = true;
      _pdfError = null;
      _pdfIsReady = false;
      _pdfTotalPages = 0;
      _pdfCurrentPage = 0;
    });

    try {
      final file = await PdfService.generateWasyyahPdf(content, qrData);
      if (!mounted) return;
      setState(() {
        _wasyyahPdfPath = file.path;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pdfError = e.toString();
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isGeneratingPdf = false;
      });
    }
  }

  Widget _buildWasiyyahPdfPreview(List<WasyyahContentModel> content) {
    if (_wasyyahPdfPath == null && !_isGeneratingPdf) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _ensureWasyyahPdf(content);
        }
      });
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.wasiyyah_preview,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 620.h,
              child: Column(
                children: [
                  if (_wasyyahPdfPath != null)
                    Expanded(
                      child: PDFView(
                        filePath: _wasyyahPdfPath!,
                        enableSwipe: true,
                        swipeHorizontal: true,
                        autoSpacing: false,
                        pageFling: true,
                        fitEachPage: true,
                        fitPolicy: FitPolicy.WIDTH,
                        onRender: (pages) {
                          setState(() {
                            _pdfTotalPages = pages ?? 0;
                            _pdfIsReady = true;
                          });
                        },
                        onError: (error) {
                          setState(() => _pdfError = error.toString());
                        },
                        onPageError: (page, error) {
                          setState(() {
                            _pdfError = "${AppLocalizations.of(context)!.page} $page: $error";
                          });
                        },
                        onPageChanged: (page, total) {
                          setState(() => _pdfCurrentPage = page ?? 0);
                        },
                      ),
                    ),
                  if ((_isGeneratingPdf || !_pdfIsReady) && _pdfError == null) Expanded(child: const Center(child: CircularProgressIndicator())),
                  if (_pdfError != null) Center(child: Text(_pdfError!)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 // if (_pdfIsReady)
            //   Padding(
            //     padding: EdgeInsets.only(top: 8.h),
            //     child: Text(
            //       "${AppLocalizations.of(context)!.page} ${(_pdfCurrentPage + 1).toLocal()} of ${_pdfTotalPages.toLocal()}",
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
