import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to_complete/bloc/swiper_bloc.dart';

class NewSwiper extends StatefulWidget {
  const NewSwiper({
    super.key,
    this.type = SwiperType.horizontal,
    required this.callback,
  });

  /// Defines which [SwiperType] the widget will render
  final SwiperType type;

  /// User can define a custom callback when the swipe action is completed
  final FutureOr<void> Function() callback;

  @override
  State<NewSwiper> createState() => _NewSwiperState();
}

class _NewSwiperState extends State<NewSwiper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwiperBloc(),
      child: Builder(builder: (context) {
        return Stack(
          children: [
            Container(
              height: widget.type == SwiperType.horizontal ? 85 : 255,
              width: widget.type == SwiperType.horizontal ? 255 : 85,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
            ),
            if (widget.type == SwiperType.horizontal)
              const Positioned.fill(
                child: Center(
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            Positioned(
              top: widget.type == SwiperType.horizontal ? 8 : 85,
              right: widget.type == SwiperType.horizontal ? 8 : -22,
              child: SizedBox(
                height: 75,
                width: 75,
                child: _AnimatingArrows(type: widget.type),
              ),
            ),
            if (widget.type == SwiperType.vertical)
              Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            BlocBuilder<SwiperBloc, SwiperState>(
              builder: (context, state) {
                return GestureDetector(
                  onPanStart: (details) {
                    context.read<SwiperBloc>().add(
                          RecordStartPosition(
                            val: widget.type == SwiperType.horizontal
                                ? details.globalPosition.dx
                                : details.globalPosition.dy,
                          ),
                        );
                  },
                  onPanUpdate: (details) {
                    context.read<SwiperBloc>().add(
                          RecordUpdate(
                            val: widget.type == SwiperType.horizontal
                                ? details.delta.dx
                                : details.delta.dy,
                          ),
                        );
                  },
                  onPanEnd: (details) {
                    context.read<SwiperBloc>().add(
                          SwipeEnd(
                            callback: widget.callback,
                          ),
                        );
                  },
                  child: Transform.translate(
                    offset: Offset(
                      widget.type == SwiperType.horizontal
                          ? state.current + 5
                          : 5,
                      widget.type == SwiperType.vertical
                          ? state.current + 5
                          : 5,
                    ),
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          widget.type == SwiperType.horizontal
                              ? Icons.arrow_forward
                              : Icons.arrow_downward,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}

///This enum is used to define which type of swiper widget
///you want the package to return.
///
///The [horizontal] and [vertical] here correspond to the direction of swiping axis
enum SwiperType {
  horizontal,
  vertical;
}

class _AnimatingArrows extends StatefulWidget {
  const _AnimatingArrows({required this.type});
  final SwiperType type;
  @override
  State<_AnimatingArrows> createState() => __AnimatingArrowsState();
}

class __AnimatingArrowsState extends State<_AnimatingArrows>
    with TickerProviderStateMixin {
  late AnimationController _controllerOne;
  late AnimationController _controllerTwo;

  late Animation<double> _xOne;
  late CurvedAnimation _xOneCurved;
  late Animation<double> _opacityOne;

  late Animation<double> _xTwo;
  late CurvedAnimation _xTwoCurved;
  late Animation<double> _opacityTwo;

  @override
  void initState() {
    super.initState();
    _controllerOne = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _controllerTwo = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    _xOneCurved =
        CurvedAnimation(parent: _controllerOne, curve: Curves.easeInOutQuart);
    _xOne = Tween<double>(begin: 0, end: 30).animate(_xOneCurved);
    _opacityOne = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 3),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 1),
    ]).animate(_controllerOne);

    _xTwoCurved =
        CurvedAnimation(parent: _controllerTwo, curve: Curves.easeInOutQuart);
    _xTwo = Tween<double>(begin: 0, end: 30).animate(_xTwoCurved);
    _opacityTwo = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 3),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 1),
    ]).animate(_controllerTwo);

    initiateAnimation();
  }

  @override
  void dispose() {
    _controllerOne.dispose();
    _controllerTwo.dispose();
    super.dispose();
  }

  Future<void> initiateAnimation() async {
    _controllerOne.repeat();
    await Future.delayed(const Duration(milliseconds: 800));
    _controllerTwo.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 26,
          child: AnimatedBuilder(
            animation: _controllerOne,
            builder: (context, child) => Transform.translate(
              offset: Offset(
                  widget.type == SwiperType.horizontal ? _xOne.value : 0,
                  widget.type == SwiperType.vertical ? _xOne.value : 0),
              child: Transform.rotate(
                angle: widget.type == SwiperType.horizontal ? 0 : math.pi / 2,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.white.withOpacity(_opacityOne.value),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 26,
          child: AnimatedBuilder(
            animation: _controllerTwo,
            builder: (context, child) => Transform.translate(
              offset: Offset(
                  widget.type == SwiperType.horizontal ? _xTwo.value : 0,
                  widget.type == SwiperType.vertical ? _xTwo.value : 0),
              child: Transform.rotate(
                angle: widget.type == SwiperType.horizontal ? 0 : math.pi / 2,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.white.withOpacity(_opacityTwo.value),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
