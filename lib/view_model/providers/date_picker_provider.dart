import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:np_com_pandeykushal/view_model/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import '../../model/app_models/travel_details_model.dart';
import '../../model/app_models/travel_model.dart';
import '../../model/export_model.dart';
import '../../view/export_view.dart';
import '../utils/export_utils.dart';

class DatePickerProvider extends ChangeNotifier {
  // int? daysDifference;
  DateTime? currentDateTime = DateTime.now();

  DashBoardRepository _dashRepo = DashBoardRepository();

  void changeDate(DateTime dateTime) {
    currentDateTime = dateTime;
    notifyListeners();
  }

  Future<DateTime> mainPicker(
    context, {
    bool isAppointment = false,
    DateTime? pickDateTime,
    bool pickDate = true,
    showPreviousDate = false,
  }) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: pickDate ? DateTime.now() : pickDateTime ?? DateTime.now(),
        firstDate: showPreviousDate
            ? DateTime(DateTime.now().year - 100)
            : DateTime.now(),
        lastDate: isAppointment
            ? DateTime(2100)
            : (pickDate ? DateTime.now() : pickDateTime ?? DateTime.now()),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: AppColor.primary),
            ),
            child: child!),
        initialEntryMode: DatePickerEntryMode.calendar);

    return pickedDate ?? DateTime.now();
  }

  int calculateTimeDifference({required DateTime futurePickedDate}) {
    DateTime currentDate = DateTime.now();
    DateTime futureDate = futurePickedDate;
    Duration difference = futureDate.difference(currentDate);

    int daysDifference = difference.inDays;
    notifyListeners();
    return daysDifference;
  }

  File? profilePic;
  File? defaultFile;
  String? prefileProfile;

  Future<File?> pickFiles(
      {String? fileType, bool allowMultiple = false}) async {
    final pickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      allowedExtensions: ['png', 'jpg'],
      type: FileType.custom,
      withReadStream: true,
    );

    if (pickerResult != null) {
      const maxSizeInBytes = 2 * 1024 * 1024;
      if (pickerResult.files.any((element) => element.size > maxSizeInBytes)) {
        showBotToast(
            text: "Selected file size exceeds 2 MB Limit", isError: true);
        return null;
      }

      switch (fileType) {
        case AppConstant.profilePic1:
          profilePic = File(pickerResult.paths.first!);
          break;
        // case AppConstant.councilCertificate:
        //   // councilCertificateFile = File(pickerResult.paths.first!);
        //   councilCertificateFileList = pickerResult.paths;
        //   break;
        // case AppConstant.characterCertificate:
        //   characterCertificateFile = File(pickerResult.paths.first!);
        //   break;
        // case AppConstant.collegeCard:
        //   collegeCard = File(pickerResult.paths.first!);
        // break;
        default:
          defaultFile = File(pickerResult.paths.first!);
      }
      notifyListeners();
    } else {
      showBotToast(text: "Error during picking ", isError: true);
      return null;
    }

    log("${defaultFile?.path}");

    return defaultFile;
  }

  TextEditingController travelname = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController travelAgenda = TextEditingController();

  TextEditingController traveldetailsagenda = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController traveldetaildescription = TextEditingController();
  clerEverything() {
    defaultFile = null;
    profilePic = null;
    travelname.clear();
    description.clear();
    travelAgenda.clear();
  }

  List<Travel>? travelList;
  Travel? travel;
  String? erroroftest;
  Future<void> fetchTravels() async {
    final response = await _dashRepo.travel();
    response.fold(
      (l) {
        erroroftest = l;
        travelList = null;
      },
      (r) {
        travelList = r;
        erroroftest = null;
      },
    );

    notifyListeners();
  }

  List<TravelDetail>? travelDetailsList;

  Future<void> fetchTravelDetails() async {
    final response = await _dashRepo.travelDetails();

    response.fold(
      (l) {
        erroroftest = l;
        travelDetailsList = null;
      },
      (r) {
        travelDetailsList = r;
        erroroftest = null;
      },
    );

    notifyListeners();
  }

  bool? isform;
  Future<bool> posttravelDetails({
    required dynamic datas,
  }) async {
    final response = await _dashRepo.posttravelDetails(
      datas: datas,
    );

    response.fold((l) => erroroftest = l, (r) => isform = r);

    if (isform != null) {
      return isform!;
    } else {
      return false;
    }
  }

  Future<bool> posttravetravel({
    required dynamic datas,
  }) async {
    final response = await _dashRepo.posttravetravel(
      datas: datas,
    );

    response.fold((l) => erroroftest = l, (r) => isform = r);

    if (isform != null) {
      return isform!;
    } else {
      return false;
    }
  }
}
