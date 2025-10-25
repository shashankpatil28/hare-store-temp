// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Hare Store';

  @override
  String get liveOrders => 'Live Orders';

  @override
  String permissionText1(Object appName) {
    return 'Allow $appName to display over Other apps';
  }

  @override
  String permissionText2(Object appName) {
    return 'Allow $appName to display over Other apps in Order to receive orders when you\'re online.';
  }

  @override
  String get permissionText3 =>
      'Tap Allow and slide the toggle on the Settings screen on to on';

  @override
  String get permissionText4 =>
      'Set the Quick access icon to on to see this icon over other apps';

  @override
  String get quickAccessIcon => 'Quick Access icon';

  @override
  String get settingsPermission => 'Go to Settings';

  @override
  String get newUpdateAvailable => 'New update available!';

  @override
  String get newUpdateMsg =>
      'Please update the new app from the store for further access app.';

  @override
  String get next => 'Next';

  @override
  String get labelWelcome => 'Welcome';

  @override
  String get select => 'Select';

  @override
  String get online => 'Online';

  @override
  String get connection => 'Connection';

  @override
  String get connectionMsg => 'Please check network connectivity';

  @override
  String get offline => 'Offline';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get preferenceMsg => 'You can change settings later from preference';

  @override
  String get contactNumber => 'Mobile Number';

  @override
  String get bookingID => 'Booking ID';

  @override
  String get cancel => 'Cancel';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get enterPass => 'Enter password';

  @override
  String get dontHaveAccount => 'Don\'t have an account ?';

  @override
  String get enterConfirmPass => 'Enter Confirm Password';

  @override
  String get enterContactNumber => 'Enter Mobile Number';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get emptyData => 'Sorry!!\nNo record found this time';

  @override
  String get login => 'Login';

  @override
  String get loginHere => 'Login here';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginToContinue => 'Login to continue';

  @override
  String get logout => 'Logout';

  @override
  String get logoutMsg => 'Are you sure you want to logout?';

  @override
  String get newPass => 'New Password';

  @override
  String get enterNewPass => 'Enter New Password';

  @override
  String get enterOldPass => 'Enter Old Password';

  @override
  String get no => 'No';

  @override
  String get noConnection => 'No Internet Connection Please Try Again';

  @override
  String get ok => 'Ok';

  @override
  String get orderId => 'Order ID';

  @override
  String get otp => 'OTP';

  @override
  String get password => 'Password';

  @override
  String get paymentType => 'Payment type';

  @override
  String get paymentSettlement => 'Payment Settlement';

  @override
  String get settle => 'Settle';

  @override
  String get unSettle => 'Unsettle';

  @override
  String get retry => 'Retry';

  @override
  String get save => 'Save';

  @override
  String get send => 'Send';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpText => 'By registering you agree with our';

  @override
  String get termAndConditionUse => 'Term & condition';

  @override
  String get ofUse => 'of use';

  @override
  String get productBy => 'Product By';

  @override
  String get register => 'Register';

  @override
  String get registerNow => 'Register now!';

  @override
  String get registerWith => 'Register with';

  @override
  String get submit => 'Submit';

  @override
  String get update => 'Update';

  @override
  String get view => 'View';

  @override
  String get yes => 'Yes';

  @override
  String get navLogout => 'Logout';

  @override
  String get navSupport => 'Support';

  @override
  String get navSetting => 'Setting';

  @override
  String get change => 'Change';

  @override
  String get navOffer => 'Offer';

  @override
  String get removeOffer => 'Remove Offer';

  @override
  String get removeOfferMsg => 'Are you sure want to remove offer?';

  @override
  String get navChangePassword => 'Change Password';

  @override
  String get setNewPassword => 'Set New Password';

  @override
  String get passChangeSuccessMsg => 'Your password changed successfully!';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordMsg =>
      'Do you want to change your current password?';

  @override
  String get navMyProfile => 'My Profile';

  @override
  String get storeOwner => 'Store Owner';

  @override
  String get selectStore => 'Select Store';

  @override
  String get myProfileUpdated => 'Profile updated successfully';

  @override
  String get navEarningPastOrder => 'Earning & Past Order';

  @override
  String get pastUpcomingList => 'Past & Upcoming Order List';

  @override
  String get navOrderHistory => 'Order History';

  @override
  String get earning => 'Earning';

  @override
  String get filter => 'Filter';

  @override
  String get filterOrder => 'Filter Order';

  @override
  String get navProducts => 'Products';

  @override
  String get navOrders => 'Orders';

  @override
  String get preferences => 'Preference';

  @override
  String get chatWithAdmin => 'Chat With Admin';

  @override
  String get admin => 'Admin';

  @override
  String get updatePreferences => 'Preferences Updated';

  @override
  String get dispatchOrder => 'Dispatch';

  @override
  String get splTagLine => 'For Store Owner';

  @override
  String get processingOrder => 'Processing';

  @override
  String get acceptOrder => 'Accept';

  @override
  String get reject => 'Reject';

  @override
  String get rejected => 'Rejected';

  @override
  String get rejectOrder => 'Reject order';

  @override
  String get rejectOrderMessage => 'Are you sure you reject this order?';

  @override
  String get enterRejectReason => 'Enter reject reason';

  @override
  String get newOrder => 'New';

  @override
  String get newOrderDetail => 'New Order';

  @override
  String get orderDispatched => 'Order In Route';

  @override
  String get orderInProcess => 'Order In Process';

  @override
  String get startProcess => 'Start Process';

  @override
  String get orderReady => 'Ready This Order';

  @override
  String get orderPickedUp => 'Order Picked Up';

  @override
  String get accept => 'Accept';

  @override
  String get accepted => 'Accepted';

  @override
  String get driver => 'Driver';

  @override
  String get orderDetail => 'Order Detail';

  @override
  String get customer => 'Customer';

  @override
  String get deliveryPerson => 'Delivery person';

  @override
  String get itemTotal => 'Item total';

  @override
  String get deliveryCharges => 'Delivery charges';

  @override
  String get packingCharges => 'Packing charges';

  @override
  String get discount => 'Discount';

  @override
  String get tax => 'Tax';

  @override
  String get total => 'Total';

  @override
  String get paymentTypeGoogle => 'Google Pay';

  @override
  String get paymentTypeCard => 'Card';

  @override
  String get paymentTypeVipps => 'Vipps Pay';

  @override
  String get paymentTypeKlarna => 'Klarna Pay';

  @override
  String get prescription => 'Prescription';

  @override
  String get complete => 'Complete';

  @override
  String get noInternet =>
      'You are offline please check your internet connection.';

  @override
  String get completed => 'Completed';

  @override
  String get pending => 'Pending';

  @override
  String get rejectMessage => 'Your account approval request has been rejected';

  @override
  String get blockMessage =>
      'Your account is currently blocked, so not authorized to allow any activity!';

  @override
  String get servicePendingMessage =>
      'Please add your store detail from store web panel and get your orders in the app Store Web URL - ';

  @override
  String get deliveryAddress => 'Delivery Address';

  @override
  String get scheduleOrderTime => 'Schedule Order Time';

  @override
  String get schedule => 'Schedule';

  @override
  String get takeaway => 'Takeaway';

  @override
  String get orderTime => 'Order Time';

  @override
  String get instruction => 'Instruction';

  @override
  String get price => 'price';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get changePicture => 'Change Picture';

  @override
  String get fullName => 'Full Name';

  @override
  String get gender => 'Gender';

  @override
  String get email => 'Email Address';

  @override
  String get enterFullName => 'Enter Full Name';

  @override
  String get enterEmailAddress => 'Enter Email Address';

  @override
  String get invalidEmailAddress => 'Invalid Email Address';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get pendingPayment => 'Pending Payment';

  @override
  String get txtToday => 'Today';

  @override
  String get txtUpcoming => 'Upcoming';

  @override
  String get txtLast7Days => 'Last 7 Days';

  @override
  String get txtThisMonth => 'Last 30 Days';

  @override
  String get txtYear => 'This Year';

  @override
  String get txtAll => 'All';

  @override
  String get completedOrders => 'Completed Orders';

  @override
  String get pendingOrders => 'Pending Orders';

  @override
  String get cancelledOrders => 'Cancelled Orders';

  @override
  String get confirmPass => 'Confirm Password';

  @override
  String get reEnterPass => 'Re-Enter Password';

  @override
  String get invalidPassword => 'Invalid Password';

  @override
  String get oldPass => 'Old Password';

  @override
  String get passwordMustBe6Characters =>
      'Password must be at least 6 characters long.';

  @override
  String get passwordNotMatched => 'Confirm Password not matched';

  @override
  String get termAndConditionsText =>
      'Check here to acknowledge that you have read and agree to our';

  @override
  String get termAndConditions => 'Term & Conditions';

  @override
  String get acceptTermAndConditions => 'Accept Term & Conditions Of This App';

  @override
  String get alreadyHaveAccount => 'Already have an Account ?';

  @override
  String get minimumBillAmount => 'Minimum bill amount';

  @override
  String get discountOffer => 'Discount offer';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get amount_ => 'Amount';

  @override
  String get percentage_ => 'Percentage (%)';

  @override
  String get percentageMessage => 'Percentage between 0 and 100';

  @override
  String get estimatedDeliveryTime => 'Estimated delivery time';

  @override
  String get storeDeliveryRadius => 'Store delivery radius';

  @override
  String get orderMinAmount => 'Order Minimum Amount';

  @override
  String get packagingCharge => 'Packaging charge';

  @override
  String get storeTiming => 'Store timing';

  @override
  String get day => 'Day';

  @override
  String get offerUpdated => 'Offer Updated';

  @override
  String get chat => 'Chat';

  @override
  String get writeAMessageHere => 'Write a message here...';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get startTyping => 'Start typing...';

  @override
  String get chatHistoryEmpty => 'No Chat history...';

  @override
  String get openingTime => 'Opening time';

  @override
  String get closingTime => 'Closing time';

  @override
  String get settingUpdateMsg => 'Settings updated successfully';

  @override
  String get min => 'Min';

  @override
  String get km => 'Km';

  @override
  String get verification => 'Account Verification';

  @override
  String get accountVerification => 'Account Verification';

  @override
  String get enterVerfCode => 'Enter Verification Code';

  @override
  String get enterVerfCodeMsg => 'Please wait for the verification code';

  @override
  String get enterOtp1234 => 'Enter verification code';

  @override
  String get verify => 'Verify';

  @override
  String get editNumber => 'Edit Number';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get resendEmailMsg =>
      'Still waiting for the SMS verification code?\nClick below button to resend the code.';

  @override
  String get resendOtpSuccessMsg =>
      'Fresh OTP has sent to your registered phone number';

  @override
  String get enterVerificationCode => 'Enter OTP 1234';

  @override
  String get cancelReason => 'Cancel Reason';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get enterCompleteOtp => 'Enter Complete OTP';

  @override
  String get invalidOtp => 'Invalid otp';

  @override
  String get verificationCode => 'Verification code';

  @override
  String get shoppingCharges => 'shoppingCharges';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get resendOtpSuccess =>
      'Fresh OTP has sent to your registered phone number';

  @override
  String get apiErrorCancelMsg => 'Request to API server was cancelled';

  @override
  String get apiErrorConnectTimeoutMsg => 'Connection timeout with API server';

  @override
  String get apiErrorOtherMsg =>
      'You are offline please check your internet connection.';

  @override
  String get apiErrorReceiveTimeoutMsg =>
      'Receive timeout in connection with API server';

  @override
  String get apiErrorResponseMsg => 'Received invalid status code';

  @override
  String get apiErrorSendTimeoutMsg =>
      'Send timeout in connection with API server';

  @override
  String get apiErrorUnexpectedErrorMsg => 'Unexpected error occurred';

  @override
  String get apiErrorCommunicationMsg =>
      'Error occurred while Communication with Server with StatusCode';

  @override
  String get remove => 'Remove';

  @override
  String get addMoneyToWallet => 'Add Money to Wallet';

  @override
  String get payByCard => 'Pay By Card';

  @override
  String get payByWallet => 'Pay By Wallet';

  @override
  String get processToAdd => 'Process To Add';

  @override
  String get dummyCardNote =>
      'Note: Add card number 4111 1111 1111 1111 OR 4242 4242 4242 4242';

  @override
  String get myWallet => 'My Wallet';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get viewTransaction => 'View Transaction';

  @override
  String get transfer => 'Transfer';

  @override
  String get search => 'Search';

  @override
  String get addMoney => 'Add Money';

  @override
  String get walletMsg => 'We use secure technology to secure your data';

  @override
  String get rechargeAmount => 'Recharge Amount';

  @override
  String get transaction => 'Transaction';

  @override
  String get cardListEmptyMsg => 'No cards available please add new card';

  @override
  String get addCreditDebitCard => 'Add Credit/Debit Card';

  @override
  String get sureToRemove => 'Are You Sure to Remove?';

  @override
  String get removeCardSuccessMsg => 'Your card removed successfully';

  @override
  String get safeAndSecurePaymentMethod => 'Safe and secure payment method';

  @override
  String get selectCreditDebitCard => 'Select Credit/Debit Card';

  @override
  String get payment => 'Add new Card';

  @override
  String get hintCardHolderName => 'Card Holder Name';

  @override
  String get hintYourCardNumber => 'Your Card Number';

  @override
  String get hintExpirationDate => 'Expiration Date';

  @override
  String get hintCvv => 'CVV';

  @override
  String get enterHolderName => 'Enter Card Holder Name';

  @override
  String get enterCardNumber => 'Enter Card Number';

  @override
  String get invalidCard => 'Invalid Card Number';

  @override
  String get selectCardDate => 'Enter Expiration Date';

  @override
  String get enterCvv => 'Enter CVV';

  @override
  String get invalidCvv => 'Invalid CVV';

  @override
  String get buttonAddCard => 'Add Card';

  @override
  String get wallet => 'Wallet';

  @override
  String get selectAnyCardMsg => 'Please select any card';

  @override
  String get addCardDetails => 'Add Card Details';

  @override
  String get addCard => 'Add Card';

  @override
  String get pleaseEnterAmount => 'Please enter amount';

  @override
  String get walletAddSuccessful => 'Wallet amount added successfully';

  @override
  String get cardDateFormat => 'MM/YYYY';

  @override
  String get expiryMonthIsInvalid => 'Expiry month is invalid';

  @override
  String get expiryYearIsInvalid => 'Expiry year is invalid';

  @override
  String get cardHasExpired => 'Card has expired';

  @override
  String get cardAddSuccessful => 'Card added successfully';

  @override
  String get manageCard => 'Manage Card';

  @override
  String get searchByContactOrEmail => 'Search by Contact or Email';

  @override
  String get enterContactOrEmailToSearchPerson =>
      'Please enter the contact number or email to search for the person.';

  @override
  String get beneficial => 'Beneficial';

  @override
  String get beneficialContactNumber => 'Beneficial contact number';

  @override
  String get beneficialEmail => 'Beneficial email';

  @override
  String get amountToTransfer => 'Amount to transfer';

  @override
  String get selectUser => 'Select User';

  @override
  String get youCantTransfer => 'You can\'t transfer more than';

  @override
  String get youHave => 'You have';

  @override
  String get toTransfer => 'to transfer';

  @override
  String get success => 'Success';

  @override
  String get successTransaction => 'You have successfully transferred';

  @override
  String get delete => 'Delete';

  @override
  String get accountDelete => 'Delete Account';

  @override
  String get accountDeleteMsg => 'Are you sure to delete the account?';

  @override
  String get cropper => 'Cropper';

  @override
  String get resendOtpIn => 'Resend OTP in';

  @override
  String get bankDetail => 'Bank Details';

  @override
  String get accNo => 'Account Number';

  @override
  String get accHolderName => 'Account Holder Name';

  @override
  String get bankName => 'Bank Name';

  @override
  String get bankLocation => 'Bank Location';

  @override
  String get paymentEmail => 'Payment Email';

  @override
  String get bankCode => 'BIC/SWIFT Code';

  @override
  String get enterAccountNum => 'Enter Account Number';

  @override
  String get enterBankName => 'Enter Bank Name';

  @override
  String get enterBankLocation => 'Enter Bank Location';

  @override
  String get enterSwiftCode => 'Enter BIC/SWIFT Code';

  @override
  String get updateBankDetailSuccessMsg =>
      'Your bank details updated successfully!';

  @override
  String get navBankDetail => 'Bank Details';

  @override
  String get referDiscount => 'Referral Discount';

  @override
  String get tip => 'Tip';

  @override
  String get offerType => 'Offer Type';

  @override
  String get enterAccountHolderName => 'Enter Account Holder Name';

  @override
  String get sameEditNumberMsg =>
      'Use a different number. You entered the same one.';

  @override
  String get appExitMessage => 'Back again to exit the app!';

  @override
  String get invalidDateSelection =>
      'Store closing time must be after opening time!';

  @override
  String get invalidAmountMsg => 'Enter valid amount';

  @override
  String get thankYou => 'Thank You';

  @override
  String get transactionFailed => 'Transaction Failed';
}
