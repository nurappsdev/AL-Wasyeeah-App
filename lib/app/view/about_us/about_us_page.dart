import 'package:flutter/material.dart';
import 'package:al_wasyeah/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:al_wasyeah/core/utils/app_image.dart';
import 'package:al_wasyeah/core/widgets/custom_text.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about_us),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Mission Section
            _missionSection(context),

            const SizedBox(height: 30),

            CustomText(
              text: l10n.team_title,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 8),

            CustomText(
              text: l10n.team_description,
              color: Colors.grey,
            ),

            const SizedBox(height: 20),

            _teamGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _missionSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: l10n.mission_title,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            AppImages.aboutUsOurVisionImage,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        CustomText(
          text: l10n.mission_description,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _teamGrid(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final team = [
      TeamModel(
        name: l10n.member_1_name,
        designation: l10n.member_1_designation,
        description: l10n.member_1_description,
        image: AppImages.aboutUsOurVisionImage,
      ),
      TeamModel(
        name: l10n.member_2_name,
        designation: l10n.member_2_designation,
        description: l10n.member_2_description,
        image: AppImages.marketingManagerImage,
      ),
      TeamModel(
        name: l10n.member_3_name,
        designation: l10n.member_3_designation,
        description: l10n.member_3_description,
        image: AppImages.appDeveloper1Image,
      ),
      TeamModel(
        name: l10n.member_4_name,
        designation: l10n.member_4_designation,
        description: l10n.member_4_description,
        image: AppImages.appDeveloper2Image,
      ),
      TeamModel(
        name: l10n.member_5_name,
        designation: l10n.member_5_designation,
        description: l10n.member_5_description,
        image: AppImages.webDeveloperImage,
      ),
      TeamModel(
        name: l10n.member_6_name,
        designation: l10n.member_6_designation,
        description: l10n.member_6_description,
        image: AppImages.ui_ux_designerImage,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: team.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: .75,
      ),
      itemBuilder: (context, index) {
        final item = team[index];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(item.image),
              ),
              const SizedBox(height: 10),
              CustomText(
                text: item.name,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: item.designation,
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              CustomText(
                text: item.description,
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TeamModel {
  final String name;
  final String designation;
  final String description;
  final String image;

  TeamModel({
    required this.name,
    required this.designation,
    required this.description,
    required this.image,
  });
}
