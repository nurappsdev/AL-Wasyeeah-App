import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/utils/app_constant.dart';
import 'package:al_wasyeah/app/core/utils/app_icons.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final HomeController _profileSetupController;

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  String _newPasswordText = '';
  String _confirmPasswordText = '';

  @override
  void initState() {
    super.initState();
    _profileSetupController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    _newPassController.addListener(() {
      if (mounted) {
        setState(() {
          _newPasswordText = _newPassController.text;
        });
      }
    });

    _confirmPassController.addListener(() {
      if (mounted) {
        setState(() {
          _confirmPasswordText = _confirmPassController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  // --- Password Strength Helpers ---
  bool get _hasMinLength => _newPasswordText.length >= 8;
  bool get _hasLetter => RegExp(r'[a-zA-Z]').hasMatch(_newPasswordText);
  bool get _hasDigit => RegExp(r'[0-9]').hasMatch(_newPasswordText);

  int get _strengthScore {
    int score = 0;
    if (_hasMinLength) score++;
    if (_hasLetter) score++;
    if (_hasDigit) score++;
    return score;
  }

  String _getStrengthLabel(BuildContext context) {
    if (_newPasswordText.isEmpty) return '';
    switch (_strengthScore) {
      case 1:
        return 'Weak';
      case 2:
        return 'Moderate';
      case 3:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  Color _getStrengthColor() {
    switch (_strengthScore) {
      case 1:
        return const Color(0xffEF4444);
      case 2:
        return const Color(0xffF59E0B);
      case 3:
        return AppColors.primaryColor;
      default:
        return const Color(0xffE2E8F0);
    }
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _profileSetupController.changePass(
        _oldPassController.text.trim(),
        _newPassController.text.trim(),
        _confirmPassController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      // backgroundColor: const Color(0xffF8FAF9),
      appBar: CustomAppBar(
        title: localizations.change_password,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),

                  // Header Hero Icon and Texts
                  _buildHeroHeader(localizations),

                  SizedBox(height: 24.h),

                  // Main Form Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: const Color(0xffE8ECEF),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.03),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Current Password ---
                        _buildFieldLabel(
                          title: localizations.current_password,
                          icon: Icons.lock_clock_outlined,
                        ),
                        SizedBox(height: 8.h),
                        _buildPasswordField(
                          controller: _oldPassController,
                          hintText: localizations.password,
                          isObscure: _obscureCurrent,
                          onToggleObscure: () {
                            setState(() => _obscureCurrent = !_obscureCurrent);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return localizations.please_enter_your_password;
                            } else if (value.length < 8 ||
                                !AppConstants.validatePassword(value)) {
                              return localizations
                                  .password_8_characters_min_letters_digits_required;
                            }
                            return null;
                          },
                        ),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6.r),
                              onTap: () =>
                                  Get.toNamed(RouteName.forgotPasswordPage),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 4.h),
                                child: Text(
                                  localizations.forget_password,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),
                        const Divider(color: Color(0xffF1F5F9), thickness: 1),
                        SizedBox(height: 16.h),

                        // --- New Password ---
                        _buildFieldLabel(
                          title: localizations.new_password,
                          icon: Icons.lock_outline_rounded,
                        ),
                        SizedBox(height: 8.h),
                        _buildPasswordField(
                          controller: _newPassController,
                          hintText: localizations.new_password,
                          isObscure: _obscureNew,
                          onToggleObscure: () {
                            setState(() => _obscureNew = !_obscureNew);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return localizations.please_enter_your_password;
                            } else if (value.length < 8 ||
                                !AppConstants.validatePassword(value)) {
                              return localizations
                                  .password_8_characters_min_letters_digits_required;
                            } else if (_oldPassController.text.isNotEmpty &&
                                value == _oldPassController.text) {
                              return 'New password must be different from current password';
                            }
                            return null;
                          },
                        ),

                        // Password Strength Bar & Checklist
                        if (_newPasswordText.isNotEmpty) ...[
                          SizedBox(height: 12.h),
                          _buildStrengthIndicator(),
                          SizedBox(height: 12.h),
                          _buildRequirementsChecklist(),
                        ],

                        SizedBox(height: 20.h),

                        // --- Confirm New Password ---
                        _buildFieldLabel(
                          title: localizations.re_enter_new_password,
                          icon: Icons.verified_user_outlined,
                        ),
                        SizedBox(height: 8.h),
                        _buildPasswordField(
                          controller: _confirmPassController,
                          hintText: localizations.re_enter_new_password,
                          isObscure: _obscureConfirm,
                          onToggleObscure: () {
                            setState(() => _obscureConfirm = !_obscureConfirm);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return localizations.please_enter_your_password;
                            } else if (value != _newPassController.text) {
                              return localizations.passwords_do_not_match;
                            }
                            return null;
                          },
                        ),

                        // Confirm Password Live Match Badge
                        if (_confirmPasswordText.isNotEmpty) ...[
                          SizedBox(height: 10.h),
                          _buildMatchBadge(localizations),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Security Tip Card
                  _buildSecurityTipsCard(),

                  SizedBox(height: 28.h),

                  // Submit Button
                  Obx(
                    () => _buildSubmitButton(
                      localizations: localizations,
                      isLoading: _profileSetupController.forPassLoading.value,
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Hero Header Widget ---
  Widget _buildHeroHeader(AppLocalizations localizations) {
    return Column(
      children: [
        // Layered Icon Badge
        Container(
          width: 74.r,
          height: 74.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xffE9F5EF),
            border: Border.all(
              color: AppColors.secondaryPrimaryColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 52.r,
              height: 52.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor,
                    const Color(0xff035E2D),
                  ],
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.passIcon,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          localizations.change_password,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1C2A24),
            letterSpacing: -0.3,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            localizations.please_enter_your_old_and_new_passwords_to_continue,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xff60776C),
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // --- Field Label Widget ---
  Widget _buildFieldLabel({
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 6.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1F2937),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '*',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffEF4444),
          ),
        ),
      ],
    );
  }

  // --- Modern Styled Password Field ---
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isObscure,
    required VoidCallback onToggleObscure,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xff1E293B),
      ),
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xff94A3B8),
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: const Color(0xffFAFCFA),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              AppIcons.passIcon,
              height: 16.h,
              width: 16.w,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 42.w,
          minHeight: 42.h,
        ),
        suffixIcon: IconButton(
          splashRadius: 20.r,
          icon: Icon(
            isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: const Color(0xff94A3B8),
            size: 20.sp,
          ),
          onPressed: onToggleObscure,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: Color(0xffE2E8F0),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.6,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: Color(0xffEF4444),
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: Color(0xffEF4444),
            width: 1.6,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 11.5.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xffEF4444),
        ),
      ),
    );
  }

  // --- Password Strength Indicator ---
  Widget _buildStrengthIndicator() {
    final color = _getStrengthColor();
    final label = _getStrengthLabel(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Password Strength',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff64748B),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: List.generate(3, (index) {
              final isFilled = index < _strengthScore;
              return Expanded(
                child: Container(
                  height: 4.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    color: isFilled ? color : const Color(0xffE2E8F0),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // --- Password Requirements Checklist ---
  Widget _buildRequirementsChecklist() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAF9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCheckItem('At least 8 characters', _hasMinLength),
          SizedBox(height: 4.h),
          _buildCheckItem('Contains letters (a-z, A-Z)', _hasLetter),
          SizedBox(height: 4.h),
          _buildCheckItem('Contains numbers (0-9)', _hasDigit),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String label, bool isMet) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 16.r,
          height: 16.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isMet ? AppColors.primaryColor : const Color(0xffE2E8F0),
          ),
          child: Center(
            child: Icon(
              Icons.check_rounded,
              size: 11.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: isMet ? FontWeight.w600 : FontWeight.w400,
            color: isMet ? const Color(0xff1E293B) : const Color(0xff94A3B8),
          ),
        ),
      ],
    );
  }

  // --- Confirm Password Match Badge ---
  Widget _buildMatchBadge(AppLocalizations localizations) {
    final bool isMatch = _confirmPasswordText == _newPasswordText;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isMatch ? const Color(0xffE8F5EE) : const Color(0xffFEF2F2),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isMatch
              ? AppColors.secondaryPrimaryColor
              : const Color(0xffFECACA),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMatch ? Icons.check_circle_rounded : Icons.info_outline_rounded,
            size: 14.sp,
            color: isMatch ? AppColors.primaryColor : const Color(0xffEF4444),
          ),
          SizedBox(width: 6.w),
          Text(
            isMatch ? 'Passwords match' : localizations.passwords_do_not_match,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
              color: isMatch ? AppColors.primaryColor : const Color(0xffEF4444),
            ),
          ),
        ],
      ),
    );
  }

  // --- Security Tips Card ---
  Widget _buildSecurityTipsCard() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xffF0F7F3),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.secondaryPrimaryColor.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Icon(
              Icons.shield_outlined,
              color: AppColors.primaryColor,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password Security Tip',
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1C2A24),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Choose a unique password that you do not use for any other service to keep your account safe.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xff556B60),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Modern Submit Button ---
  Widget _buildSubmitButton({
    required AppLocalizations localizations,
    required bool isLoading,
  }) {
    return Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primaryColor,
            const Color(0xff036631),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: isLoading ? null : _onSubmit,
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 22.r,
                    width: 22.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        localizations.change_password,
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
