import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker, NetworkInfoImpl])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        final testConnectionFuture = Future.value(true);
        when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) {
          return testConnectionFuture;
        });

        final result = networkInfo.connected;

        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, testConnectionFuture);
      },
    );
  });
}
