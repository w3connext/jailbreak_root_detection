import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'jailbreak_root_detection_platform_interface.dart';

/// An implementation of [JailbreakRootDetectionPlatform] that uses method channels.
class MethodChannelJailbreakRootDetection extends JailbreakRootDetectionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jailbreak_root_detection');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
