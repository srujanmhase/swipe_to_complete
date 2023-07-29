## Swipe to complete

A flutter package that helps you easily implement a swipe to confirm action in your app. It has two variations: horizontal and vertical. This determines which direction the user has to drag the action button to trigger the callback.

## Demo

[![Video](https://img.youtube.com/vi/x3aRAE2X2mc/maxresdefault.jpg)](https://www.youtube.com/watch?v=x3aRAE2X2mc)

## Getting Started

Determine which type you want to use:

```
enum SwiperType {
  horizontal,
  vertical;
}
```
Simply use the widget:

```
NewSwiper({
  Key? key,
  SwiperType type = SwiperType.horizontal,
  required FutureOr<void> Function() callback,
})
```
