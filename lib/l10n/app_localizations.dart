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
  /// **'Deceased son'**
  String get dead_son;

  /// No description provided for @son_of_a_dead_son.
  ///
  /// In en, this message translates to:
  /// **'Son of a deceased son'**
  String get son_of_a_dead_son;

  /// No description provided for @dead_daughter.
  ///
  /// In en, this message translates to:
  /// **'Deceased daughter'**
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
  /// **'Value of Gold'**
  String get value_of_gold;

  /// No description provided for @value_of_silver.
  ///
  /// In en, this message translates to:
  /// **'Value of Silver'**
  String get value_of_silver;

  /// No description provided for @cash_in_hand_and_in_bank_accounts.
  ///
  /// In en, this message translates to:
  /// **'Cash In hand and in bank accounts'**
  String get cash_in_hand_and_in_bank_accounts;

  /// No description provided for @deposited_for_some_future_purpose.
  ///
  /// In en, this message translates to:
  /// **'Deposited for some future purpose'**
  String get deposited_for_some_future_purpose;

  /// No description provided for @given_out_in_loans.
  ///
  /// In en, this message translates to:
  /// **'Given out in loans'**
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

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @access_control.
  ///
  /// In en, this message translates to:
  /// **'Access Control'**
  String get access_control;

  /// No description provided for @outside_nominee.
  ///
  /// In en, this message translates to:
  /// **'Outside Nominee'**
  String get outside_nominee;

  /// No description provided for @outside_witness.
  ///
  /// In en, this message translates to:
  /// **'Outside Witness'**
  String get outside_witness;

  /// No description provided for @wasyyah_ichanama_title.
  ///
  /// In en, this message translates to:
  /// **'Wasyyah (Ichanama)'**
  String get wasyyah_ichanama_title;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profile_settings;

  /// No description provided for @wealth_information.
  ///
  /// In en, this message translates to:
  /// **'Wealth Information'**
  String get wealth_information;

  /// No description provided for @account_receivable_information.
  ///
  /// In en, this message translates to:
  /// **'Account Receivable Information'**
  String get account_receivable_information;

  /// No description provided for @account_payable_information.
  ///
  /// In en, this message translates to:
  /// **'Account Payable Information'**
  String get account_payable_information;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @add_bank.
  ///
  /// In en, this message translates to:
  /// **'Add Bank'**
  String get add_bank;

  /// No description provided for @select_bank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get select_bank;

  /// No description provided for @branch.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get branch;

  /// No description provided for @select_branch.
  ///
  /// In en, this message translates to:
  /// **'Select Branch'**
  String get select_branch;

  /// No description provided for @please_enter_account_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter account name'**
  String get please_enter_account_name;

  /// No description provided for @account_balance.
  ///
  /// In en, this message translates to:
  /// **'Account Balance'**
  String get account_balance;

  /// No description provided for @please_enter_account_balance.
  ///
  /// In en, this message translates to:
  /// **'Please enter account balance'**
  String get please_enter_account_balance;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @add_wealth.
  ///
  /// In en, this message translates to:
  /// **'Add Wealth'**
  String get add_wealth;

  /// No description provided for @select_wealth.
  ///
  /// In en, this message translates to:
  /// **'Select Wealth'**
  String get select_wealth;

  /// No description provided for @document_type.
  ///
  /// In en, this message translates to:
  /// **'Document Type'**
  String get document_type;

  /// No description provided for @select_document_type.
  ///
  /// In en, this message translates to:
  /// **'Select Document Type'**
  String get select_document_type;

  /// No description provided for @land_area_shotangsho.
  ///
  /// In en, this message translates to:
  /// **'Land Area (in Shotangsho)'**
  String get land_area_shotangsho;

  /// No description provided for @land_area.
  ///
  /// In en, this message translates to:
  /// **'Land Area'**
  String get land_area;

  /// No description provided for @please_enter_land_area.
  ///
  /// In en, this message translates to:
  /// **'Please enter land area'**
  String get please_enter_land_area;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @please_enter_location.
  ///
  /// In en, this message translates to:
  /// **'Please enter location'**
  String get please_enter_location;

  /// No description provided for @wealth_documents.
  ///
  /// In en, this message translates to:
  /// **'Wealth Documents'**
  String get wealth_documents;

  /// No description provided for @add_more_wealth.
  ///
  /// In en, this message translates to:
  /// **'Add More Wealth'**
  String get add_more_wealth;

  /// No description provided for @add_receivable.
  ///
  /// In en, this message translates to:
  /// **'Add Receivable'**
  String get add_receivable;

  /// No description provided for @receivable_amount.
  ///
  /// In en, this message translates to:
  /// **'Receivable Amount'**
  String get receivable_amount;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @please_enter_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get please_enter_amount;

  /// No description provided for @receivable_person.
  ///
  /// In en, this message translates to:
  /// **'Receivable Person'**
  String get receivable_person;

  /// No description provided for @person_name.
  ///
  /// In en, this message translates to:
  /// **'Person Name'**
  String get person_name;

  /// No description provided for @please_enter_person_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter person name'**
  String get please_enter_person_name;

  /// No description provided for @receivable_person_mobile.
  ///
  /// In en, this message translates to:
  /// **'Receivable Person Mobile'**
  String get receivable_person_mobile;

  /// No description provided for @please_enter_mobile.
  ///
  /// In en, this message translates to:
  /// **'Please enter mobile'**
  String get please_enter_mobile;

  /// No description provided for @add_more_receivable.
  ///
  /// In en, this message translates to:
  /// **'Add More Receivable'**
  String get add_more_receivable;

  /// No description provided for @add_payable.
  ///
  /// In en, this message translates to:
  /// **'Add Payable'**
  String get add_payable;

  /// No description provided for @payable_amount.
  ///
  /// In en, this message translates to:
  /// **'Payable Amount'**
  String get payable_amount;

  /// No description provided for @payable_person.
  ///
  /// In en, this message translates to:
  /// **'Payable Person'**
  String get payable_person;

  /// No description provided for @payable_person_mobile.
  ///
  /// In en, this message translates to:
  /// **'Payable Person Mobile'**
  String get payable_person_mobile;

  /// No description provided for @add_more_payable.
  ///
  /// In en, this message translates to:
  /// **'Add More Payable'**
  String get add_more_payable;

  /// No description provided for @children_information.
  ///
  /// In en, this message translates to:
  /// **'Children Information'**
  String get children_information;

  /// No description provided for @sibling_information.
  ///
  /// In en, this message translates to:
  /// **'Sibling Information'**
  String get sibling_information;

  /// No description provided for @add_sibling.
  ///
  /// In en, this message translates to:
  /// **'Add Sibling'**
  String get add_sibling;

  /// No description provided for @sibling_name.
  ///
  /// In en, this message translates to:
  /// **'Sibling Name'**
  String get sibling_name;

  /// No description provided for @please_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get please_enter_name;

  /// No description provided for @sibling_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Sibling Date of Birth'**
  String get sibling_date_of_birth;

  /// No description provided for @select_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Select Date of Birth'**
  String get select_date_of_birth;

  /// No description provided for @please_enter_nid_passport_no.
  ///
  /// In en, this message translates to:
  /// **'Please enter NID/Passport No'**
  String get please_enter_nid_passport_no;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get please_enter_email;

  /// No description provided for @sibling_existence_status.
  ///
  /// In en, this message translates to:
  /// **'Sibling Existence Status'**
  String get sibling_existence_status;

  /// No description provided for @add_more_sibling.
  ///
  /// In en, this message translates to:
  /// **'Add More Sibling'**
  String get add_more_sibling;

  /// No description provided for @add_child.
  ///
  /// In en, this message translates to:
  /// **'Add Child'**
  String get add_child;

  /// No description provided for @child_name.
  ///
  /// In en, this message translates to:
  /// **'Child Name'**
  String get child_name;

  /// No description provided for @child_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Child Date of Birth'**
  String get child_date_of_birth;

  /// No description provided for @child_existence_status.
  ///
  /// In en, this message translates to:
  /// **'Child Existence Status'**
  String get child_existence_status;

  /// No description provided for @add_more_child.
  ///
  /// In en, this message translates to:
  /// **'Add More Child'**
  String get add_more_child;

  /// No description provided for @add_spouse.
  ///
  /// In en, this message translates to:
  /// **'Add Spouse'**
  String get add_spouse;

  /// No description provided for @spouse_profession.
  ///
  /// In en, this message translates to:
  /// **'Spouse Profession'**
  String get spouse_profession;

  /// No description provided for @spouse_nationality.
  ///
  /// In en, this message translates to:
  /// **'Spouse Nationality'**
  String get spouse_nationality;

  /// No description provided for @spouse_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Spouse Date of Birth'**
  String get spouse_date_of_birth;

  /// No description provided for @spouse_nid_passport_no.
  ///
  /// In en, this message translates to:
  /// **'Spouse NID/Passport No'**
  String get spouse_nid_passport_no;

  /// No description provided for @spouse_nid_passport_documents.
  ///
  /// In en, this message translates to:
  /// **'Spouse NID/Passport Documents'**
  String get spouse_nid_passport_documents;

  /// No description provided for @spouse_mobile_no.
  ///
  /// In en, this message translates to:
  /// **'Spouse Mobile No'**
  String get spouse_mobile_no;

  /// No description provided for @spouse_email.
  ///
  /// In en, this message translates to:
  /// **'Spouse Email'**
  String get spouse_email;

  /// No description provided for @personal_information.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personal_information;

  /// No description provided for @first_name_is_required.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get first_name_is_required;

  /// No description provided for @last_name_is_required.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get last_name_is_required;

  /// No description provided for @select_marital_status.
  ///
  /// In en, this message translates to:
  /// **'Select Marital Status'**
  String get select_marital_status;

  /// No description provided for @marital_status_is_required.
  ///
  /// In en, this message translates to:
  /// **'Marital status is required'**
  String get marital_status_is_required;

  /// No description provided for @select_profession.
  ///
  /// In en, this message translates to:
  /// **'Select Profession'**
  String get select_profession;

  /// No description provided for @select_country.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get select_country;

  /// No description provided for @district_state_is_required.
  ///
  /// In en, this message translates to:
  /// **'District/State is required'**
  String get district_state_is_required;

  /// No description provided for @select_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get select_gender;

  /// No description provided for @nid_passport_no_is_required.
  ///
  /// In en, this message translates to:
  /// **'NID/Passport No is required'**
  String get nid_passport_no_is_required;

  /// No description provided for @nid_passport_documents.
  ///
  /// In en, this message translates to:
  /// **'NID/Passport Documents'**
  String get nid_passport_documents;

  /// No description provided for @nid_file_downloaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'NID File downloaded successfully'**
  String get nid_file_downloaded_successfully;

  /// No description provided for @only_pdf_jpeg_png_allowed.
  ///
  /// In en, this message translates to:
  /// **'* Only Pdf,JPEG,PNG file are allowed'**
  String get only_pdf_jpeg_png_allowed;

  /// No description provided for @tin.
  ///
  /// In en, this message translates to:
  /// **'TIN'**
  String get tin;

  /// No description provided for @tin_is_required.
  ///
  /// In en, this message translates to:
  /// **'TIN is required'**
  String get tin_is_required;

  /// No description provided for @tin_documents.
  ///
  /// In en, this message translates to:
  /// **'TIN Documents'**
  String get tin_documents;

  /// No description provided for @tin_file_downloaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'TIN File downloaded successfully'**
  String get tin_file_downloaded_successfully;

  /// No description provided for @multi_citizenship.
  ///
  /// In en, this message translates to:
  /// **'Multi Citizenship'**
  String get multi_citizenship;

  /// No description provided for @profile_picture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profile_picture;

  /// No description provided for @profile_picture_downloaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile picture downloaded successfully'**
  String get profile_picture_downloaded_successfully;

  /// No description provided for @existence_status.
  ///
  /// In en, this message translates to:
  /// **'Existence Status'**
  String get existence_status;

  /// No description provided for @file_downloaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'File downloaded successfully'**
  String get file_downloaded_successfully;

  /// No description provided for @mark_present_as_permanent.
  ///
  /// In en, this message translates to:
  /// **'Mark Present Address as Permanent Address'**
  String get mark_present_as_permanent;

  /// No description provided for @relative_list.
  ///
  /// In en, this message translates to:
  /// **'Relative List'**
  String get relative_list;

  /// No description provided for @calculation_results.
  ///
  /// In en, this message translates to:
  /// **'Calculation Results'**
  String get calculation_results;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @share_portion.
  ///
  /// In en, this message translates to:
  /// **'Share Portion'**
  String get share_portion;

  /// No description provided for @land_portion.
  ///
  /// In en, this message translates to:
  /// **'Land Portion'**
  String get land_portion;

  /// No description provided for @gold_portion.
  ///
  /// In en, this message translates to:
  /// **'Gold Portion'**
  String get gold_portion;

  /// No description provided for @silver_portion.
  ///
  /// In en, this message translates to:
  /// **'Silver Portion'**
  String get silver_portion;

  /// No description provided for @total_money.
  ///
  /// In en, this message translates to:
  /// **'Total Money'**
  String get total_money;

  /// No description provided for @property_calculation_section.
  ///
  /// In en, this message translates to:
  /// **'Property Calculation Section'**
  String get property_calculation_section;

  /// No description provided for @land_in_decimal.
  ///
  /// In en, this message translates to:
  /// **'Land in Deciman'**
  String get land_in_decimal;

  /// No description provided for @enter_land_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter land amount'**
  String get enter_land_amount;

  /// No description provided for @gold_amount.
  ///
  /// In en, this message translates to:
  /// **'Gold amount'**
  String get gold_amount;

  /// No description provided for @enter_gold_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter gold amount'**
  String get enter_gold_amount;

  /// No description provided for @silver_amount.
  ///
  /// In en, this message translates to:
  /// **'Silver amount'**
  String get silver_amount;

  /// No description provided for @enter_silver_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter silver amount'**
  String get enter_silver_amount;

  /// No description provided for @total_money_in_taka.
  ///
  /// In en, this message translates to:
  /// **'Total Money in Taka'**
  String get total_money_in_taka;

  /// No description provided for @enter_money_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter money amount'**
  String get enter_money_amount;

  /// No description provided for @deceased_son.
  ///
  /// In en, this message translates to:
  /// **'Deceased Son'**
  String get deceased_son;

  /// No description provided for @deceased_daughter.
  ///
  /// In en, this message translates to:
  /// **'Deceased Daughter'**
  String get deceased_daughter;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get no_data;

  /// No description provided for @give_access.
  ///
  /// In en, this message translates to:
  /// **'Give Access'**
  String get give_access;

  /// No description provided for @access_feature.
  ///
  /// In en, this message translates to:
  /// **'Access Feature'**
  String get access_feature;

  /// No description provided for @application_menu.
  ///
  /// In en, this message translates to:
  /// **'Application Menu'**
  String get application_menu;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @bengali.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get bengali;

  /// No description provided for @no_nominee_added.
  ///
  /// In en, this message translates to:
  /// **'No Nominee Added Here'**
  String get no_nominee_added;

  /// No description provided for @no_witness_added.
  ///
  /// In en, this message translates to:
  /// **'No Witness Added Here'**
  String get no_witness_added;

  /// No description provided for @remove_nominee_btn.
  ///
  /// In en, this message translates to:
  /// **'Remove Nominee'**
  String get remove_nominee_btn;

  /// No description provided for @remove_witness_btn.
  ///
  /// In en, this message translates to:
  /// **'Remove Witness'**
  String get remove_witness_btn;

  /// No description provided for @gram_vori.
  ///
  /// In en, this message translates to:
  /// **'GRAM/VORI'**
  String get gram_vori;

  /// No description provided for @taka.
  ///
  /// In en, this message translates to:
  /// **'Taka'**
  String get taka;

  /// No description provided for @z_k_i.
  ///
  /// In en, this message translates to:
  /// **'Last Zakat Info'**
  String get z_k_i;

  /// No description provided for @access_panel.
  ///
  /// In en, this message translates to:
  /// **'Access Panel'**
  String get access_panel;

  /// No description provided for @assign_witness.
  ///
  /// In en, this message translates to:
  /// **'Assign Witness'**
  String get assign_witness;

  /// No description provided for @assign_nominee.
  ///
  /// In en, this message translates to:
  /// **'Assign Nominee'**
  String get assign_nominee;

  /// No description provided for @account_create_success.
  ///
  /// In en, this message translates to:
  /// **'Account create successful.\n \nNow you have a user name and password your email'**
  String get account_create_success;

  /// No description provided for @server_error.
  ///
  /// In en, this message translates to:
  /// **'Server error! \n Please try later'**
  String get server_error;

  /// No description provided for @invalid_username_or_password.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get invalid_username_or_password;

  /// No description provided for @verification_otp_send_success.
  ///
  /// In en, this message translates to:
  /// **'VERIFICATION OTP SEND SUCCESSFULLY!!'**
  String get verification_otp_send_success;

  /// No description provided for @unable_data.
  ///
  /// In en, this message translates to:
  /// **'Unable Data'**
  String get unable_data;

  /// No description provided for @record_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'RECORD UPDATED SUCCESSFULLY!!'**
  String get record_updated_successfully;

  /// No description provided for @mandatory_fields_cannot_be_null_or_empty.
  ///
  /// In en, this message translates to:
  /// **'Mandatory fields cannot be null or empty!'**
  String get mandatory_fields_cannot_be_null_or_empty;

  /// No description provided for @an_error_occurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get an_error_occurred;

  /// No description provided for @invalid_email_message.
  ///
  /// In en, this message translates to:
  /// **'This is not right email'**
  String get invalid_email_message;

  /// No description provided for @nominee_add_successfully.
  ///
  /// In en, this message translates to:
  /// **'Nominee Add Successfully'**
  String get nominee_add_successfully;

  /// No description provided for @added_failed.
  ///
  /// In en, this message translates to:
  /// **'Added failed. Please try again.'**
  String get added_failed;

  /// No description provided for @nominee_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Nominee Added Successfully'**
  String get nominee_added_successfully;

  /// No description provided for @witness_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Witness Added Successfully'**
  String get witness_added_successfully;

  /// No description provided for @add_failed_try_again.
  ///
  /// In en, this message translates to:
  /// **'Add failed. Please try again.'**
  String get add_failed_try_again;

  /// No description provided for @nominee_delete_successfully.
  ///
  /// In en, this message translates to:
  /// **'Nominee Delete Successfully'**
  String get nominee_delete_successfully;

  /// No description provided for @failed_to_load_contexts_data.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contexts data'**
  String get failed_to_load_contexts_data;

  /// No description provided for @profile_update_failed_with_status.
  ///
  /// In en, this message translates to:
  /// **'Profile Update Failed'**
  String get profile_update_failed_with_status;

  /// No description provided for @husband_and_wife_cant_be_selected_together.
  ///
  /// In en, this message translates to:
  /// **'You cannot select both Husband and Wife at the same time.'**
  String get husband_and_wife_cant_be_selected_together;

  /// No description provided for @calculation_fetched_successfully.
  ///
  /// In en, this message translates to:
  /// **'Calculation fetched successfully'**
  String get calculation_fetched_successfully;

  /// No description provided for @failed_to_fetch_calculation_result.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch calculation result'**
  String get failed_to_fetch_calculation_result;

  /// No description provided for @record_inserted_successfully.
  ///
  /// In en, this message translates to:
  /// **'RECORD INSERTED SUCCESSFULLY!!'**
  String get record_inserted_successfully;

  /// No description provided for @error_try_again.
  ///
  /// In en, this message translates to:
  /// **'error, try again'**
  String get error_try_again;

  /// No description provided for @network_error_occurred.
  ///
  /// In en, this message translates to:
  /// **'Network error occurred'**
  String get network_error_occurred;

  /// No description provided for @order_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order updated successfully!'**
  String get order_updated_successfully;

  /// No description provided for @failed_to_update_order_with_status.
  ///
  /// In en, this message translates to:
  /// **'Failed to update order'**
  String get failed_to_update_order_with_status;

  /// No description provided for @order_updated.
  ///
  /// In en, this message translates to:
  /// **'Order updated!'**
  String get order_updated;

  /// No description provided for @failed_to_update_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to update order'**
  String get failed_to_update_order;

  /// No description provided for @network_error.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get network_error;

  /// No description provided for @failed_to_update_visibility.
  ///
  /// In en, this message translates to:
  /// **'Failed to update visibility.'**
  String get failed_to_update_visibility;

  /// No description provided for @witness_remove_successfully.
  ///
  /// In en, this message translates to:
  /// **'REMOVE THIS WITNESS FROM YOUR SIDE SUCCESSFULLY!!'**
  String get witness_remove_successfully;

  /// No description provided for @internal_server_error.
  ///
  /// In en, this message translates to:
  /// **'500 Internal Server Error'**
  String get internal_server_error;

  /// No description provided for @request_failed_with_status.
  ///
  /// In en, this message translates to:
  /// **'Request Failed'**
  String get request_failed_with_status;

  /// No description provided for @cant_connect_to_the_internet.
  ///
  /// In en, this message translates to:
  /// **'Can\'t connect to the internet!'**
  String get cant_connect_to_the_internet;

  /// No description provided for @request_timeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout'**
  String get request_timeout;

  /// No description provided for @gram.
  ///
  /// In en, this message translates to:
  /// **'Gram'**
  String get gram;

  /// No description provided for @vori.
  ///
  /// In en, this message translates to:
  /// **'Vori'**
  String get vori;

  /// No description provided for @ordinal_st.
  ///
  /// In en, this message translates to:
  /// **'st'**
  String get ordinal_st;

  /// No description provided for @ordinal_nd.
  ///
  /// In en, this message translates to:
  /// **'nd'**
  String get ordinal_nd;

  /// No description provided for @ordinal_rd.
  ///
  /// In en, this message translates to:
  /// **'rd'**
  String get ordinal_rd;

  /// No description provided for @ordinal_th.
  ///
  /// In en, this message translates to:
  /// **'th'**
  String get ordinal_th;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @property_distribution_calculation.
  ///
  /// In en, this message translates to:
  /// **'Property Distribution Calculation'**
  String get property_distribution_calculation;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @decimal.
  ///
  /// In en, this message translates to:
  /// **'Decimal'**
  String get decimal;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @at_least_enter_nisab.
  ///
  /// In en, this message translates to:
  /// **'At least enter your nisab amount'**
  String get at_least_enter_nisab;

  /// No description provided for @land_area_in_shotangsho.
  ///
  /// In en, this message translates to:
  /// **'Land Area (in Shotangsho)'**
  String get land_area_in_shotangsho;

  /// No description provided for @wealth_document_file_downloaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'Wealth Document File downloaded successfully'**
  String get wealth_document_file_downloaded_successfully;

  /// No description provided for @sibling.
  ///
  /// In en, this message translates to:
  /// **'Sibling'**
  String get sibling;

  /// No description provided for @please_enter_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter mobile number'**
  String get please_enter_mobile_number;

  /// No description provided for @dead.
  ///
  /// In en, this message translates to:
  /// **'Dead'**
  String get dead;

  /// No description provided for @child.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get child;

  /// No description provided for @spouse.
  ///
  /// In en, this message translates to:
  /// **'Spouse'**
  String get spouse;

  /// No description provided for @only_pdf_jpeg_png_file_are_allowed.
  ///
  /// In en, this message translates to:
  /// **'* Only PDF, JPEG, PNG file are allowed'**
  String get only_pdf_jpeg_png_file_are_allowed;

  /// No description provided for @tin_tax_identification_number_is_required.
  ///
  /// In en, this message translates to:
  /// **'TIN (Tax Identification Number) is required'**
  String get tin_tax_identification_number_is_required;

  /// No description provided for @father_information.
  ///
  /// In en, this message translates to:
  /// **'Father\'s Information'**
  String get father_information;

  /// No description provided for @mother_information.
  ///
  /// In en, this message translates to:
  /// **'Mother\'s Information'**
  String get mother_information;

  /// No description provided for @is_required.
  ///
  /// In en, this message translates to:
  /// **'is required'**
  String get is_required;

  /// No description provided for @road_block_section.
  ///
  /// In en, this message translates to:
  /// **'Road/Block/Section'**
  String get road_block_section;

  /// No description provided for @mark_present_address_as_permanent_address.
  ///
  /// In en, this message translates to:
  /// **'Mark Present Address as Permanent Address'**
  String get mark_present_address_as_permanent_address;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @deceased.
  ///
  /// In en, this message translates to:
  /// **'Deceased'**
  String get deceased;

  /// No description provided for @s_suffix.
  ///
  /// In en, this message translates to:
  /// **'\'s'**
  String get s_suffix;

  /// No description provided for @property_distribution_calculation_saved_successfully.
  ///
  /// In en, this message translates to:
  /// **'Property Distribution Calculation Saved Successfully'**
  String get property_distribution_calculation_saved_successfully;

  /// No description provided for @property_distribution_calculation_failed_to_save.
  ///
  /// In en, this message translates to:
  /// **'Property Distribution Calculation Failed to Save'**
  String get property_distribution_calculation_failed_to_save;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @comming_soon.
  ///
  /// In en, this message translates to:
  /// **'Comming Soon'**
  String get comming_soon;

  /// No description provided for @calculate_your_zakat_easily.
  ///
  /// In en, this message translates to:
  /// **'Calculate Your Zakat Easily'**
  String get calculate_your_zakat_easily;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @nisab.
  ///
  /// In en, this message translates to:
  /// **'Nisab'**
  String get nisab;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updated;

  /// No description provided for @nisab_amount.
  ///
  /// In en, this message translates to:
  /// **'Nisab amount'**
  String get nisab_amount;

  /// No description provided for @future_deposits.
  ///
  /// In en, this message translates to:
  /// **'Future deposits'**
  String get future_deposits;

  /// No description provided for @investment_value.
  ///
  /// In en, this message translates to:
  /// **'Investment value'**
  String get investment_value;

  /// No description provided for @rental_income.
  ///
  /// In en, this message translates to:
  /// **'Rental income'**
  String get rental_income;

  /// No description provided for @immediate_liabilities.
  ///
  /// In en, this message translates to:
  /// **'Immediate liabilities'**
  String get immediate_liabilities;

  /// No description provided for @distribure_your_property_properly.
  ///
  /// In en, this message translates to:
  /// **'Distribute Your Property Properly'**
  String get distribure_your_property_properly;

  /// No description provided for @calculate_your_zakat.
  ///
  /// In en, this message translates to:
  /// **'Calculate Your Zakat'**
  String get calculate_your_zakat;

  /// No description provided for @distribute_your_property_properly.
  ///
  /// In en, this message translates to:
  /// **'Distribute Your Property Properly'**
  String get distribute_your_property_properly;

  /// No description provided for @current_time.
  ///
  /// In en, this message translates to:
  /// **'Current Time'**
  String get current_time;

  /// No description provided for @current_prayer.
  ///
  /// In en, this message translates to:
  /// **'Current Prayer'**
  String get current_prayer;

  /// No description provided for @previous_prayer.
  ///
  /// In en, this message translates to:
  /// **'Previous Prayer'**
  String get previous_prayer;

  /// No description provided for @upcoming_prayer.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Prayer'**
  String get upcoming_prayer;

  /// No description provided for @remaining_time.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time'**
  String get remaining_time;

  /// No description provided for @sunrise_time.
  ///
  /// In en, this message translates to:
  /// **'Sunrise Time'**
  String get sunrise_time;

  /// No description provided for @sunset_time.
  ///
  /// In en, this message translates to:
  /// **'Sunset Time'**
  String get sunset_time;
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
