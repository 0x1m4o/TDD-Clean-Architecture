import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/network/network_info.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late final MockInternetConnectionChecker mockInternetConnectionChecker;
  late final NetworkInfoImpl networkInfoImpl;

  setUpAll(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
        internetConnectionChecker: mockInternetConnectionChecker);
  });
  group('isConnected', () {
    test(
      'should forward the connection result to the internetconection.hasconnection',
      () async {
        final tHasConnection = Future.value(true);
        // arrange
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnection);

        // act
        final result = networkInfoImpl.isConnected;

        // assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      },
    );
  });
}
