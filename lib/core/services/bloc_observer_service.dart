import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserverService extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      log('📥 Event: $event', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      log('🔄 Change: $change', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      log('➡️ Transition: $transition', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log(
        '❌ Error: $error',
        name: bloc.runtimeType.toString(),
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }
}
