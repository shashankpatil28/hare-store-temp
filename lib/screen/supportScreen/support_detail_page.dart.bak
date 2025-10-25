// Path: lib/screen/supportScreen/support_detail_page.dart

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import the Android platform implementation for platform-specific checks/features
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../utils/common_util.dart'; // Assuming this exports toolbarStyle, colors etc.

class SupportDetailPage extends StatefulWidget { // Changed to StatefulWidget for controller lifecycle
  final String title;
  final String pageDetail; // HTML content

  const SupportDetailPage({super.key, required this.title, required this.pageDetail});

  @override
  State<SupportDetailPage> createState() => _SupportDetailPageState();
}

class _SupportDetailPageState extends State<SupportDetailPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent) // Set background if needed
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
             debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
             debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Prevent navigating away if needed, e.g., only allow specific domains
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      // Load the HTML string provided
      ..loadHtmlString(widget.pageDetail);

    // Enable debugging for Android platform if needed
    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      // Optional: Cast and use specific Android features if necessary
      // (_controller.platform as AndroidWebViewController)
      //     .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorMainBackground, // Use your app's background color
        appBar: AppBar(
          automaticallyImplyLeading: true, // Show back button
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            widget.title, // Use widget.title
            textAlign: TextAlign.start,
            style: toolbarStyle(), // Use your app's toolbar style
          ),
        ),
        // Use the WebViewWidget with the initialized controller
        body: WebViewWidget(controller: _controller),
      );
  }
}