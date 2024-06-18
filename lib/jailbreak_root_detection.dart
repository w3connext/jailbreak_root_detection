import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum JailbreakIssue {
  jailbreak,
  notRealDevice,
  proxied,
  debugged,
  reverseEngineered,
  fridaFound,
  cydiaFound,
  tampered,
  onExternalStorage,
  unknown;

  static JailbreakIssue fromString(String value) {
    if (value == "jailbreak") {
      return JailbreakIssue.jailbreak;
    }
    if (value == "notRealDevice") {
      return JailbreakIssue.notRealDevice;
    }
    if (value == "proxied") {
      return JailbreakIssue.proxied;
    }
    if (value == "debugged") {
      return JailbreakIssue.debugged;
    }
    if (value == "reverseEngineered") {
      return JailbreakIssue.reverseEngineered;
    }
    if (value == "fridaFound") {
      return JailbreakIssue.fridaFound;
    }
    if (value == "cydiaFound") {
      return JailbreakIssue.cydiaFound;
    }
    if (value == "tampered") {
      return JailbreakIssue.tampered;
    }
    if (value == "onExternalStorage") {
      return JailbreakIssue.onExternalStorage;
    }

    return JailbreakIssue.unknown;
  }
}

class JailbreakRootDetection {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jailbreak_root_detection');

  static final JailbreakRootDetection _instance = JailbreakRootDetection();

  static JailbreakRootDetection get instance => _instance;

  Future<List<JailbreakIssue>> get checkForIssues async {
    final issues =
        await methodChannel.invokeMethod<List<dynamic>>('checkForIssues');

    return issues?.map((e) => JailbreakIssue.fromString(e ?? '')).toList() ??
        [];
  }

  /// Support iOS and Android
  Future<bool> get isJailBroken async =>
      await methodChannel.invokeMethod<bool>('isJailBroken') ?? false;

  /// Support iOS and Android
  Future<bool> get isRealDevice async =>
      await methodChannel.invokeMethod<bool>('isRealDevice') ?? false;

  /// Support Android
  Future<bool> get isDevMode async =>
      await methodChannel.invokeMethod<bool>('isDevMode') ?? false;

  /// Support iOS only
  Future<bool> isTampered(String bundleId) async =>
      await methodChannel
          .invokeMethod<bool>('isTampered', {'bundleId': bundleId}) ??
      false;

  /// Support Android only
  Future<bool> get isOnExternalStorage async =>
      await methodChannel.invokeMethod<bool>('isOnExternalStorage') ?? false;

  /// Support iOS and Android
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
