import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dorea_shoes/nike_shoes.dart';

const _buttonSizeW = 210.0;
const _buttonSizeH = 60.0;
const _buttonCircularSize = 60.0;
const _finalImageSize = 30.0;
const _imageSize = 120.0;

class NikeShoppingCart extends StatefulWidget {
  final NikeShoes shoes;

  const NikeShoppingCart({Key key, @required this.shoes}) : super(key: key);

  @override
  _NikeShoppingCartState createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animationButtonCart;
  Animation _animationMovimentIn;
  Animation _animationMovimentOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    _animationButtonCart = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.3,
        ),
      ),
    );

    _animationMovimentIn = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.3,
          0.6,
          curve: Curves.fastLinearToSlowEaseIn
        ),
      ),
    );

    _animationMovimentOut = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.6,
          1.0,
          curve: Curves.elasticIn
        ),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final buttonSizeW = (_buttonSizeW * _animationButtonCart.value)
                .clamp(_buttonCircularSize, _buttonSizeW);
            final panelSizeW = (size.width * _animationButtonCart.value).clamp(
              _buttonCircularSize, size.width);
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5
                      ),
                      child: Container(color: Colors.black87)),
                  ),
                ),
                Positioned.fill(
                  child: Stack(
                    children: [
                      if(_animationMovimentIn.value != 1)
                      Positioned(
                        top: size.height * 0.4 + (_animationMovimentIn.value * size.height * 0.45),
                        left: size.width / 2 - panelSizeW / 2,
                        width: panelSizeW,
                        child: _buildPanel(),
                      ),
                      Positioned(
                        bottom: 40 - (_animationMovimentOut.value * 100),
                        left: size.width / 2 - buttonSizeW / 2,
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                          tween: Tween(begin: 1.0, end: 0.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, value * size.height * .6),
                              child: child,
                            );
                          },
                          child: InkWell(
                            onTap: () {
                              _controller.forward();
                            },
                            child: Container(
                              width: buttonSizeW,
                              height:
                                  (_buttonSizeH * _animationButtonCart.value)
                                      .clamp(_buttonCircularSize, _buttonSizeH),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (_animationButtonCart.value == 1) ...[
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Adicionar ao carrinho',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;
    final currentImageSize = (_imageSize * _animationButtonCart.value).clamp(_finalImageSize, _imageSize);
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * size.height * .6),
          child: child,
        );
      },
      child: Container(
        height: (size.height * .6 * _animationButtonCart.value).clamp(
          _buttonCircularSize,
          size.height * .6,
        ),
        width: (size.width * _animationButtonCart.value).clamp(
          _buttonCircularSize,
          size.width,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: _animationButtonCart.value == 1 ? Radius.circular(0) : Radius.circular(30),
            bottomRight: _animationButtonCart.value == 1 ? Radius.circular(0) : Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationButtonCart.value == 1 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.shoes.images.first,
                    height: currentImageSize,
                  ),
                  if (_animationButtonCart.value == 1)
                  ...[
                    SizedBox(
                      width: 20,
                    ),
                    Column(children: [
                      Text(
                        widget.shoes.model,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'R\$${widget.shoes.currentPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
