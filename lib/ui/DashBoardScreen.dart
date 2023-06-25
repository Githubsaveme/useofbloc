import 'dart:io';

import 'package:bloc_screen/network/NetworkResponse.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Screen'),
      ),
      body: productListWidget(size),
    );
  }

  Widget productListWidget(size) {
    return ListView.builder(
        itemCount: httpService.postsURL.length,
        itemBuilder: (cxt, index) {
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: size.width * 0.02, horizontal: size.width * 0.02),
            child: const Text('Title'),
          );
        });
  }
}
