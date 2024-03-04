import 'package:deego_client/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({super.key});

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  late final WebViewController _controller;

  @override
   void initState() {
    super.initState();

   late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    params = WebKitWebViewControllerCreationParams(
     allowsInlineMediaPlayback: true,
    mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
     );
    } else {
     params = const PlatformWebViewControllerCreationParams();
     }

   final WebViewController controller =
     WebViewController.fromPlatformCreationParams(params);

    controller
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
    NavigationDelegate(
    onProgress: (int progress) {
    // debugPrint('WebView is loading (progress : $progress%)');
    },
   onPageStarted: (String url) {
   // debugPrint('Page started loading: $url');
     },
     onPageFinished: (String url) {
    // debugPrint('Page finished loading: $url');
    },
     onWebResourceError: (WebResourceError error) {
     // debugPrint('''
     //  Page resource error:
     //   code: ${error.errorCode}
     //  description: ${error.description}
     //  errorType: ${error.errorType}
     //   isForMainFrame: ${error.isForMainFrame}
     //   ''');
     },
    onNavigationRequest: (NavigationRequest request) {
    // debugPrint('allowing navigation to ${request.url}');
    return NavigationDecision.navigate;
     },
    ),
     )
    ..addJavaScriptChannel(
    'Toaster',
   onMessageReceived: (JavaScriptMessage message) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message.message)),
    );
     },
     )
     ..loadRequest(Uri.parse('https://deego-mobile-webview-source.s3.ap-northeast-2.amazonaws.com/service.html'));

     if (controller.platform is AndroidWebViewController) {
     AndroidWebViewController.enableDebugging(true);
     (controller.platform as AndroidWebViewController)
     .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true, // 제목 가운데 정렬
        title: Text("서비스 이용 약관",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),

      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.white,
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
