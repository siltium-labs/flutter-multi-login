import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s_multiloginp/s_multiloginp_method_channel.dart';

void main() {
  MethodChannelSMultiloginp platform = MethodChannelSMultiloginp();
  const MethodChannel channel = MethodChannel('s_multiloginp');

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
