import 'package:flutter_test/flutter_test.dart';
import 'package:s_multiloginp/s_multiloginp.dart';
import 'package:s_multiloginp/s_multiloginp_platform_interface.dart';
import 'package:s_multiloginp/s_multiloginp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSMultiloginpPlatform
    with MockPlatformInterfaceMixin
    implements SMultiloginpPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SMultiloginpPlatform initialPlatform = SMultiloginpPlatform.instance;

  test('$MethodChannelSMultiloginp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSMultiloginp>());
  });

  test('getPlatformVersion', () async {
    SMultiloginp sMultiloginpPlugin = SMultiloginp();
    MockSMultiloginpPlatform fakePlatform = MockSMultiloginpPlatform();
    SMultiloginpPlatform.instance = fakePlatform;

    expect(await sMultiloginpPlugin.getPlatformVersion(), '42');
  });
}
