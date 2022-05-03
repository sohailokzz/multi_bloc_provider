import 'package:bloc_multi_provider/bloc/app_state.dart';
import 'package:bloc_multi_provider/bloc/bloc_events.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();
  AppBloc({
    required Iterable<String> urls,
    Duration? waitingBeforeLoading,
    AppBlocRandomUrlPicker? urlPicker,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoadNextUrlEvent>(
      (event, emit) async {
        //start loading
        emit(
          const AppState(
            isLoading: true,
            data: null,
            error: null,
          ),
        );
        final url = (urlPicker ?? _pickRandomUrl)(urls);
        try {
          if (waitingBeforeLoading != null) {
            await Future.delayed(waitingBeforeLoading);
          }
          final bundle = NetworkAssetBundle(Uri.parse(url));
          final data = (await bundle.load(url)).buffer.asUint8List();
          emit(
            AppState(
              isLoading: false,
              data: data,
              error: null,
            ),
          );
        } catch (e) {
          emit(
            AppState(
              isLoading: true,
              data: null,
              error: e,
            ),
          );
        }
      },
    );
  }
}
