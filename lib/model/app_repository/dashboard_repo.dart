import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../view/export_view.dart';

import '../app_models/travel_details_model.dart';
import '../app_models/travel_model.dart';
import '../export_model.dart';

class DashBoardRepository {
  final UserRequest _userRequest = UserRequest();
  EitherFunction<List<Travel>> travel() async {
    try {
      final response = await _userRequest.travel();
      List<dynamic> jsonData = response.data;
      List<Travel> travelList =
          jsonData.map((item) => Travel.fromJson(item)).toList();
      return right(travelList);
    } on DioException catch (e) {
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      return left(e.toString());
    } catch (e) {
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

EitherFunction<List<TravelDetail>> travelDetails() async {
    try {
      final response = await _userRequest.traveldetail();

      // Check if the response data is a list or a single object
      List<dynamic> jsonData =
          response.data; // Assuming response.data is decoded
      List<TravelDetail> travelDetailsList =
          jsonData.map((item) => TravelDetail.fromJson(item)).toList();

      return right(travelDetailsList);
    } on DioException catch (e) {
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      return left(e.toString());
    } catch (e) {
      showBotToast(text: "$e", isError: true);
      print("$e");
      return left(e.toString());
    }
  }
  EitherFunction<bool> posttravelDetails({
    required dynamic datas,
  }) async {
    loading();
    try {
      await _userRequest.posttravelDetails(
        datas: datas,
      );
      BotToast.closeAllLoading();
      showBotToast(text: "profile updated ");
      return right(true);
    } on DioException catch (e) {
      print(e);
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      BotToast.closeAllLoading();

      return left(e.toString());
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<bool> posttravetravel({
    required dynamic datas,
  }) async {
    loading();
    try {
      await _userRequest.posttravetravel(
        datas: datas,
      );
      BotToast.closeAllLoading();
      showBotToast(text: "profile updated ");
      return right(true);
    } on DioException catch (e) {
      print(e);
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      BotToast.closeAllLoading();

      return left(e.toString());
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }
}
