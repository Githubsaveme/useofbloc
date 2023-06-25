import 'package:bloc_screen/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class NetworkResponse {
  void onSuccessResponse(
      {Key? key, required int requestCode, required String response}) {}

  void onErrorResponse(
      {Key? key, required int requestCode, required String response}) {}
}

const baseUrl = '';
String userTokenKey = '';
const headerKey = 'Authorization';

class HttpService {
  String url = "";
  NetworkResponse? networkResponse;
  int requestCode = 0;
  AlertDialog? alertDialog;
  Map<String, String>? jsonBody;
  Map<String, dynamic>? jsonBodyRow;
  bool isShowing = false;
  String filePath = "";
  String imagePath1 = "";
  String imagePath2 = "";
  String paramName = "";
  String paramName1 = "";
  String paramName2 = "";
  List<String> imageList1 = [];
  Map<String, dynamic> imageDataList = {};

  HttpService.fromNetworkClass(
      {required this.url,
      required this.networkResponse,
      required this.requestCode,
      required this.jsonBody});

  Future<void> callRequestServiceHeader(bool showLoader, bool tokenRequired,
      String requestType, Map<String, String>? queryParameters) async {
    Uri uri;

    if (queryParameters != null) {
      debugPrint("queryParams: $queryParameters");
      uri = Uri.parse(url).replace(queryParameters: queryParameters);
    } else {
      uri = Uri.parse(url);
    }

    debugPrint("RequestUrl: $uri");
    debugPrint("Token: $tokenRequired");

    var request = http.Request(requestType, uri);
    if (tokenRequired) {
      request.headers
          .addAll({headerKey: sharedPreferences.getString(userTokenKey)!});
      debugPrint("HeadersAre: ${request.headers}");
    }

    if (requestType != "get") {
      if (jsonBody != null) {
        request.bodyFields = jsonBody!;
      }
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      debugPrint("BodyIs: ${response.body.toString()}");
      debugPrint("statusCode: ${response.statusCode.toString()}");

      if (response.statusCode <= 201) {
        if (showLoader) {
          if (alertDialog != null && isShowing) {
            isShowing = false;
            Navigator.pop(navigatorKey.currentContext!);
          }
        }

        networkResponse!.onSuccessResponse(
            requestCode: requestCode, response: response.body.toString());
      } else {
        if (alertDialog != null && isShowing) {
          isShowing = false;
          Navigator.pop(navigatorKey.currentContext!);
        }

        networkResponse!.onErrorResponse(
            requestCode: requestCode, response: response.body.toString());
      }
    } on Exception catch (e) {
      debugPrint("Post :: Unable to connect to server! $e");
      networkResponse!
          .onErrorResponse(requestCode: requestCode, response: e.toString());
      if (alertDialog != null && isShowing) {
        isShowing = false;
        Navigator.pop(navigatorKey.currentContext!);
      }
      showToast(
          message: "Server Error! $e!", context: navigatorKey.currentContext!);
    }
  }

  void showLoaderDialog(BuildContext context) {
    if (alertDialog != null) {
      isShowing = false;
      Navigator.pop(context);
    }

    alertDialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.all(0),
      buttonPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: CircularProgressIndicator(
              // color: blueButtonColor,
              strokeWidth: 3.5,
            ),
          )),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog!;
      },
    );
  }

  void showToast({required String message, required BuildContext context}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 7,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 13.0,
    );
  }
}
