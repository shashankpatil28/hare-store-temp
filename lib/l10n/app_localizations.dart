import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_no.dart';
import 'app_localizations_sv.dart';

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
    Locale('da'),
    Locale('en'),
    Locale('es'),
    Locale('no'),
    Locale('sv'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Hare Store'**
  String get appName;

  /// No description provided for @liveOrders.
  ///
  /// In en, this message translates to:
  /// **'Live Orders'**
  String get liveOrders;

  /// No description provided for @permissionText1.
  ///
  /// In en, this message translates to:
  /// **'Allow {appName} to display over Other apps'**
  String permissionText1(Object appName);

  /// No description provided for @permissionText2.
  ///
  /// In en, this message translates to:
  /// **'Allow {appName} to display over Other apps in Order to receive orders when you\'re online.'**
  String permissionText2(Object appName);

  /// No description provided for @permissionText3.
  ///
  /// In en, this message translates to:
  /// **'Tap Allow and slide the toggle on the Settings screen on to on'**
  String get permissionText3;

  /// No description provided for @permissionText4.
  ///
  /// In en, this message translates to:
  /// **'Set the Quick access icon to on to see this icon over other apps'**
  String get permissionText4;

  /// No description provided for @quickAccessIcon.
  ///
  /// In en, this message translates to:
  /// **'Quick Access icon'**
  String get quickAccessIcon;

  /// No description provided for @settingsPermission.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get settingsPermission;

  /// No description provided for @newUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'New update available!'**
  String get newUpdateAvailable;

  /// No description provided for @newUpdateMsg.
  ///
  /// In en, this message translates to:
  /// **'Please update the new app from the store for further access app.'**
  String get newUpdateMsg;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @labelWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get labelWelcome;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @connection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection;

  /// No description provided for @connectionMsg.
  ///
  /// In en, this message translates to:
  /// **'Please check network connectivity'**
  String get connectionMsg;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @preferenceMsg.
  ///
  /// In en, this message translates to:
  /// **'You can change settings later from preference'**
  String get preferenceMsg;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get contactNumber;

  /// No description provided for @bookingID.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingID;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @enterPass.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPass;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ?'**
  String get dontHaveAccount;

  /// No description provided for @enterConfirmPass.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enterConfirmPass;

  /// No description provided for @enterContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get enterContactNumber;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @emptyData.
  ///
  /// In en, this message translates to:
  /// **'Sorry!!\nNo record found this time'**
  String get emptyData;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginHere.
  ///
  /// In en, this message translates to:
  /// **'Login here'**
  String get loginHere;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue'**
  String get loginToContinue;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutMsg;

  /// No description provided for @newPass.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPass;

  /// No description provided for @enterNewPass.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPass;

  /// No description provided for @enterOldPass.
  ///
  /// In en, this message translates to:
  /// **'Enter Old Password'**
  String get enterOldPass;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection Please Try Again'**
  String get noConnection;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get paymentType;

  /// No description provided for @paymentSettlement.
  ///
  /// In en, this message translates to:
  /// **'Payment Settlement'**
  String get paymentSettlement;

  /// No description provided for @settle.
  ///
  /// In en, this message translates to:
  /// **'Settle'**
  String get settle;

  /// No description provided for @unSettle.
  ///
  /// In en, this message translates to:
  /// **'Unsettle'**
  String get unSettle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpText.
  ///
  /// In en, this message translates to:
  /// **'By registering you agree with our'**
  String get signUpText;

  /// No description provided for @termAndConditionUse.
  ///
  /// In en, this message translates to:
  /// **'Term & condition'**
  String get termAndConditionUse;

  /// No description provided for @ofUse.
  ///
  /// In en, this message translates to:
  /// **'of use'**
  String get ofUse;

  /// No description provided for @productBy.
  ///
  /// In en, this message translates to:
  /// **'Product By'**
  String get productBy;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now!'**
  String get registerNow;

  /// No description provided for @registerWith.
  ///
  /// In en, this message translates to:
  /// **'Register with'**
  String get registerWith;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @navLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get navLogout;

  /// No description provided for @navSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get navSupport;

  /// No description provided for @navSetting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navSetting;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @navOffer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get navOffer;

  /// No description provided for @removeOffer.
  ///
  /// In en, this message translates to:
  /// **'Remove Offer'**
  String get removeOffer;

  /// No description provided for @removeOfferMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to remove offer?'**
  String get removeOfferMsg;

  /// No description provided for @navChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get navChangePassword;

  /// No description provided for @setNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set New Password'**
  String get setNewPassword;

  /// No description provided for @passChangeSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Your password changed successfully!'**
  String get passChangeSuccessMsg;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordMsg.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change your current password?'**
  String get changePasswordMsg;

  /// No description provided for @navMyProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get navMyProfile;

  /// No description provided for @storeOwner.
  ///
  /// In en, this message translates to:
  /// **'Store Owner'**
  String get storeOwner;

  /// No description provided for @selectStore.
  ///
  /// In en, this message translates to:
  /// **'Select Store'**
  String get selectStore;

  /// No description provided for @myProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get myProfileUpdated;

  /// No description provided for @navEarningPastOrder.
  ///
  /// In en, this message translates to:
  /// **'Earning & Past Order'**
  String get navEarningPastOrder;

  /// No description provided for @pastUpcomingList.
  ///
  /// In en, this message translates to:
  /// **'Past & Upcoming Order List'**
  String get pastUpcomingList;

  /// No description provided for @navOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get navOrderHistory;

  /// No description provided for @earning.
  ///
  /// In en, this message translates to:
  /// **'Earning'**
  String get earning;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filterOrder.
  ///
  /// In en, this message translates to:
  /// **'Filter Order'**
  String get filterOrder;

  /// No description provided for @navProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get navProducts;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preference'**
  String get preferences;

  /// No description provided for @chatWithAdmin.
  ///
  /// In en, this message translates to:
  /// **'Chat With Admin'**
  String get chatWithAdmin;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @updatePreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences Updated'**
  String get updatePreferences;

  /// No description provided for @dispatchOrder.
  ///
  /// In en, this message translates to:
  /// **'Dispatch'**
  String get dispatchOrder;

  /// No description provided for @splTagLine.
  ///
  /// In en, this message translates to:
  /// **'For Store Owner'**
  String get splTagLine;

  /// No description provided for @processingOrder.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processingOrder;

  /// No description provided for @acceptOrder.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptOrder;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @rejectOrder.
  ///
  /// In en, this message translates to:
  /// **'Reject order'**
  String get rejectOrder;

  /// No description provided for @rejectOrderMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you reject this order?'**
  String get rejectOrderMessage;

  /// No description provided for @enterRejectReason.
  ///
  /// In en, this message translates to:
  /// **'Enter reject reason'**
  String get enterRejectReason;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newOrder;

  /// No description provided for @newOrderDetail.
  ///
  /// In en, this message translates to:
  /// **'New Order'**
  String get newOrderDetail;

  /// No description provided for @orderDispatched.
  ///
  /// In en, this message translates to:
  /// **'Order In Route'**
  String get orderDispatched;

  /// No description provided for @orderInProcess.
  ///
  /// In en, this message translates to:
  /// **'Order In Process'**
  String get orderInProcess;

  /// No description provided for @startProcess.
  ///
  /// In en, this message translates to:
  /// **'Start Process'**
  String get startProcess;

  /// No description provided for @orderReady.
  ///
  /// In en, this message translates to:
  /// **'Ready This Order'**
  String get orderReady;

  /// No description provided for @orderPickedUp.
  ///
  /// In en, this message translates to:
  /// **'Order Picked Up'**
  String get orderPickedUp;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @orderDetail.
  ///
  /// In en, this message translates to:
  /// **'Order Detail'**
  String get orderDetail;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @deliveryPerson.
  ///
  /// In en, this message translates to:
  /// **'Delivery person'**
  String get deliveryPerson;

  /// No description provided for @itemTotal.
  ///
  /// In en, this message translates to:
  /// **'Item total'**
  String get itemTotal;

  /// No description provided for @deliveryCharges.
  ///
  /// In en, this message translates to:
  /// **'Delivery charges'**
  String get deliveryCharges;

  /// No description provided for @packingCharges.
  ///
  /// In en, this message translates to:
  /// **'Packing charges'**
  String get packingCharges;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @paymentTypeGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google Pay'**
  String get paymentTypeGoogle;

  /// No description provided for @paymentTypeCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get paymentTypeCard;

  /// No description provided for @paymentTypeVipps.
  ///
  /// In en, this message translates to:
  /// **'Vipps Pay'**
  String get paymentTypeVipps;

  /// No description provided for @paymentTypeKlarna.
  ///
  /// In en, this message translates to:
  /// **'Klarna Pay'**
  String get paymentTypeKlarna;

  /// No description provided for @prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get prescription;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'You are offline please check your internet connection.'**
  String get noInternet;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @rejectMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account approval request has been rejected'**
  String get rejectMessage;

  /// No description provided for @blockMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account is currently blocked, so not authorized to allow any activity!'**
  String get blockMessage;

  /// No description provided for @servicePendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Please add your store detail from store web panel and get your orders in the app Store Web URL - '**
  String get servicePendingMessage;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @scheduleOrderTime.
  ///
  /// In en, this message translates to:
  /// **'Schedule Order Time'**
  String get scheduleOrderTime;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @takeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get takeaway;

  /// No description provided for @orderTime.
  ///
  /// In en, this message translates to:
  /// **'Order Time'**
  String get orderTime;

  /// No description provided for @instruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get instruction;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'price'**
  String get price;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @changePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Picture'**
  String get changePicture;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Full Name'**
  String get enterFullName;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Email Address'**
  String get enterEmailAddress;

  /// No description provided for @invalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email Address'**
  String get invalidEmailAddress;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @pendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending Payment'**
  String get pendingPayment;

  /// No description provided for @txtToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get txtToday;

  /// No description provided for @txtUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get txtUpcoming;

  /// No description provided for @txtLast7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get txtLast7Days;

  /// No description provided for @txtThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get txtThisMonth;

  /// No description provided for @txtYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get txtYear;

  /// No description provided for @txtAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get txtAll;

  /// No description provided for @completedOrders.
  ///
  /// In en, this message translates to:
  /// **'Completed Orders'**
  String get completedOrders;

  /// No description provided for @pendingOrders.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get pendingOrders;

  /// No description provided for @cancelledOrders.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Orders'**
  String get cancelledOrders;

  /// No description provided for @confirmPass.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPass;

  /// No description provided for @reEnterPass.
  ///
  /// In en, this message translates to:
  /// **'Re-Enter Password'**
  String get reEnterPass;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid Password'**
  String get invalidPassword;

  /// No description provided for @oldPass.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPass;

  /// No description provided for @passwordMustBe6Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long.'**
  String get passwordMustBe6Characters;

  /// No description provided for @passwordNotMatched.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password not matched'**
  String get passwordNotMatched;

  /// No description provided for @termAndConditionsText.
  ///
  /// In en, this message translates to:
  /// **'Check here to acknowledge that you have read and agree to our'**
  String get termAndConditionsText;

  /// No description provided for @termAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Term & Conditions'**
  String get termAndConditions;

  /// No description provided for @acceptTermAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Accept Term & Conditions Of This App'**
  String get acceptTermAndConditions;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an Account ?'**
  String get alreadyHaveAccount;

  /// No description provided for @minimumBillAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum bill amount'**
  String get minimumBillAmount;

  /// No description provided for @discountOffer.
  ///
  /// In en, this message translates to:
  /// **'Discount offer'**
  String get discountOffer;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @amount_.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount_;

  /// No description provided for @percentage_.
  ///
  /// In en, this message translates to:
  /// **'Percentage (%)'**
  String get percentage_;

  /// No description provided for @percentageMessage.
  ///
  /// In en, this message translates to:
  /// **'Percentage between 0 and 100'**
  String get percentageMessage;

  /// No description provided for @estimatedDeliveryTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery time'**
  String get estimatedDeliveryTime;

  /// No description provided for @storeDeliveryRadius.
  ///
  /// In en, this message translates to:
  /// **'Store delivery radius'**
  String get storeDeliveryRadius;

  /// No description provided for @orderMinAmount.
  ///
  /// In en, this message translates to:
  /// **'Order Minimum Amount'**
  String get orderMinAmount;

  /// No description provided for @packagingCharge.
  ///
  /// In en, this message translates to:
  /// **'Packaging charge'**
  String get packagingCharge;

  /// No description provided for @storeTiming.
  ///
  /// In en, this message translates to:
  /// **'Store timing'**
  String get storeTiming;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @offerUpdated.
  ///
  /// In en, this message translates to:
  /// **'Offer Updated'**
  String get offerUpdated;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @writeAMessageHere.
  ///
  /// In en, this message translates to:
  /// **'Write a message here...'**
  String get writeAMessageHere;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @startTyping.
  ///
  /// In en, this message translates to:
  /// **'Start typing...'**
  String get startTyping;

  /// No description provided for @chatHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No Chat history...'**
  String get chatHistoryEmpty;

  /// No description provided for @openingTime.
  ///
  /// In en, this message translates to:
  /// **'Opening time'**
  String get openingTime;

  /// No description provided for @closingTime.
  ///
  /// In en, this message translates to:
  /// **'Closing time'**
  String get closingTime;

  /// No description provided for @settingUpdateMsg.
  ///
  /// In en, this message translates to:
  /// **'Settings updated successfully'**
  String get settingUpdateMsg;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'Km'**
  String get km;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Account Verification'**
  String get verification;

  /// No description provided for @accountVerification.
  ///
  /// In en, this message translates to:
  /// **'Account Verification'**
  String get accountVerification;

  /// No description provided for @enterVerfCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerfCode;

  /// No description provided for @enterVerfCodeMsg.
  ///
  /// In en, this message translates to:
  /// **'Please wait for the verification code'**
  String get enterVerfCodeMsg;

  /// No description provided for @enterOtp1234.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterOtp1234;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @editNumber.
  ///
  /// In en, this message translates to:
  /// **'Edit Number'**
  String get editNumber;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendEmailMsg.
  ///
  /// In en, this message translates to:
  /// **'Still waiting for the SMS verification code?\nClick below button to resend the code.'**
  String get resendEmailMsg;

  /// No description provided for @resendOtpSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Fresh OTP has sent to your registered phone number'**
  String get resendOtpSuccessMsg;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP 1234'**
  String get enterVerificationCode;

  /// No description provided for @cancelReason.
  ///
  /// In en, this message translates to:
  /// **'Cancel Reason'**
  String get cancelReason;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @enterCompleteOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter Complete OTP'**
  String get enterCompleteOtp;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid otp'**
  String get invalidOtp;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @shoppingCharges.
  ///
  /// In en, this message translates to:
  /// **'shoppingCharges'**
  String get shoppingCharges;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @resendOtpSuccess.
  ///
  /// In en, this message translates to:
  /// **'Fresh OTP has sent to your registered phone number'**
  String get resendOtpSuccess;

  /// No description provided for @apiErrorCancelMsg.
  ///
  /// In en, this message translates to:
  /// **'Request to API server was cancelled'**
  String get apiErrorCancelMsg;

  /// No description provided for @apiErrorConnectTimeoutMsg.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout with API server'**
  String get apiErrorConnectTimeoutMsg;

  /// No description provided for @apiErrorOtherMsg.
  ///
  /// In en, this message translates to:
  /// **'You are offline please check your internet connection.'**
  String get apiErrorOtherMsg;

  /// No description provided for @apiErrorReceiveTimeoutMsg.
  ///
  /// In en, this message translates to:
  /// **'Receive timeout in connection with API server'**
  String get apiErrorReceiveTimeoutMsg;

  /// No description provided for @apiErrorResponseMsg.
  ///
  /// In en, this message translates to:
  /// **'Received invalid status code'**
  String get apiErrorResponseMsg;

  /// No description provided for @apiErrorSendTimeoutMsg.
  ///
  /// In en, this message translates to:
  /// **'Send timeout in connection with API server'**
  String get apiErrorSendTimeoutMsg;

  /// No description provided for @apiErrorUnexpectedErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get apiErrorUnexpectedErrorMsg;

  /// No description provided for @apiErrorCommunicationMsg.
  ///
  /// In en, this message translates to:
  /// **'Error occurred while Communication with Server with StatusCode'**
  String get apiErrorCommunicationMsg;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @addMoneyToWallet.
  ///
  /// In en, this message translates to:
  /// **'Add Money to Wallet'**
  String get addMoneyToWallet;

  /// No description provided for @payByCard.
  ///
  /// In en, this message translates to:
  /// **'Pay By Card'**
  String get payByCard;

  /// No description provided for @payByWallet.
  ///
  /// In en, this message translates to:
  /// **'Pay By Wallet'**
  String get payByWallet;

  /// No description provided for @processToAdd.
  ///
  /// In en, this message translates to:
  /// **'Process To Add'**
  String get processToAdd;

  /// No description provided for @dummyCardNote.
  ///
  /// In en, this message translates to:
  /// **'Note: Add card number 4111 1111 1111 1111 OR 4242 4242 4242 4242'**
  String get dummyCardNote;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get myWallet;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @viewTransaction.
  ///
  /// In en, this message translates to:
  /// **'View Transaction'**
  String get viewTransaction;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @addMoney.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get addMoney;

  /// No description provided for @walletMsg.
  ///
  /// In en, this message translates to:
  /// **'We use secure technology to secure your data'**
  String get walletMsg;

  /// No description provided for @rechargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Recharge Amount'**
  String get rechargeAmount;

  /// No description provided for @transaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transaction;

  /// No description provided for @cardListEmptyMsg.
  ///
  /// In en, this message translates to:
  /// **'No cards available please add new card'**
  String get cardListEmptyMsg;

  /// No description provided for @addCreditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Add Credit/Debit Card'**
  String get addCreditDebitCard;

  /// No description provided for @sureToRemove.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure to Remove?'**
  String get sureToRemove;

  /// No description provided for @removeCardSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Your card removed successfully'**
  String get removeCardSuccessMsg;

  /// No description provided for @safeAndSecurePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Safe and secure payment method'**
  String get safeAndSecurePaymentMethod;

  /// No description provided for @selectCreditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Select Credit/Debit Card'**
  String get selectCreditDebitCard;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Add new Card'**
  String get payment;

  /// No description provided for @hintCardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get hintCardHolderName;

  /// No description provided for @hintYourCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Card Number'**
  String get hintYourCardNumber;

  /// No description provided for @hintExpirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date'**
  String get hintExpirationDate;

  /// No description provided for @hintCvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get hintCvv;

  /// No description provided for @enterHolderName.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Holder Name'**
  String get enterHolderName;

  /// No description provided for @enterCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Number'**
  String get enterCardNumber;

  /// No description provided for @invalidCard.
  ///
  /// In en, this message translates to:
  /// **'Invalid Card Number'**
  String get invalidCard;

  /// No description provided for @selectCardDate.
  ///
  /// In en, this message translates to:
  /// **'Enter Expiration Date'**
  String get selectCardDate;

  /// No description provided for @enterCvv.
  ///
  /// In en, this message translates to:
  /// **'Enter CVV'**
  String get enterCvv;

  /// No description provided for @invalidCvv.
  ///
  /// In en, this message translates to:
  /// **'Invalid CVV'**
  String get invalidCvv;

  /// No description provided for @buttonAddCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get buttonAddCard;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @selectAnyCardMsg.
  ///
  /// In en, this message translates to:
  /// **'Please select any card'**
  String get selectAnyCardMsg;

  /// No description provided for @addCardDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Card Details'**
  String get addCardDetails;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get pleaseEnterAmount;

  /// No description provided for @walletAddSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Wallet amount added successfully'**
  String get walletAddSuccessful;

  /// No description provided for @cardDateFormat.
  ///
  /// In en, this message translates to:
  /// **'MM/YYYY'**
  String get cardDateFormat;

  /// No description provided for @expiryMonthIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Expiry month is invalid'**
  String get expiryMonthIsInvalid;

  /// No description provided for @expiryYearIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Expiry year is invalid'**
  String get expiryYearIsInvalid;

  /// No description provided for @cardHasExpired.
  ///
  /// In en, this message translates to:
  /// **'Card has expired'**
  String get cardHasExpired;

  /// No description provided for @cardAddSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Card added successfully'**
  String get cardAddSuccessful;

  /// No description provided for @manageCard.
  ///
  /// In en, this message translates to:
  /// **'Manage Card'**
  String get manageCard;

  /// No description provided for @searchByContactOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Search by Contact or Email'**
  String get searchByContactOrEmail;

  /// No description provided for @enterContactOrEmailToSearchPerson.
  ///
  /// In en, this message translates to:
  /// **'Please enter the contact number or email to search for the person.'**
  String get enterContactOrEmailToSearchPerson;

  /// No description provided for @beneficial.
  ///
  /// In en, this message translates to:
  /// **'Beneficial'**
  String get beneficial;

  /// No description provided for @beneficialContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Beneficial contact number'**
  String get beneficialContactNumber;

  /// No description provided for @beneficialEmail.
  ///
  /// In en, this message translates to:
  /// **'Beneficial email'**
  String get beneficialEmail;

  /// No description provided for @amountToTransfer.
  ///
  /// In en, this message translates to:
  /// **'Amount to transfer'**
  String get amountToTransfer;

  /// No description provided for @selectUser.
  ///
  /// In en, this message translates to:
  /// **'Select User'**
  String get selectUser;

  /// No description provided for @youCantTransfer.
  ///
  /// In en, this message translates to:
  /// **'You can\'t transfer more than'**
  String get youCantTransfer;

  /// No description provided for @youHave.
  ///
  /// In en, this message translates to:
  /// **'You have'**
  String get youHave;

  /// No description provided for @toTransfer.
  ///
  /// In en, this message translates to:
  /// **'to transfer'**
  String get toTransfer;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @successTransaction.
  ///
  /// In en, this message translates to:
  /// **'You have successfully transferred'**
  String get successTransaction;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get accountDelete;

  /// No description provided for @accountDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete the account?'**
  String get accountDeleteMsg;

  /// No description provided for @cropper.
  ///
  /// In en, this message translates to:
  /// **'Cropper'**
  String get cropper;

  /// No description provided for @resendOtpIn.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in'**
  String get resendOtpIn;

  /// No description provided for @bankDetail.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetail;

  /// No description provided for @accNo.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accNo;

  /// No description provided for @accHolderName.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get accHolderName;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @bankLocation.
  ///
  /// In en, this message translates to:
  /// **'Bank Location'**
  String get bankLocation;

  /// No description provided for @paymentEmail.
  ///
  /// In en, this message translates to:
  /// **'Payment Email'**
  String get paymentEmail;

  /// No description provided for @bankCode.
  ///
  /// In en, this message translates to:
  /// **'BIC/SWIFT Code'**
  String get bankCode;

  /// No description provided for @enterAccountNum.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Number'**
  String get enterAccountNum;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter Bank Name'**
  String get enterBankName;

  /// No description provided for @enterBankLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter Bank Location'**
  String get enterBankLocation;

  /// No description provided for @enterSwiftCode.
  ///
  /// In en, this message translates to:
  /// **'Enter BIC/SWIFT Code'**
  String get enterSwiftCode;

  /// No description provided for @updateBankDetailSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Your bank details updated successfully!'**
  String get updateBankDetailSuccessMsg;

  /// No description provided for @navBankDetail.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get navBankDetail;

  /// No description provided for @referDiscount.
  ///
  /// In en, this message translates to:
  /// **'Referral Discount'**
  String get referDiscount;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// No description provided for @offerType.
  ///
  /// In en, this message translates to:
  /// **'Offer Type'**
  String get offerType;

  /// No description provided for @enterAccountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Holder Name'**
  String get enterAccountHolderName;

  /// No description provided for @sameEditNumberMsg.
  ///
  /// In en, this message translates to:
  /// **'Use a different number. You entered the same one.'**
  String get sameEditNumberMsg;

  /// No description provided for @appExitMessage.
  ///
  /// In en, this message translates to:
  /// **'Back again to exit the app!'**
  String get appExitMessage;

  /// No description provided for @invalidDateSelection.
  ///
  /// In en, this message translates to:
  /// **'Store closing time must be after opening time!'**
  String get invalidDateSelection;

  /// No description provided for @invalidAmountMsg.
  ///
  /// In en, this message translates to:
  /// **'Enter valid amount'**
  String get invalidAmountMsg;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get thankYou;

  /// No description provided for @transactionFailed.
  ///
  /// In en, this message translates to:
  /// **'Transaction Failed'**
  String get transactionFailed;
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
      <String>['da', 'en', 'es', 'no', 'sv'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return AppLocalizationsDa();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'no':
      return AppLocalizationsNo();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
