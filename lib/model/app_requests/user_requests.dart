import 'dart:developer';

import 'package:dio/dio.dart';
import '../export_model.dart';

class UserRequest extends ApiBase {
  Future<Response> travel() async {
    final response = await getRequestWithoutToken(
      path: AppEndpoint.travel,
    );
    log(response.toString());
    return response;
  }

  Future<Response> traveldetail() async {
    final response = await getRequestWithoutToken(
      path: AppEndpoint.travelDetail,
    );
    log(response.toString());
    return response;
  }

  Future<Response> posttravelDetails({
    required dynamic datas,
  }) async {
    final response = await postRequestWithToken(
      path: AppEndpoint.travelDetail,
      data: datas,
    );
    log(response.toString());
    return response;
  }

  Future<Response> posttravetravel({
    required dynamic datas,
  }) async {
    final response = await postRequestWithToken(
      path: AppEndpoint.travel,
      data: datas,
    );
    log(response.toString());
    return response;
  }
}
