part of 'swiper_bloc.dart';

class SwiperEvent {}

class RecordStartPosition extends SwiperEvent {
  RecordStartPosition({required this.val});

  final double val;
}

class RecordUpdate extends SwiperEvent {
  RecordUpdate({required this.val});
  final double val;
}

class SwipeEnd extends SwiperEvent {
  SwipeEnd({required this.callback});

  final FutureOr<void> Function() callback;
}
