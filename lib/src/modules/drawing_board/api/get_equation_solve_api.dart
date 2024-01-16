import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/constants/constants.dart';
import '../../../utils/logger/logger_helper.dart';
import '../models/solve_result.dart';

Future<bool> checkConnection() async {
  try {
    var request = http.Request('GET', Uri.parse('$baseLink/'));
    request.body = '''''';
    http.StreamedResponse response = await request.send();

    var body = await response.stream.bytesToString();
    log.i('>>> Check connection API response: $body');
    SolveResult solveResult = solveResultFromJson(body);

    return solveResult.success;
  } on SocketException catch (_) {
    return false;
  } catch (_) {
    return false;
  }
}

final baseUrl = defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS
    ? 'http://10.0.2.2:8000'
    : 'http://127.0.0.1:8000';

Future<SolveResult> getEquationSolveApi(String img) async {
  try {
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl/predict'));
    request.body = json.encode({"img": img});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var body = await response.stream.bytesToString();
    log.i('>>> Equation solve API response: $body');
    SolveResult solveResult = solveResultFromJson(body);

    if (solveResult.success) {
      EasyLoading.dismiss();
      return solveResult;
    } else {
      EasyLoading.showError(solveResult.message);
      return solveResult;
    }
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return SolveResult(success: false, message: 'No Internet Connection');
  } catch (e) {
    EasyLoading.showError('Api Error: $e');
    return SolveResult(success: false, message: 'Api Error');
  }
}
