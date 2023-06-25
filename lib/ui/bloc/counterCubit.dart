import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState());

  bool isEnable = false;

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
}

class CounterState {
  final int count;

  CounterState({
    this.count = 0,
  });
}
