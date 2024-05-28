import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSupplierWebView extends StatefulWidget {
  String url;
  OpenSupplierWebView({required this.url});

  @override
  State<OpenSupplierWebView> createState() => _OpenSupplierWebViewState();
}

class _OpenSupplierWebViewState extends State<OpenSupplierWebView> {
  InAppWebViewController? webViewController;

  bool isLoading = false;
  var lastPage = false;
  var newUrl = '';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // canPop: true,
      onPopInvoked: (val) async {
        var lastPage = await webViewController!.canGoBack();
        print("lastPage...$lastPage");
        if (lastPage) {
          webViewController!.goBack();
        } else {
          Navigator.pop(context);
        }
        setState(() {});
      },
      child: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Container(
                color: Colors.transparent,
                width: double.infinity,
                // padding: const EdgeInsets.all(20),
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: WebUri.uri(Uri.parse(widget.url))),

                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptCanOpenWindowsAutomatically: true,
                      transparentBackground: true,
                      useShouldOverrideUrlLoading: true,
                      javaScriptEnabled: true,
                      useOnDownloadStart: true,
                      useOnLoadResource: true,
                      allowFileAccessFromFileURLs: true,
                      allowUniversalAccessFromFileURLs: true,
                      cacheEnabled: true,
                      preferredContentMode: UserPreferredContentMode.MOBILE,
                      // useOnDownloadStart: true
                    ),
                    android: AndroidInAppWebViewOptions(
                      supportMultipleWindows: true,
                      allowContentAccess: true,
                      allowFileAccess: true,
                      loadsImagesAutomatically: true,
                      loadWithOverviewMode: true,
                      useHybridComposition: true,
                      useWideViewPort: true,
                      domStorageEnabled: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                        allowsBackForwardNavigationGestures: true,
                        alwaysBounceVertical: true,
                        useOnNavigationResponse: true),
                  ),
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) {
                    controller.addJavaScriptHandler(
                        handlerName: '',
                        callback: (args) {
                          print(args);
                        });
                    // controller.printError();
                    debugPrint('called');
                    return handleUrlLoading(controller, navigationAction);
                  },
                  onWebViewCreated: (InAppWebViewController controller) async {
                    webViewController = controller;
                    //  webViewController!.complete(controller);
                  },
                  onLoadStart:
                      (InAppWebViewController controller, Uri? url) async {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                        // _history.add('onPageStarted: $url');
                        debugPrint('newUrl: $url');
                      });
                    }
                  },
                  onLoadError: (InAppWebViewController _webViewController,
                      Uri? uri, int i, String s) {
                    debugPrint(" load path ${uri?.path}");
                    debugPrint("s...$s");
                  },
                  onConsoleMessage: (InAppWebViewController _webViewController,
                      ConsoleMessage message) {
                    debugPrint("console message..${message.toString()}");
                  },
                  onLoadHttpError: (InAppWebViewController _webViewController,
                      Uri? url, int i, String s) {
                    print("http print error $s");
                  },

                  // onLoadStart: (controller, Uri? url) {
                  //   print('object');
                  //   if (Platform.isAndroid) {
                  //     CircularProgressIndicator();
                  //     //  const Widgets().widgetLoadingDataWithLogo();
                  //   } else {
                  //     // if (url.toString() == APIConstants.versionHistoryURL) {
                  //     //   const Widgets().widgetLoadingDataWithLogo();
                  //     // }
                  //   }
                  // },
                  onLoadStop: (controller, Uri? url) {
                    isLoading = false;
                    setState(() {});
                    // if (url.toString() == APIConstants.versionHistoryURL) {
                    //   Get.back();
                    // }
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  onCreateWindow: (InAppWebViewController _webViewController,
                      CreateWindowAction action) async {
                    debugPrint('called window');

                    _webViewController.addJavaScriptHandler(
                        handlerName: 'openDRMOKWindow',
                        callback: (args) {
                          print(args);
                        });
                    /* Future.delayed(Duration(milliseconds:200 )).then((value) {
                          var url = action.request.url.toString();
                          debugPrint("request url ${url}");
                        }  );*/
                    debugPrint("request url ${action.request.url}");
                    debugPrint("request url ${action.windowId}");
                    _webViewController.clearCache();
                    await canLaunchUrl(Uri.parse(action.request.url.toString()))
                        ? await launchUrl(
                            Uri.parse(action.request.url.toString()))
                        : throw 'Could not launch ${action.request.url.toString()}';
                    return false;
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      isLoading = false;
                    } else {
                      isLoading = true;
                    }
                    setState(() {
                      print("progress...$progress");
                      // this.progress = progress / 100;
                    });
                  },
                )),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
          ],
        ),
      )),
    );
  }

  Future<NavigationActionPolicy> handleUrlLoading(
      InAppWebViewController controller, NavigationAction action) async {
    debugPrint("url string ${action.request.url.toString()}");
    var url = action.request.url.toString();
    if (url.contains('.pdf')) {
      debugPrint("url pdf${url}");
      setState(() {
        newUrl = url;
      });
      await canLaunchUrl(Uri.parse(url))
          ? await launchUrl(Uri.parse(url))
          : throw 'Could not launch $url';

      return NavigationActionPolicy.CANCEL;
    }
    /*   else if (action.request.url?.toString().startsWith('about:print') ?? false) {
      _convertAndPrint(action.request.url?.toString());
      return NavigationActionPolicy.CANCEL;
    }*/

    else if (url.contains('whatsapp')) {
      debugPrint("url string whatsapp ${action.request.url.toString()}");
      final Uri launchUri = Uri.parse(url);

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $launchUri';
      }
      return NavigationActionPolicy.CANCEL;
    } else if (url.contains('mailto')) {
      debugPrint("url string mail ${action.request.url.toString()}");
      var launchUri = Uri.parse(url);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $launchUri';
      }
      return NavigationActionPolicy.CANCEL;
    } else if (url.contains('tel')) {
      debugPrint("url string tel ${action.request.url.toString()}");
      final Uri launchUri = Uri.parse(url);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $launchUri';
      }
      return NavigationActionPolicy.CANCEL;
    } else if (url.contains('facebook')) {
      debugPrint("url string ${url}");
      await canLaunchUrl(Uri.parse(url))
          ? await launchUrl(Uri.parse(url))
          : throw 'Could not launch $url';
      // and cancel the request
      return NavigationActionPolicy.CANCEL;
    } else {
      return NavigationActionPolicy.ALLOW;
    }
  }
}
