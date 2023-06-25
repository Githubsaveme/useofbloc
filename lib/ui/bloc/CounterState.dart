///state Class
class CounterState {
  final int count;
  final bool productSuccess;
  final bool loginError;
  final bool rememberMe;

  CounterState({
    this.productSuccess = false,
    this.loginError = false,
    this.count = 0,
    this.rememberMe = false,
  });

  CounterState copyWith({
    bool? productSuccess,
    bool? loginError,
    bool? rememberMe,
  }) {
    return CounterState(
      productSuccess: productSuccess ?? this.productSuccess,
      loginError: loginError ?? this.loginError,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
