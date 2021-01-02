import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maptalks Demo'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
              ),
              Expanded(
                child: Container(
                  child: InAppWebView(
                    initialFile: "assets/web-maptalks/index.html",
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
                    )),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });

                      // //    await controller.injectJavascriptFileFromUrl(urlFile: "https://code.jquery.com/jquery-3.3.1.min.js");
                      // // // wait for jquery to be loaded
                      // await controller.injectJavascriptFileFromUrl(
                      //     urlFile:
                      //         "https://code.jquery.com/jquery-3.3.1.min.js");
                      // // wait for jquery to be loaded

                      // await controller.injectCSSFileFromAsset(
                      //   assetFilePath: "assets/web-maptalks/maptalks.min.js",
                      // );

                      // await controller.injectCSSFileFromAsset(
                      //   assetFilePath: "assets/web-maptalks/settings.js",
                      // );

                      // String result3 = await controller.evaluateJavascript(
                      //     source: "\$('body').html();");
                      // print(result3);
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
