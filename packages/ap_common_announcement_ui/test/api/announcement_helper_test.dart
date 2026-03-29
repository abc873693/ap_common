import 'dart:convert';

import 'package:ap_common_announcement_ui/src/api/announcement_helper.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_mock_adapter/src/handlers/request_handler.dart';

// A valid JWT token for testing.
final String _testJwt = <String>[
  base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}')),
  base64Url.encode(
    utf8.encode(
      '{"user":{"permission_level":2,"username":"admin",'
      '"login_type":"normal"},"iat":1700000000,'
      '"exp":9999999999}',
    ),
  ),
  'test_signature',
].join('.');

final Map<String, dynamic> _loginResponse = <String, dynamic>{
  'key': _testJwt,
};

final Map<String, dynamic> _announcementListResponse = <String, dynamic>{
  'data': <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Announcement 1',
      'id': 1,
      'weight': 10,
      'imgUrl': 'https://example.com/1.png',
      'description': 'Description 1',
    },
    <String, dynamic>{
      'title': 'Announcement 2',
      'id': 2,
      'weight': 20,
      'imgUrl': 'https://example.com/2.png',
      'description': 'Description 2',
    },
  ],
};

final Map<String, dynamic> _singleAnnouncementResponse = <String, dynamic>{
  'data': <String, dynamic>{
    'title': 'Single',
    'id': 99,
    'weight': 5,
    'imgUrl': 'https://example.com/99.png',
    'description': 'Single desc',
  },
};

void main() {
  late AnnouncementHelper helper;
  late DioAdapter dioAdapter;

  setUp(() {
    helper = AnnouncementHelper();
    dioAdapter = DioAdapter(dio: helper.dio);
  });

  // ---------------------------------------------------------------------------
  // Auth
  // ---------------------------------------------------------------------------

  group('login', () {
    test('returns ApiSuccess with login data on 200', () async {
      dioAdapter.onPost(
        '/login',
        (MockServer server) => server.reply(200, _loginResponse),
        data: Matchers.any,
      );

      final ApiResult<AnnouncementLoginData> result = await helper.login(
        username: 'admin',
        password: 'pass',
      );

      expect(result, isA<ApiSuccess<AnnouncementLoginData>>());
      final AnnouncementLoginData data =
          (result as ApiSuccess<AnnouncementLoginData>).data;
      expect(data.key, _testJwt);
      expect(helper.username, 'admin');
      expect(helper.password, 'pass');
      expect(helper.loginType, AnnouncementLoginType.normal);
      expect(
        helper.dio.options.headers['Authorization'],
        'Bearer $_testJwt',
      );
    });

    test('returns ApiError on 401', () async {
      dioAdapter.onPost(
        '/login',
        (MockServer server) => server.reply(401, 'Invalid credentials'),
        data: Matchers.any,
      );

      final ApiResult<AnnouncementLoginData> result = await helper.login(
        username: 'wrong',
        password: 'wrong',
      );

      expect(result, isA<ApiError<AnnouncementLoginData>>());
      final ApiError<AnnouncementLoginData> error =
          result as ApiError<AnnouncementLoginData>;
      expect(error.response.statusCode, 401);
    });

    test('returns ApiFailure on network error', () async {
      dioAdapter.onPost(
        '/login',
        (MockServer server) => server.throws(
          0,
          DioException(
            requestOptions: RequestOptions(path: '/login'),
            type: DioExceptionType.connectionTimeout,
          ),
        ),
        data: Matchers.any,
      );

      final ApiResult<AnnouncementLoginData> result = await helper.login(
        username: 'admin',
        password: 'pass',
      );

      expect(result, isA<ApiFailure<AnnouncementLoginData>>());
    });
  });

  group('googleLogin', () {
    test('returns ApiSuccess and sets loginType to google', () async {
      dioAdapter.onPost(
        '/oauth2/google/token',
        (MockServer server) => server.reply(200, _loginResponse),
        data: Matchers.any,
      );

      final ApiResult<AnnouncementLoginData> result =
          await helper.googleLogin(idToken: 'google_token');

      expect(result, isA<ApiSuccess<AnnouncementLoginData>>());
      expect(helper.loginType, AnnouncementLoginType.google);
      expect(helper.code, 'google_token');
    });
  });

  group('appleLogin', () {
    test('returns ApiSuccess and sets loginType to apple', () async {
      dioAdapter.onPost(
        '/oauth2/apple/token',
        (MockServer server) => server.reply(200, _loginResponse),
        data: Matchers.any,
      );

      final ApiResult<AnnouncementLoginData> result =
          await helper.appleLogin(idToken: 'apple_token');

      expect(result, isA<ApiSuccess<AnnouncementLoginData>>());
      expect(helper.loginType, AnnouncementLoginType.apple);
      expect(helper.code, 'apple_token');
    });
  });

  // ---------------------------------------------------------------------------
  // Announcements
  // ---------------------------------------------------------------------------

  group('getAllAnnouncements', () {
    test('returns sorted list on 200', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(200, _announcementListResponse),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiSuccess<List<Announcement>>>());
      final List<Announcement> data =
          (result as ApiSuccess<List<Announcement>>).data;
      expect(data.length, 2);
      // Sorted by weight descending
      expect(data[0].title, 'Announcement 2');
      expect(data[1].title, 'Announcement 1');
    });

    test('returns empty list on 204', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(204, null),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiSuccess<List<Announcement>>>());
      expect((result as ApiSuccess<List<Announcement>>).data, isEmpty);
    });

    test('returns ApiError on 403', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(403, 'Forbidden'),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiError<List<Announcement>>>());
      expect(
        (result as ApiError<List<Announcement>>).response.statusCode,
        403,
      );
    });

    test('returns ApiError on 404', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(404, 'Not Found'),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiError<List<Announcement>>>());
      expect(
        (result as ApiError<List<Announcement>>).response.statusCode,
        404,
      );
    });
  });

  group('getAnnouncements', () {
    test('posts with tags and locale', () async {
      dioAdapter.onPost(
        '/announcements',
        (MockServer server) => server.reply(200, _announcementListResponse),
        data: Matchers.any,
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAnnouncements(
        tags: <String>['nkust'],
        locale: 'en',
      );

      expect(result, isA<ApiSuccess<List<Announcement>>>());
      expect((result as ApiSuccess<List<Announcement>>).data.length, 2);
    });

    test('returns unsorted data when sorted is false', () async {
      dioAdapter.onPost(
        '/announcements',
        (MockServer server) => server.reply(200, _announcementListResponse),
        data: Matchers.any,
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAnnouncements(sorted: false);

      expect(result, isA<ApiSuccess<List<Announcement>>>());
      final List<Announcement> data =
          (result as ApiSuccess<List<Announcement>>).data;
      // Original order (not sorted by weight)
      expect(data[0].title, 'Announcement 1');
      expect(data[1].title, 'Announcement 2');
    });
  });

  group('getAnnouncement', () {
    test('returns single announcement by id', () async {
      dioAdapter.onGet(
        '/announcements/99',
        (MockServer server) => server.reply(200, _singleAnnouncementResponse),
      );

      final ApiResult<Announcement> result =
          await helper.getAnnouncement(id: 99);

      expect(result, isA<ApiSuccess<Announcement>>());
      final Announcement data = (result as ApiSuccess<Announcement>).data;
      expect(data.id, 99);
      expect(data.title, 'Single');
    });
  });

  group('addAnnouncement', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onPost(
        '/announcements/add',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result = await helper.addAnnouncement(
        data: const Announcement(
          title: 'New',
          weight: 1,
          imgUrl: 'https://img.png',
          description: 'desc',
          tags: <String>['tag1'],
        ),
      );

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });

    test('appends organization tag when set', () async {
      helper.organization = 'nkust';
      dioAdapter.onPost(
        '/announcements/add',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result = await helper.addAnnouncement(
        data: const Announcement(
          title: 'New',
          weight: 1,
          imgUrl: 'https://img.png',
          description: 'desc',
          tags: <String>[],
        ),
        languageCode: 'en',
      );

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  group('updateAnnouncement', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onPut(
        '/announcements/update/1',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result =
          await helper.updateAnnouncement(
        data: const Announcement(
          title: 'Updated',
          id: 1,
          weight: 1,
          imgUrl: 'https://img.png',
          description: 'updated desc',
        ),
      );

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  group('deleteAnnouncement', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onDelete(
        '/announcements/delete/1',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result =
          await helper.deleteAnnouncement(
        data: const Announcement(
          title: 'Delete me',
          id: 1,
          weight: 1,
          imgUrl: '',
          description: '',
        ),
      );

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  // ---------------------------------------------------------------------------
  // Applications
  // ---------------------------------------------------------------------------

  group('getApplications', () {
    test('returns sorted list on 200', () async {
      dioAdapter.onGet(
        '/application',
        (MockServer server) => server.reply(200, _announcementListResponse),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getApplications();

      expect(result, isA<ApiSuccess<List<Announcement>>>());
      expect((result as ApiSuccess<List<Announcement>>).data.length, 2);
    });

    test('returns empty list on 204', () async {
      dioAdapter.onGet(
        '/application',
        (MockServer server) => server.reply(204, null),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getApplications();

      expect(result, isA<ApiSuccess<List<Announcement>>>());
      expect((result as ApiSuccess<List<Announcement>>).data, isEmpty);
    });
  });

  group('approveApplication', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onPut(
        '/application/app-1/approve',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result =
          await helper.approveApplication(
        applicationId: 'app-1',
        reviewDescription: 'Looks good',
      );

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  group('rejectApplication', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onPut(
        '/application/app-1/reject',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result =
          await helper.rejectApplication(
        applicationId: 'app-1',
        reviewDescription: 'Not appropriate',
      );

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  group('removeApplication', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onDelete(
        '/application/app-1',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
      );

      final ApiResult<Response<dynamic>> result =
          await helper.removeApplication(applicationId: 'app-1');

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  // ---------------------------------------------------------------------------
  // Blacklist
  // ---------------------------------------------------------------------------

  group('getBlackList', () {
    test('returns list of usernames', () async {
      // getBlackList uses dio.get<String> then jsonDecode,
      // so the mock must return a raw JSON string.
      dioAdapter.onGet(
        '/ban',
        (MockServer server) => server.reply(
          200,
          '["user1","user2"]',
          headers: <String, List<String>>{
            'content-type': <String>['text/plain'],
          },
        ),
      );

      final ApiResult<List<String>> result = await helper.getBlackList();

      expect(result, isA<ApiSuccess<List<String>>>());
      expect(
        (result as ApiSuccess<List<String>>).data,
        <String>['user1', 'user2'],
      );
    });
  });

  group('addBlackList', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onPut(
        '/ban/',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result =
          await helper.addBlackList(username: 'baduser');

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  group('removeFromBlackList', () {
    test('returns ApiSuccess on 200', () async {
      dioAdapter.onDelete(
        '/ban/',
        (MockServer server) =>
            server.reply(200, <String, dynamic>{'message': 'ok'}),
        data: Matchers.any,
      );

      final ApiResult<Response<dynamic>> result =
          await helper.removeFromBlackList(username: 'baduser');

      expect(result, isA<ApiSuccess<Response<dynamic>>>());
    });
  });

  // ---------------------------------------------------------------------------
  // Error handling (_execute)
  // ---------------------------------------------------------------------------

  group('_execute error mapping', () {
    test('401 maps to ApiError with tokenExpire status', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(401, 'Unauthorized'),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiError<List<Announcement>>>());
      expect(
        (result as ApiError<List<Announcement>>).response.statusCode,
        AnnouncementHelper.tokenExpire,
      );
    });

    test('403 maps to ApiError with notPermission status', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(403, 'Forbidden'),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiError<List<Announcement>>>());
      expect(
        (result as ApiError<List<Announcement>>).response.statusCode,
        AnnouncementHelper.notPermission,
      );
    });

    test('404 maps to ApiError with notFoundData status', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(404, 'Not Found'),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiError<List<Announcement>>>());
      expect(
        (result as ApiError<List<Announcement>>).response.statusCode,
        AnnouncementHelper.notFoundData,
      );
    });

    test('500 maps to ApiFailure', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.reply(500, 'Internal Server Error'),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiFailure<List<Announcement>>>());
    });

    test('connection timeout maps to ApiFailure', () async {
      dioAdapter.onGet(
        '/announcements',
        (MockServer server) => server.throws(
          0,
          DioException(
            requestOptions: RequestOptions(path: '/announcements'),
            type: DioExceptionType.connectionTimeout,
          ),
        ),
      );

      final ApiResult<List<Announcement>> result =
          await helper.getAllAnnouncements();

      expect(result, isA<ApiFailure<List<Announcement>>>());
      expect(
        (result as ApiFailure<List<Announcement>>).exception.type,
        DioExceptionType.connectionTimeout,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Utilities
  // ---------------------------------------------------------------------------

  group('utilities', () {
    test('setAuthorization sets Bearer token header', () {
      helper.setAuthorization('my-token');

      expect(
        helper.dio.options.headers['Authorization'],
        'Bearer my-token',
      );
    });

    test('clearSetting nullifies username and password', () {
      helper.username = 'user';
      helper.password = 'pass';

      helper.clearSetting();

      expect(helper.username, isNull);
      expect(helper.password, isNull);
    });

    test('reInstance creates new instance with updated host and tag', () {
      AnnouncementHelper.reInstance(host: 'new.host.com', tag: 'new_tag');

      expect(AnnouncementHelper.host, 'new.host.com');
      expect(AnnouncementHelper.tag, 'new_tag');
      expect(
        AnnouncementHelper.instance.dio.options.baseUrl,
        'https://new.host.com/new_tag',
      );

      // Reset for other tests
      AnnouncementHelper.reInstance(host: 'nkust.taki.dog', tag: 'ap');
    });
  });
}
