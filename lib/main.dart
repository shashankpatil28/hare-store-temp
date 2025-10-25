// Path: lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle, DeviceOrientation;
// --- FIX 1: Correct import path ---
import 'l10n/app_localizations.dart'; 
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:translator/translator.dart';

import 'firebase_options.dart';
import 'screen/splashScreen/splash_screen.dart';
import 'service/push_notification_service.dart';
import 'utils/common_util.dart';

late SharedPreferences sharedPrefs;
PushNotificationService myFirebaseService = PushNotificationService();
final navigatorKey = GlobalKey<NavigatorState>();
Locale localeCode = const Locale("en");
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

String? localTimeZone;
final translator = GoogleTranslator();
late AppLocalizations languages;

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // --- FIX 2: Get .timezone property from the object ---
  final String localTimezoneString = (await FlutterTimezone.getLocalTimezone()).timezone; 
  localTimeZone = localTimezoneString;
  
  var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
  if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    String? token = await FirebaseMessaging.instance.getToken();
    firebaseAuth().then((value) {
      setFireToken(token ?? "");
    });
  }
  sharedPrefs = await SharedPreferences.getInstance();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      myFirebaseService.setToken();
      myFirebaseService.setListener();
      sharedPrefs = await reloadSharedPreference();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void setLocale(Locale locale) {
    setState(() {
      localeCode = locale;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await reloadSharedPreference();
          isBackgroundNotification();
        });
        logd(tag, "main : resume");
        break;
      case AppLifecycleState.inactive:
        logd(tag, "main : inactive");
        break;
      case AppLifecycleState.paused:
        logd(tag, "main : paused");
        break;
      case AppLifecycleState.detached: // This is deprecated but still works
        logd(tag, "main : detached");
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    var materialApp = MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      navigatorKey: navigatorKey,
      debugShowMaterialGrid: false,
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: colorPrimary,
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: colorPrimary, secondary: colorPrimary),
        unselectedWidgetColor: colorPrimary,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: colorPrimary,
        ),
        fontFamily: GoogleFonts.nunito().fontFamily,
        scaffoldBackgroundColor: colorWhite,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          titleSpacing: 0,
          color: colorWhite,
          elevation: 3,
          shadowColor: Color(0x33000000),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: IconThemeData(
            color: colorTextCommon,
          ),
        ),
      ),
      color: colorPrimary,
      debugShowCheckedModeBanner: false,
      locale: localeCode,
      scrollBehavior: MyBehavior()
          .copyWith(overscroll: false, physics: const ClampingScrollPhysics()),
      builder: (context, child) {
        deviceWidth = MediaQuery.of(context).size.width;
        deviceHeight = MediaQuery.of(context).size.height;
        deviceAverageSize = (deviceWidth + deviceHeight) / 2;
        statusHeight = MediaQuery.of(context).padding.top;
        
        // This line was already fixed in a previous step
        textScaleFactorOf = MediaQuery.of(context).textScaleFactor;
        
        // This check should now work with the corrected import
        if (AppLocalizations.of(context) != null) {
          languages = AppLocalizations.of(context)!;
        }

        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child ?? Container());
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: materialApp);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}