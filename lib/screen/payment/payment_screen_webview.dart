// Path: lib/screen/payment/payment_screen_webview.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import Android specific classes if needed for configuration
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../utils/common_util.dart'; // For colors, utils etc.

// Renamed StatefulWidget to avoid conflict with function name
class PaymentScreenWebView extends StatefulWidget {
  final String paymentUrl, failUrl, successUrl;

  const PaymentScreenWebView({
    Key? key,
    required this.paymentUrl,
    required this.failUrl,
    required this.successUrl,
  }) : super(key: key);

  @override
  State<PaymentScreenWebView> createState() => _PaymentScreenWebViewState();
}

class _PaymentScreenWebViewState extends State<PaymentScreenWebView> {
  // Declare controller late, initialize in initState
  late final WebViewController _webController;
  bool _isLoadingPage = true; // Track loading state

  @override
  void initState() {
    super.initState();

    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white) // Use a solid background
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView loading progress: $progress%');
          // You could use progress to show a loading indicator
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
          setState(() {
            _isLoadingPage = true; // Show loader when page starts
          });
          _checkUrlAndPop(url); // Check immediately if it's already success/fail
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
          setState(() {
            _isLoadingPage = false; // Hide loader when finished
          });
           _checkUrlAndPop(url); // Check again when finished
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          // Optionally handle errors, maybe pop with false?
          // Navigator.pop(context, false);
        },
        onNavigationRequest: (NavigationRequest request) {
          final String navigationUrl = request.url;
          debugPrint('Navigation requested to: $navigationUrl');
          // Check if the navigation target is the success or fail URL
          if (_checkUrlAndPop(navigationUrl)) {
             return NavigationDecision.prevent; // Prevent navigation if handled
          }
          // Allow navigation for other URLs (e.g., within the payment provider's flow)
          return NavigationDecision.navigate;
        },
      ))
      // Load the initial payment URL
      ..loadRequest(Uri.parse(widget.paymentUrl));

    // Android specific settings (optional but recommended)
    if (_webController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true); // Enable debugging
      // Cast and apply settings
      (_webController.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(true); // Common setting
    }
  }

  // Helper function to check URL and pop navigator
  bool _checkUrlAndPop(String url) {
    // Trim URLs for safer comparison
    final currentUrl = url.trim();
    final successUrl = widget.successUrl.trim();
    final failUrl = widget.failUrl.trim();

    // Check if the current URL *starts with* the success or fail URL
    // (Handles potential query parameters added by payment gateways)
    if (successUrl.isNotEmpty && currentUrl.startsWith(successUrl)) {
      debugPrint('Success URL detected!');
      // Ensure pop happens only once and safely
      if(Navigator.canPop(context)) {
         Navigator.pop(context, true); // Pop with success result
      }
      return true; // Indicate navigation was handled
    } else if (failUrl.isNotEmpty && currentUrl.startsWith(failUrl)) {
      debugPrint('Failure URL detected!');
      if(Navigator.canPop(context)) {
        Navigator.pop(context, false); // Pop with failure result
      }
      return true; // Indicate navigation was handled
    }
    return false; // Navigation not handled by this check
  }


  @override
  Widget build(BuildContext context) {
    // Use PopScope for modern back navigation handling
    return PopScope(
       canPop: false, // Prevent system back button by default
       onPopInvoked: (didPop) {
         if (didPop) return; // If already popped, do nothing
         // Show a confirmation dialog or pop with a default value (e.g., false for failure)
         debugPrint("Back button pressed on payment screen");
         Navigator.pop(context, false); // Assume back means failure/cancel
       },
      child: Scaffold(
        // Optionally add an AppBar for context
         appBar: AppBar(
             title: Text(languages.payment), // Use localized title
             leading: IconButton( // Custom back/close button
                 icon: const Icon(Icons.close),
                 onPressed: () => Navigator.pop(context, false), // Pop with false on close
             ),
             backgroundColor: colorPrimary, // Your theme color
             systemOverlayStyle: SystemUiOverlayStyle.light, // Adjust status bar style
         ),
        resizeToAvoidBottomInset: false, // Prevent keyboard resizing WebView
        body: SafeArea( // Ensure content is within safe areas
          child: Stack( // Stack to show loader over WebView
            children: [
              WebViewWidget(controller: _webController),
              // Show a loading indicator while the page loads
              if (_isLoadingPage)
                const Center(
                   child: CircularProgressIndicator(color: colorPrimary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Global helper function (keep outside the class if used elsewhere)
// Consider making this part of a PaymentUtils class or similar
 paymentMethodCheck(
  BuildContext context,
  int paymentMethod, { // Assuming paymentMethod determines if WebView is needed
  required String successUrl,
  required String failedUrl,
  required String redirectUrl,
  required Function() onSuccess,
  required Function() onFailed,
}) async { // Make async to await result
  // Assuming paymentMethod 2 requires WebView, others succeed directly
  if (paymentMethod == paymentTypeVipps || paymentMethod == paymentTypeKlarna) { // Check specific types requiring webview
    if (redirectUrl.trim().isNotEmpty) {
      // Await the result from the WebView screen
      final result = await Navigator.push<bool>( // Specify return type bool
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreenWebView( // Use updated name
            paymentUrl: redirectUrl,
            failUrl: failedUrl,
            successUrl: successUrl,
          ),
        ),
      );
      // Handle the result from WebView (true for success, false/null for fail/back)
      if (result == true) {
        onSuccess();
      } else {
        onFailed();
      }
    } else {
      // Redirect URL is empty, consider this a failure
      logd("PaymentCheck", "Redirect URL is empty for payment method $paymentMethod");
      onFailed();
    }
  } else {
    // For other payment methods, assume immediate success
    onSuccess();
  }
}