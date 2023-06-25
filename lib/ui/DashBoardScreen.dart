import 'package:bloc_screen/ui/bloc/CounterState.dart';
import 'package:bloc_screen/ui/bloc/counterCubit.dart';
import 'package:bloc_screen/ui/bloc/counterCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          debugPrint(
              "sdsdsds${context.read<CounterCubit>().productModalList.length}");
          Text("${context.read<CounterCubit>().productModalList.length}");
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Screen'),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: context.read<CounterCubit>().productModalList.length,
                itemBuilder: (cxt, index) {
                  debugPrint(
                      "length:-${context.read<CounterCubit>().productModalList.length}");
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.width * 0.02,
                        horizontal: size.width * 0.02),
                    child: const Text('Title'),
                  );
                }),
          );
        },
      ),
    );
  }
}
