import 'package:dio/dio.dart';

export 'package:dio/dio.dart';

class DioClient {
  static init() {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        handler.next(error);
      },
    ));
  }

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://staging-api.astrotak.com/api',
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4ODA5NzY1MTkxIiwiUm9sZXMiOltdLCJleHAiOjE2NzY0NjE0NzEsImlhdCI6MTY0NDkyNTQ3MX0.EVAhZLNeuKd7e7BstsGW5lYEtggbSfLD_aKqGFLpidgL7UHZTBues0MUQR8sqMD1267V4Y_VheBHpxwKWKA3lQ',
      },
    ),
  );
}

mixin NetworkClient {
  Dio client = DioClient.dio;
}
