import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:lpt/api/facebook_api.dart';

import 'facebook_api_test.mocks.dart';

@GenerateMocks([FacebookAuth, FirebaseAuth, LoginResult, AccessToken, UserCredential])
void main() {
  late MockFacebookAuth mockFacebookAuth;
  late MockFirebaseAuth mockFirebaseAuth;
  late FacebookApi facebookApi;

  setUp(() {
    mockFacebookAuth = MockFacebookAuth();
    mockFirebaseAuth = MockFirebaseAuth();
    facebookApi = const FacebookApi();
  });

  test('Should return user data on successful login', () async {
    final mockAccessToken = MockAccessToken();
    final mockLoginResult = MockLoginResult();
    final mockUserCredential = MockUserCredential();
    const fakeUserData = {'id': '12345'};

    when(mockLoginResult.status).thenReturn(LoginStatus.success);
    when(mockLoginResult.accessToken).thenReturn(mockAccessToken);
    when(mockAccessToken.tokenString).thenReturn('mock_token');

    when(mockFacebookAuth.login(permissions: anyNamed('permissions'))).thenAnswer((_) async => mockLoginResult);
    when(mockFacebookAuth.getUserData(fields: anyNamed('fields'))).thenAnswer((_) async => fakeUserData);

    when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => mockUserCredential);

    final result = await facebookApi.signIn();

    expect(result, equals(fakeUserData));
  });

  test('Should return null', () async {
    final mockLoginResult = MockLoginResult();

    when(mockLoginResult.status).thenReturn(LoginStatus.failed);
    when(mockFacebookAuth.login(permissions: anyNamed('permissions'))).thenAnswer((_) async => mockLoginResult);

    final result = await facebookApi.signIn();

    expect(result, isNull);
  });

  test('Should throw an error', () async {
    when(mockFacebookAuth.login(permissions: anyNamed('permissions'))).thenThrow(Exception('Login failed'));

    expect(() async => await facebookApi.signIn(), throwsException);
  });
}
