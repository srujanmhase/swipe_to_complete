import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'swiper_event.dart';
part 'swiper_state.dart';

class SwiperBloc extends Bloc<SwiperEvent, SwiperState> {
  SwiperBloc() : super(SwiperState(current: 0, start: 0)) {
    on<RecordStartPosition>((event, emit) {
      return emit(SwiperState(current: state.current, start: event.val));
    });
    on<RecordUpdate>((event, emit) {
      if ((state.start + state.current + event.val) < state.start ||
          (state.start + state.current + event.val) >= (state.start + 170)) {
        return;
      }

      return emit(
        SwiperState(current: state.current + event.val, start: state.start),
      );
    });
    on<SwipeEnd>((event, emit) {
      if ((state.start + state.current) >= (state.start + 165)) {
        event.callback();
      }

      return emit(SwiperState(current: 0, start: 0));
    });
  }
}
