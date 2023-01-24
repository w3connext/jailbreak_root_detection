import 'dart:io';

import 'package:flutter/material.dart';

import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _processCheckJailbreakRoot();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running on: '),
        ),
      ),
    );
  }

  void _processCheckJailbreakRoot() async {
    print('isNotTrust: ${await JailbreakRootDetection.instance.isNotTrust}');
    print(
        'isJailBroken: ${await JailbreakRootDetection.instance.isJailBroken}');
    print(
        'isRealDevice: ${await JailbreakRootDetection.instance.isRealDevice}');
    if (Platform.isAndroid) {
      print('isOnExternalStorage: ${await JailbreakRootDetection.instance.isOnExternalStorage}');
    }

    if (Platform.isIOS) {
      const bundleId = 'com.w3conext.jailbreakRootDetectionExample';
      print('isTampered: ${await JailbreakRootDetection.instance.isTampered(bundleId)}');
    }
  }
}
