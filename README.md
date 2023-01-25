# jailbreak_root_detection

[![pub package](https://img.shields.io/pub/v/jailbreak_root_detection.svg)](https://pub.dartlang.org/packages/jailbreak_root_detection)

Uses [RootBeer](https://github.com/scottyab/rootbeer) + DetectFrida for Android root detection and [IOSSecuritySuite](https://github.com/securing/IOSSecuritySuite) for iOS jailbreak detection.

## Getting started

In your flutter project add the dependency:

```yaml
jailbreak_root_detection: "^0.0.6"
```

## Usage

### Android

```dart
final isNotTrust = await JailbreakRootDetection.instance.isNotTrust;
final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
final isOnExternalStorage = await JailbreakRootDetection.instance.isOnExternalStorage;
```

### iOS

- Update `Info.plist`

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>undecimus</string>
    <string>sileo</string>
    <string>zbra</string>
    <string>filza</string>
    <string>activator</string>
    <string>cydia</string>
</array>
```

```dart
final isNotTrust = await JailbreakRootDetection.instance.isNotTrust;
final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;

final bundleId = 'my-bundle-id'; // Ex: final bundleId = 'com.w3conext.jailbreakRootDetectionExample'
final isTampered = await JailbreakRootDetection.instance.isTampered(bundleId);
```

### Reference

- https://github.com/anish-adm/trust_fall