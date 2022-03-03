import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tiktok/src/pages/tik_tok.dart';

void main() {
  runApp(
    MaterialApp(
      home: TikTok(),
    )
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black
    )
  );
}
