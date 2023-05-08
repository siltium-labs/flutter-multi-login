import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 's_multiloginp_method_channel.dart';

abstract class SMultiloginpPlatform extends PlatformInterface {
  /// Constructs a SMultiloginpPlatform.
  SMultiloginpPlatform() : super(token: _token);

  static final Object _token = Object();

  static SMultiloginpPlatform _instance = MethodChannelSMultiloginp();

  /// The default instance of [SMultiloginpPlatform] to use.
  ///
  /// Defaults to [MethodChannelSMultiloginp].
  static SMultiloginpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SMultiloginpPlatform] when
  /// they register themselves.
  static set instance(SMultiloginpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
