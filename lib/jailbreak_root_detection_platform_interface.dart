import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'jailbreak_root_detection_method_channel.dart';

abstract class JailbreakRootDetectionPlatform extends PlatformInterface {
  /// Constructs a JailbreakRootDetectionPlatform.
  JailbreakRootDetectionPlatform() : super(token: _token);

  static final Object _token = Object();

  static JailbreakRootDetectionPlatform _instance = MethodChannelJailbreakRootDetection();

  /// The default instance of [JailbreakRootDetectionPlatform] to use.
  ///
  /// Defaults to [MethodChannelJailbreakRootDetection].
  static JailbreakRootDetectionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JailbreakRootDetectionPlatform] when
  /// they register themselves.
  static set instance(JailbreakRootDetectionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
