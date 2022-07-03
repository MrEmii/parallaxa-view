import 'dart:developer';

import 'dart:ui';

import 'package:flutter/material.dart';

class Parallax extends StatefulWidget {
  const Parallax({
    Key? key,
    required this.x,
    required this.y,
    required this.z,
  }) : super(key: key);

  final double x;
  final double y;
  final double z;

  @override
  State<Parallax> createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final x = widget.x;
    final y = widget.y;

    log('$x, $y');

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: ShadowImage(x: x, y: y),
          ),
          Center(
            child: Image(x: x, y: y),
          )
        ],
      ),
    );
  }
}

class Image extends StatefulWidget {
  const Image({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  final double x;
  final double y;

  @override
  State<Image> createState() => _ImageState();
}

class _ImageState extends State<Image> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translate(-(widget.x * 3), (widget.y * 3)),
      alignment: Alignment.center,
      child: Container(
        width: 300,
        height: 400,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage('assets/image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ShadowImage extends StatelessWidget {
  const ShadowImage({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translate((x * 5), -(y * 5)),
      alignment: Alignment.center,
      child: Container(
        width: (250 + (1 + (y * 5))).clamp(250, 250 * 2),
        height: (350 + (1 + (y * 5))).clamp(350, 350 * 2),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage('assets/image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.0),
          ),
        ),
      ),
    );
  }
}
