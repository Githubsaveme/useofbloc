import 'dart:convert';

import 'package:bloc_screen/network/NetworkResponse.dart';
import 'package:bloc_screen/ui/bloc/CounterState.dart';
import 'package:bloc_screen/ui/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///cubit Class
class CounterCubit extends Cubit<CounterState> implements NetworkResponse {
  CounterCubit() : super(CounterState());

  bool isEnable = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<ProductModal> productModalList = [];

  void increment() {
    final count = state.count + 1;
    final updateValue = CounterState(count: count);
    emit(updateValue);
  }

  void decrement() {
    final count = state.count - 1;
    final updateValue = CounterState(count: count);
    emit(updateValue);
  }

  enable() {
    isEnable = !isEnable;
  }

  commonButton(String title, Function onTapButton) {
    return ElevatedButton(
        onPressed: () {
          onTapButton();
        },
        child: Text(title));
  }

  void onTapShowList() {
    callGetList();
  }

  void getProductList(){
    productModalList;
}

  callGetList() {
    HttpService.fromNetworkClass(
        url: "https://dummyjson.com/products",
        networkResponse: this,
        requestCode: reqGetProductApi,
        jsonBody: {}).callRequestServiceHeader(true, false, 'get', {});
  }

  @override
  void onErrorResponse(
      {Key? key, required int requestCode, required String response}) {
    switch (requestCode) {
      case reqGetProductApi:
        var data = jsonDecode(response);
        debugPrint(data.toString());
        emit(state.copyWith(productSuccess: false));
    }
  }

  @override
  void onSuccessResponse(
      {Key? key, required int requestCode, required String response}) {
    switch (requestCode) {
      case reqGetProductApi:
        var data = jsonDecode(response);
        debugPrint(data.toString());
        productModalList.clear();
        var dataModal = data['products'];
        for (var e in dataModal) {
          debugPrint(e['title']);
          productModalList.add(ProductModal(
              title: e['title'].toString(),
              price: e['price'].toString(),
              description: e['description'].toString(),
              brand: e['brand'].toString(),
              image: e['thumbnail'].toString(),
              category: e['category'].toString()));
        }
        debugPrint(productModalList.length.toString());
        emit(state.copyWith(productSuccess: true));
    }
  }
}

///Api
const getProductApi = 'products';
const reqGetProductApi = 1;
