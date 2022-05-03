import 'package:bloc_multi_provider/bloc/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({
    Duration? waitingBeforLoading,
    required Iterable<String> urls,
  }) : super(
          waitingBeforeLoading: waitingBeforLoading,
          urls: urls,
        );
}
