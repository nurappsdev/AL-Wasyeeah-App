import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// No description provided for @splash_screen.
  ///
  /// In en, this message translates to:
  /// **' // Splash Screen'**
  String get splash_screen;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @ayat.
  ///
  /// In en, this message translates to:
  /// **'O you who believe! When death approaches one of you, call two just witnesses from among you, and if you are on a journey and death approaches you, call two witnesses from among yourselves. If you are in doubt, then wait for them after the prayer. Then they will swear by Allah, \'We will not take any price for him, even if he is a relative, and we will not conceal the testimony of Allah, for then we will be among the sinners\'. Surah Al-Ma\'idah: 106'**
  String get ayat;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @register_now.
  ///
  /// In en, this message translates to:
  /// **' Register now'**
  String get register_now;

  /// No description provided for @please_enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Email'**
  String get please_enter_your_email;

  /// No description provided for @nominee_log_in.
  ///
  /// In en, this message translates to:
  /// **'Nominee Log In'**
  String get nominee_log_in;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

  /// No description provided for @please_enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Password'**
  String get please_enter_your_password;

  /// No description provided for @password_8_characters_min_letters_digits_required.
  ///
  /// In en, this message translates to:
  /// **'Password: 8 characters min, letters & digits \n required'**
  String get password_8_characters_min_letters_digits_required;

  /// No description provided for @don_t_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get don_t_have_an_account;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @please_enter_your_first_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your First Name'**
  String get please_enter_your_first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @please_enter_your_last_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Last Name'**
  String get please_enter_your_last_name;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @please_enter_your_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Mobile Number'**
  String get please_enter_your_mobile_number;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get date_of_birth;

  /// No description provided for @please_write_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Please Write Date of birth'**
  String get please_write_date_of_birth;

  /// No description provided for @enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enter_otp;

  /// No description provided for @an_5_digit_code_sent_to_your.
  ///
  /// In en, this message translates to:
  /// **'An 5 digit code sent to your'**
  String get an_5_digit_code_sent_to_your;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @didn_t_receive_code.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive code?'**
  String get didn_t_receive_code;

  /// No description provided for @resent_code.
  ///
  /// In en, this message translates to:
  /// **'Resent Code'**
  String get resent_code;

  /// No description provided for @verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verify_email;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @property_distribution.
  ///
  /// In en, this message translates to:
  /// **'Property Distribution'**
  String get property_distribution;

  /// No description provided for @list_of_relatives.
  ///
  /// In en, this message translates to:
  /// **'List of relatives'**
  String get list_of_relatives;

  /// No description provided for @husband.
  ///
  /// In en, this message translates to:
  /// **'Husband'**
  String get husband;

  /// No description provided for @wife.
  ///
  /// In en, this message translates to:
  /// **'Wife'**
  String get wife;

  /// No description provided for @son.
  ///
  /// In en, this message translates to:
  /// **'Son'**
  String get son;

  /// No description provided for @daughter.
  ///
  /// In en, this message translates to:
  /// **'Daughter'**
  String get daughter;

  /// No description provided for @dead_son.
  ///
  /// In en, this message translates to:
  /// **'Dead son'**
  String get dead_son;

  /// No description provided for @son_of_a_dead_son.
  ///
  /// In en, this message translates to:
  /// **'Son of a dead son'**
  String get son_of_a_dead_son;

  /// No description provided for @dead_daughter.
  ///
  /// In en, this message translates to:
  /// **'Dead daughter'**
  String get dead_daughter;

  /// No description provided for @daughter_of_a_deceased_son.
  ///
  /// In en, this message translates to:
  /// **'Daughter of a deceased son'**
  String get daughter_of_a_deceased_son;

  /// No description provided for @son_of_the_deceased_daughter.
  ///
  /// In en, this message translates to:
  /// **'Son of the deceased daughter'**
  String get son_of_the_deceased_daughter;

  /// No description provided for @the_daughter_of_the_deceased_daughter.
  ///
  /// In en, this message translates to:
  /// **'The daughter of the deceased daughter'**
  String get the_daughter_of_the_deceased_daughter;

  /// No description provided for @father.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// No description provided for @grandfather.
  ///
  /// In en, this message translates to:
  /// **'Grandfather'**
  String get grandfather;

  /// No description provided for @grandma.
  ///
  /// In en, this message translates to:
  /// **'Grandma'**
  String get grandma;

  /// No description provided for @granny.
  ///
  /// In en, this message translates to:
  /// **'Granny'**
  String get granny;

  /// No description provided for @brother.
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get brother;

  /// No description provided for @half_brother_bipartite.
  ///
  /// In en, this message translates to:
  /// **'Half-brother (bipartite)'**
  String get half_brother_bipartite;

  /// No description provided for @half_sister_bilateral.
  ///
  /// In en, this message translates to:
  /// **'Half-sister (bilateral)'**
  String get half_sister_bilateral;

  /// No description provided for @stepbrother_half_brother.
  ///
  /// In en, this message translates to:
  /// **'Stepbrother (half-brother)'**
  String get stepbrother_half_brother;

  /// No description provided for @half_sister_step_sister.
  ///
  /// In en, this message translates to:
  /// **'Half-sister (step-sister)'**
  String get half_sister_step_sister;

  /// No description provided for @brother_s_son.
  ///
  /// In en, this message translates to:
  /// **'Brother\'s son'**
  String get brother_s_son;

  /// No description provided for @son_of_half_brother_uncle.
  ///
  /// In en, this message translates to:
  /// **'Son of half-brother (uncle)'**
  String get son_of_half_brother_uncle;

  /// No description provided for @brother_s_son_s_son.
  ///
  /// In en, this message translates to:
  /// **'Brother\'s son\'s son'**
  String get brother_s_son_s_son;

  /// No description provided for @son_of_half_brother_s_son.
  ///
  /// In en, this message translates to:
  /// **'Son of half-brother\'s son'**
  String get son_of_half_brother_s_son;

  /// No description provided for @uncle.
  ///
  /// In en, this message translates to:
  /// **'Uncle'**
  String get uncle;

  /// No description provided for @uncle_bilingual.
  ///
  /// In en, this message translates to:
  /// **'Uncle (bilingual)'**
  String get uncle_bilingual;

  /// No description provided for @cousin.
  ///
  /// In en, this message translates to:
  /// **'Cousin'**
  String get cousin;

  /// No description provided for @cousin_bipartite.
  ///
  /// In en, this message translates to:
  /// **'Cousin (bipartite)'**
  String get cousin_bipartite;

  /// No description provided for @cousin_s_son.
  ///
  /// In en, this message translates to:
  /// **'Cousin\'s son'**
  String get cousin_s_son;

  /// No description provided for @cousin_s_son_baimatreya.
  ///
  /// In en, this message translates to:
  /// **'Cousin\'s son (Baimatreya).'**
  String get cousin_s_son_baimatreya;

  /// No description provided for @cousin_s_son_s_son_s_son.
  ///
  /// In en, this message translates to:
  /// **'Cousin\'s son\'s son\'s son'**
  String get cousin_s_son_s_son_s_son;

  /// No description provided for @cousin_s_vaimatreya_s_son_s_son.
  ///
  /// In en, this message translates to:
  /// **'Cousin\'s (Vaimatreya\'s) son\'s son'**
  String get cousin_s_vaimatreya_s_son_s_son;

  /// No description provided for @asset_description.
  ///
  /// In en, this message translates to:
  /// **'Asset Description'**
  String get asset_description;

  /// No description provided for @land_measurement_unit_percentage.
  ///
  /// In en, this message translates to:
  /// **'\'Land\' Measurement Unit Percentage'**
  String get land_measurement_unit_percentage;

  /// No description provided for @gold_measurement_unit_bhari.
  ///
  /// In en, this message translates to:
  /// **'\'Gold\' Measurement Unit Bhari'**
  String get gold_measurement_unit_bhari;

  /// No description provided for @silver_measurement_unit_bhari.
  ///
  /// In en, this message translates to:
  /// **'\'Silver\' Measurement Unit Bhari'**
  String get silver_measurement_unit_bhari;

  /// No description provided for @money_measurement_unit_taka.
  ///
  /// In en, this message translates to:
  /// **'\'Money\' Measurement Unit Taka'**
  String get money_measurement_unit_taka;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @property_distribution_result.
  ///
  /// In en, this message translates to:
  /// **'Property Distribution Result'**
  String get property_distribution_result;

  /// No description provided for @zakat_calculator.
  ///
  /// In en, this message translates to:
  /// **'Zakat Calculator'**
  String get zakat_calculator;

  /// No description provided for @value_of_gold.
  ///
  /// In en, this message translates to:
  /// **'Value of Gold (\\\$)'**
  String get value_of_gold;

  /// No description provided for @value_of_silver.
  ///
  /// In en, this message translates to:
  /// **'Value of Silver (\\\$)'**
  String get value_of_silver;

  /// No description provided for @cash_in_hand_and_in_bank_accounts.
  ///
  /// In en, this message translates to:
  /// **'Cash In hand and in bank accounts(\\\$)'**
  String get cash_in_hand_and_in_bank_accounts;

  /// No description provided for @deposited_for_some_future_purpose.
  ///
  /// In en, this message translates to:
  /// **'Deposited for some future purpose(\\\$)'**
  String get deposited_for_some_future_purpose;

  /// No description provided for @given_out_in_loans.
  ///
  /// In en, this message translates to:
  /// **'Given out in loans(\\\$)'**
  String get given_out_in_loans;

  /// No description provided for @total_assets.
  ///
  /// In en, this message translates to:
  /// **'Total Assets'**
  String get total_assets;

  /// No description provided for @payable_zakat.
  ///
  /// In en, this message translates to:
  /// **'PAYABLE ZAKAT'**
  String get payable_zakat;

  /// No description provided for @married.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get married;

  /// No description provided for @un_married.
  ///
  /// In en, this message translates to:
  /// **'Un Married'**
  String get un_married;

  /// No description provided for @marital_status.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get marital_status;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @engineers.
  ///
  /// In en, this message translates to:
  /// **'Engineers'**
  String get engineers;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @place_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Place of birth'**
  String get place_of_birth;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'FeMale'**
  String get female;

  /// No description provided for @district_state.
  ///
  /// In en, this message translates to:
  /// **'District/State'**
  String get district_state;

  /// No description provided for @nid_passport_no.
  ///
  /// In en, this message translates to:
  /// **'NID/Passport No'**
  String get nid_passport_no;

  /// No description provided for @take_your_photo.
  ///
  /// In en, this message translates to:
  /// **'Take Your Photo'**
  String get take_your_photo;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @tin_tax_identification_number.
  ///
  /// In en, this message translates to:
  /// **'TIN (Tax Identification Number)'**
  String get tin_tax_identification_number;

  /// No description provided for @present_address.
  ///
  /// In en, this message translates to:
  /// **'Present Address'**
  String get present_address;

  /// No description provided for @zip_code.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get zip_code;

  /// No description provided for @village_house.
  ///
  /// In en, this message translates to:
  /// **'Village/House'**
  String get village_house;

  /// No description provided for @permanent_address.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address'**
  String get permanent_address;

  /// No description provided for @overseas_address.
  ///
  /// In en, this message translates to:
  /// **'Overseas Address'**
  String get overseas_address;

  /// No description provided for @road_block_sector.
  ///
  /// In en, this message translates to:
  /// **'Road/Block/Sector'**
  String get road_block_sector;

  /// No description provided for @father_s_information.
  ///
  /// In en, this message translates to:
  /// **'Father’s Information'**
  String get father_s_information;

  /// No description provided for @father_s_name.
  ///
  /// In en, this message translates to:
  /// **'Father’s Name'**
  String get father_s_name;

  /// No description provided for @mother_s_information.
  ///
  /// In en, this message translates to:
  /// **'Mother’s Information'**
  String get mother_s_information;

  /// No description provided for @mother_s_name.
  ///
  /// In en, this message translates to:
  /// **'Mother’s Name'**
  String get mother_s_name;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @family_information.
  ///
  /// In en, this message translates to:
  /// **'Family Information'**
  String get family_information;

  /// No description provided for @spouse_name.
  ///
  /// In en, this message translates to:
  /// **'Spouse Name'**
  String get spouse_name;

  /// No description provided for @alive.
  ///
  /// In en, this message translates to:
  /// **'Alive'**
  String get alive;

  /// No description provided for @death.
  ///
  /// In en, this message translates to:
  /// **'Death'**
  String get death;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @bank_information.
  ///
  /// In en, this message translates to:
  /// **'Bank Information'**
  String get bank_information;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @islami_bank.
  ///
  /// In en, this message translates to:
  /// **'Islami Bank'**
  String get islami_bank;

  /// No description provided for @account_name.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get account_name;

  /// No description provided for @account_number.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get account_number;

  /// No description provided for @add_more_spouse.
  ///
  /// In en, this message translates to:
  /// **'+ Add more spouse'**
  String get add_more_spouse;

  /// No description provided for @add_more_bank.
  ///
  /// In en, this message translates to:
  /// **'+ Add more Bank'**
  String get add_more_bank;

  /// No description provided for @wealth.
  ///
  /// In en, this message translates to:
  /// **'Wealth'**
  String get wealth;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @documents_type.
  ///
  /// In en, this message translates to:
  /// **'Documents Type'**
  String get documents_type;

  /// No description provided for @explore_your_wasyyah.
  ///
  /// In en, this message translates to:
  /// **'Explore your \n Wasyyah'**
  String get explore_your_wasyyah;

  /// No description provided for @bismillahir_rahmanir_raheem.
  ///
  /// In en, this message translates to:
  /// **'Bismillahir Rahmanir Raheem'**
  String get bismillahir_rahmanir_raheem;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @witnesses.
  ///
  /// In en, this message translates to:
  /// **'Witnesses'**
  String get witnesses;

  /// No description provided for @your_nominee.
  ///
  /// In en, this message translates to:
  /// **'Your Nominee'**
  String get your_nominee;

  /// No description provided for @nominated_you.
  ///
  /// In en, this message translates to:
  /// **'Nominated You'**
  String get nominated_you;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @add_more_nominees.
  ///
  /// In en, this message translates to:
  /// **' + Add more nominees'**
  String get add_more_nominees;

  /// No description provided for @nominee_profile_details.
  ///
  /// In en, this message translates to:
  /// **'Nominee Profile Details'**
  String get nominee_profile_details;

  /// No description provided for @remove_nominee.
  ///
  /// In en, this message translates to:
  /// **' - Remove Nominee'**
  String get remove_nominee;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation:'**
  String get relation;

  /// No description provided for @nominee_date.
  ///
  /// In en, this message translates to:
  /// **'Nominee Date:'**
  String get nominee_date;

  /// No description provided for @mobile_1.
  ///
  /// In en, this message translates to:
  /// **'Mobile:'**
  String get mobile_1;

  /// No description provided for @email_1.
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String get email_1;

  /// No description provided for @marital_status_1.
  ///
  /// In en, this message translates to:
  /// **'Marital Status:'**
  String get marital_status_1;

  /// No description provided for @spouse_s.
  ///
  /// In en, this message translates to:
  /// **'Spouse’s:'**
  String get spouse_s;

  /// No description provided for @profession_1.
  ///
  /// In en, this message translates to:
  /// **'Profession:'**
  String get profession_1;

  /// No description provided for @mother_s_name_1.
  ///
  /// In en, this message translates to:
  /// **'Mother’s Name:'**
  String get mother_s_name_1;

  /// No description provided for @father_s_name_1.
  ///
  /// In en, this message translates to:
  /// **'Father’s Name:'**
  String get father_s_name_1;

  /// No description provided for @permanent_address_1.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address:'**
  String get permanent_address_1;

  /// No description provided for @add_witness.
  ///
  /// In en, this message translates to:
  /// **'Add Witness'**
  String get add_witness;

  /// No description provided for @your_witness.
  ///
  /// In en, this message translates to:
  /// **'Your Witness'**
  String get your_witness;

  /// No description provided for @i_m_the_witness.
  ///
  /// In en, this message translates to:
  /// **'I’m the witness'**
  String get i_m_the_witness;

  /// No description provided for @witness_profile_details.
  ///
  /// In en, this message translates to:
  /// **'Witness Profile Details'**
  String get witness_profile_details;

  /// No description provided for @add_more_witness.
  ///
  /// In en, this message translates to:
  /// **'+ Add more witness'**
  String get add_more_witness;

  /// No description provided for @remove_witness.
  ///
  /// In en, this message translates to:
  /// **' - Remove Witness'**
  String get remove_witness;

  /// No description provided for @add_outside_witness.
  ///
  /// In en, this message translates to:
  /// **'+ Add outside witness'**
  String get add_outside_witness;

  /// No description provided for @add_nominee.
  ///
  /// In en, this message translates to:
  /// **'Add Nominee'**
  String get add_nominee;

  /// No description provided for @add_outside_nominee.
  ///
  /// In en, this message translates to:
  /// **'+ Add outside Nominee'**
  String get add_outside_nominee;

  /// No description provided for @user_setting.
  ///
  /// In en, this message translates to:
  /// **'User Setting'**
  String get user_setting;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get user_name;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get already_have_an_account;

  /// No description provided for @zakat_calculation.
  ///
  /// In en, this message translates to:
  /// **'Zakat Calculation'**
  String get zakat_calculation;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'profile'**
  String get profile;

  /// No description provided for @add_more_content.
  ///
  /// In en, this message translates to:
  /// **'Add more content'**
  String get add_more_content;

  /// No description provided for @add_new_washiyah.
  ///
  /// In en, this message translates to:
  /// **'Add New Washiyah'**
  String get add_new_washiyah;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @helps.
  ///
  /// In en, this message translates to:
  /// **'Helps'**
  String get helps;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @add_your_washiya_content.
  ///
  /// In en, this message translates to:
  /// **'add your washiya content'**
  String get add_your_washiya_content;

  /// No description provided for @add_your_washiya_content_title.
  ///
  /// In en, this message translates to:
  /// **'add your washiya content title'**
  String get add_your_washiya_content_title;

  /// No description provided for @don_t_worry_it_happens_please_enter_the_address_associate_with_your_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t worry! it happens Please enter the address associate with your account.'**
  String
      get don_t_worry_it_happens_please_enter_the_address_associate_with_your_account;

  /// No description provided for @relation_with_nominee.
  ///
  /// In en, this message translates to:
  /// **'Relation with nominee'**
  String get relation_with_nominee;

  /// No description provided for @relation_with_witness.
  ///
  /// In en, this message translates to:
  /// **'Relation with Witness'**
  String get relation_with_witness;

  /// No description provided for @witness.
  ///
  /// In en, this message translates to:
  /// **'Witness'**
  String get witness;

  /// No description provided for @nominee.
  ///
  /// In en, this message translates to:
  /// **'Nominee'**
  String get nominee;

  /// No description provided for @prayer_time.
  ///
  /// In en, this message translates to:
  /// **'Prayer Time'**
  String get prayer_time;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @security_question.
  ///
  /// In en, this message translates to:
  /// **'Security Question'**
  String get security_question;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @get_start.
  ///
  /// In en, this message translates to:
  /// **'Get Start'**
  String get get_start;

  /// No description provided for @access_control_panel.
  ///
  /// In en, this message translates to:
  /// **'Access Control Panel'**
  String get access_control_panel;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @personal_details.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personal_details;

  /// No description provided for @user_profile.
  ///
  /// In en, this message translates to:
  /// **'User Setting'**
  String get user_profile;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @otp_verify.
  ///
  /// In en, this message translates to:
  /// **'Otp Verify'**
  String get otp_verify;

  /// No description provided for @profile_update_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile Update Successfully'**
  String get profile_update_successfully;

  /// No description provided for @profile_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Profile Update Failed'**
  String get profile_update_failed;

  /// No description provided for @please_enter_your_answer.
  ///
  /// In en, this message translates to:
  /// **'Please enter your answer'**
  String get please_enter_your_answer;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @select_witness.
  ///
  /// In en, this message translates to:
  /// **'Select Witness'**
  String get select_witness;

  /// No description provided for @select_nominee.
  ///
  /// In en, this message translates to:
  /// **'Select Nominee'**
  String get select_nominee;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalid_email;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @wasyyah.
  ///
  /// In en, this message translates to:
  /// **'Wasyyah'**
  String get wasyyah;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @wasiyah_will.
  ///
  /// In en, this message translates to:
  /// **'Wasyiah (Will)'**
  String get wasiyah_will;

  /// No description provided for @islamic_greeting.
  ///
  /// In en, this message translates to:
  /// **'As-salamu alaykum wa rahmatullah. Indeed, all praise is for Allah, the Lord of the worlds. Peace and blessings be upon the Messenger of Allah (PBUH).'**
  String get islamic_greeting;

  /// No description provided for @n_a.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get n_a;

  /// No description provided for @wasyyah_preview.
  ///
  /// In en, this message translates to:
  /// **'Wasyyah Preview'**
  String get wasyyah_preview;

  /// No description provided for @own_identity.
  ///
  /// In en, this message translates to:
  /// **'Own Identity'**
  String get own_identity;

  /// No description provided for @no_content_available.
  ///
  /// In en, this message translates to:
  /// **'No content available.'**
  String get no_content_available;

  /// No description provided for @wasyyah_edit.
  ///
  /// In en, this message translates to:
  /// **'Wasyyah Edit'**
  String get wasyyah_edit;

  /// No description provided for @please_enter_your_user_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your user name'**
  String get please_enter_your_user_name;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @please_enter_your_old_and_new_passwords_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Please enter your old and new passwords to continue'**
  String get please_enter_your_old_and_new_passwords_to_continue;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @re_enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password again'**
  String get re_enter_new_password;

  /// No description provided for @select_your_question.
  ///
  /// In en, this message translates to:
  /// **'Select your question'**
  String get select_your_question;

  /// No description provided for @prayer_times.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayer_times;

  /// No description provided for @upcoming_prayers.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Prayers'**
  String get upcoming_prayers;

  /// No description provided for @looks_like_youre_lost.
  ///
  /// In en, this message translates to:
  /// **'Looks Like You\'re Lost'**
  String get looks_like_youre_lost;

  /// No description provided for @no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get no_internet_connection;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @i_agree_with.
  ///
  /// In en, this message translates to:
  /// **'I agree with'**
  String get i_agree_with;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_and_conditions;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'&'**
  String get and;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @choose_file.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get choose_file;

  /// No description provided for @no_file_chosen.
  ///
  /// In en, this message translates to:
  /// **'No file chosen'**
  String get no_file_chosen;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
