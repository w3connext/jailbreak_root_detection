
import 'jailbreak_root_detection_platform_interface.dart';

class JailbreakRootDetection {
  Future<String?> getPlatformVersion() {
    return JailbreakRootDetectionPlatform.instance.getPlatformVersion();
  }
}
