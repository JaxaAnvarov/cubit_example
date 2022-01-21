import 'package:flutter/foundation.dart';

abstract class CatsState {
  const CatsState();
}

class CatsInitial extends CatsState {
  const CatsInitial();
}

class CatsLoading extends CatsState {
  const CatsLoading();
}

class CatsCompledet extends CatsState {
  final List<String> response;

  const CatsCompledet(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CatsCompledet && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class CatsError extends CatsState {
  final String errorMessage;

  const CatsError(this.errorMessage);
}
