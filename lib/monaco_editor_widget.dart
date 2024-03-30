import 'dart:html' as html;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:js' as js;

class MonacoEditorWidget extends StatefulWidget {
  @override
  _MonacoEditorWidgetState createState() => _MonacoEditorWidgetState();
}

class _MonacoEditorWidgetState extends State<MonacoEditorWidget> {
  late StreamSubscription<html.MessageEvent> _messageSubscription;
  
  @override
  void initState() {
    super.initState();
    
    _messageSubscription = html.window.onMessage
      .listen((event) {
        print(event.data);
    });
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //iFrame
    final String iframeId = 'monaco-editor-container';

    //create iframe element
    final html.IFrameElement iframeElement = html.IFrameElement()
      ..src = 'monaco_editor.html'
      ..style.border = 'none';

      //register iframe
      //ignore:undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        iframeId,
        (int viewId) => iframeElement,
      );

      return HtmlElementView(viewType: iframeId);
  }
}