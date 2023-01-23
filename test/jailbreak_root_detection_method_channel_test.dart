import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection_method_channel.dart';

void main() {
  MethodChannelJailbreakRootDetection platform = MethodChannelJailbreakRootDetection();
  const MethodChannel channel = MethodChannel('jailbreak_root_detection');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
