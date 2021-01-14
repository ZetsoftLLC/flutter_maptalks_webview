import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Views',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Arial",
          textTheme: TextTheme(
              button: TextStyle(color: Colors.white, fontSize: 18.0),
              title: TextStyle(color: Colors.red))),
      home: WebViewContainer('http://mplace.zetsoft.uz/core/tester/asror/main.aspx?path=render/places/ZMaptalks/demo/speech/MaptalksSpeech3.php'),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
  PermissionStatus _status;

  @override
  void initState() {
    super.initState();
    // PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse)
    // .then(_updateStatus);
    _askPermission();
  }

  void _updateStatus(PermissionStatus status){
    if(status != _status){
      setState(() {
        _status = status;
      });
    }
  }


  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$_status"),
          actions: [
            IconButton(icon: Icon(Icons.check), onPressed: _askPermission,),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }

  void _askPermission(){
    PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse])
    .then(_onStatusRequested);
  }
  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statues){
    final status = statues[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }
}