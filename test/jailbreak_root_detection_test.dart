import 'package:flutter_test/flutter_test.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection_platform_interface.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJailbreakRootDetectionPlatform
    with MockPlatformInterfaceMixin
    implements JailbreakRootDetectionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final JailbreakRootDetectionPlatform initialPlatform = JailbreakRootDetectionPlatform.instance;

  test('$MethodChannelJailbreakRootDetection is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJailbreakRootDetection>());
  });

  test('getPlatformVersion', () async {
    JailbreakRootDetection jailbreakRootDetectionPlugin = JailbreakRootDetection();
    MockJailbreakRootDetectionPlatform fakePlatform = MockJailbreakRootDetectionPlatform();
    JailbreakRootDetectionPlatform.instance = fakePlatform;

    expect(await jailbreakRootDetectionPlugin.getPlatformVersion(), '42');
  });
}
