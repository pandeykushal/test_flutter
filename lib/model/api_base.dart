import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:np_com_pandeykushal/model/api_endpoints.dart';
import 'package:np_com_pandeykushal/view/components/custom_bottoast.dart';
import 'package:np_com_pandeykushal/view/screens/error_page.dart';
import 'package:np_com_pandeykushal/view/screens/on_boarding_screen.dart';
import 'package:np_com_pandeykushal/view_model/config/routes.dart';
import 'package:np_com_pandeykushal/view_model/config/storage.dart';
import 'package:np_com_pandeykushal/view_model/utils/constant.dart';
import 'package:np_com_pandeykushal/view_model/utils/logs.dart';

typedef EitherFunction<T> = Future<Either<String, T>>;

class ApiBase {
  static final _dio = Dio(BaseOptions(baseUrl: AppEndpoint.baseUrl));

  var headerRequests = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static Future<void> _dioInterceptor() async {
    debugPrint("dddd");
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          CustomLog.error(e.toString());

          try {
            if (e.response?.statusCode == 404 ||
                e.response?.statusCode == 401) {
              GoRouteNavigation().goRouter.push(OnBoardingScreen.routeName);
              showBotToast(text: "${e.response?.statusMessage}", isError: true);
            } else if (e.response?.statusCode == 417) {
              GoRouteNavigation().goRouter.push(CustomErrorPage.routeName,
                  extra: const FlutterErrorDetails(
                      exception: "Forbidden !! \n Permission not given "));
            } else if (e.response?.statusCode == 500) {
              GoRouteNavigation().goRouter.push(CustomErrorPage.routeName,
                  extra: const FlutterErrorDetails(exception: "Server Error"));
            }
          } catch (ew) {
            CustomLog.error(e.toString());
            handler.reject(e);
          }
        },
      ),
    );
  }

  Future<Response> getRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    debugPrint("geeettttttttt inside heree");
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();

    print(headerRequests);

    var response = await _dio.get(
      path,
      options: Options(
        headers: headerRequests,
      ),
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> getRequestWithoutToken({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    debugPrint("geeettttttttt");

    var response = await _dio.get(path, queryParameters: queryParameters);
    return response;
  }

  Future<Response> postRequestWithToken({
    required String path,
    required dynamic data,
  }) async {
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] =
        "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMxMDc2NTI3LCJpYXQiOjE3MzEwNzI5MjcsImp0aSI6IjJlODNjYjBmM2NiNTQyYWJhMTgwZTBhY2E5NDVkN2Q0IiwidXNlcl9pZCI6Nn0.1GyYTP5e4KB6Ks8Ki8EzutD6TGS_oEa6YAUIps2eY2o";

    await _dioInterceptor();
    debugPrint("after interpreting");
    var response = await _dio.post(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    print(headerRequests);
    return response;
  }

  Future<Response> deleteWithToken({
    required String path,
    required dynamic data,
  }) async {
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();
    debugPrint("after interpreting");
    var response = await _dio.delete(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    return response;
  }

  Future<Response> postRequestWithoutToken({
    required String path,
    required dynamic data,
  }) async {
    var response = await _dio.post(
      path,
      data: data,
    );

    debugPrint("\n$response");
    return response;
  }

  Future<Response> patchRequest({
    required String path,
    required dynamic data,
  }) async {
    print("Patchhh");
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();
    debugPrint("after interpreting");
    var response = await _dio.patch(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    return response;
  }
}
