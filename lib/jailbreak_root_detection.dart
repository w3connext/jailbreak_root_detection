import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JailbreakRootDetection {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jailbreak_root_detection');

  static final JailbreakRootDetection _instance = JailbreakRootDetection();

  static JailbreakRootDetection get instance => _instance;

  Future<bool> get isJailBroken async =>
      await methodChannel.invokeMethod<bool>('isJailBroken') ?? false;

  Future<bool> get isRealDevice async =>
      await methodChannel.invokeMethod<bool>('isRealDevice') ?? false;

  Future<bool> get isOnExternalStorage async =>
      await methodChannel.invokeMethod<bool>('isOnExternalStorage') ?? false;

  Future<bool> get isNotTrust async {
    try {
      final bool jailBroken = await isJailBroken;
      final bool realDevice = await isRealDevice;
      if (Platform.isAndroid) {
        final bool onExternalStorage = await isOnExternalStorage;
        return jailBroken || !realDevice || onExternalStorage;
      }
      return jailBroken || !realDevice;
    } catch (e) {
      return true;
    }
  }
}
