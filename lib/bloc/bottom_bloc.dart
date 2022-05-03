import 'package:bloc_multi_provider/bloc/app_bloc.dart';

class BottomBloc extends AppBloc {
  BottomBloc({
    Duration? waitingBeforLoading,
    required Iterable<String> urls,
  }) : super(
          waitingBeforeLoading: waitingBeforLoading,
          urls: urls,
        );
}
