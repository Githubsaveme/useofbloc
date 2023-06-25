import 'dart:convert';

import 'package:bloc_screen/ui/DashBoardScreen.dart';
import 'package:bloc_screen/ui/bloc/CounterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'bloc/counterCubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Use of Bloc/Cubit"),
          centerTitle: true,
        ),
        body: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.productSuccess) {}
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 0.02, horizontal: size.width * 0.02),
              child: Column(
                children: [
                  const Text("Counter"),
                  SizedBox(
                    height: size.width * 0.02,
                  ),
                  Text("${state.count}"),
                  Text(
                      "${context.read<CounterCubit>().productModalList.length}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      context.read<CounterCubit>().commonButton("+", () {
                        context.read<CounterCubit>().increment();
                      }),
                      context.read<CounterCubit>().commonButton("-", () {
                        context.read<CounterCubit>().decrement();
                      })
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.02,
                  ),
                  context.read<CounterCubit>().commonButton("Next Page", () {
                    context.read<CounterCubit>().callGetList();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (cxt) => const DashBoardScreen()));
                  }),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          context.read<CounterCubit>().productModalList.length,
                      itemBuilder: (cxt, index) {
                        debugPrint(
                            "length:-${context.read<CounterCubit>().productModalList.length}");
                        var item = context
                            .read<CounterCubit>()
                            .productModalList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.width * 0.02,
                              horizontal: size.width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item.title),
                              Text(item.price),
                              Text(item.description),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }

  Widget loginScreen(size) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              fillColor: Colors.red,
              hintText: "Email",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: size.width * 0.002, color: Colors.red))),
        ),
        SizedBox(
          height: size.width * 0.02,
        ),
        TextFormField(
          decoration: InputDecoration(
              fillColor: Colors.red,
              hintText: "Password",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: size.width * 0.002, color: Colors.red))),
        ),
      ],
    );
  }
}

class ProductModal {
  String title = "";
  String description = "";
  String price = "";
  String brand = "";
  String category = "";
  String image = "";

  ProductModal(
      {required this.title,
      required this.price,
      required this.description,
      required this.brand,
      required this.image,
      required this.category});
}
