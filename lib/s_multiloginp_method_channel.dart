import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 's_multiloginp_platform_interface.dart';

/// An implementation of [SMultiloginpPlatform] that uses method channels.
class MethodChannelSMultiloginp extends SMultiloginpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('s_multiloginp');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
