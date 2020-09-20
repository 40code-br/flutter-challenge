import 'package:flutter/material.dart';
import 'package:dorea_shoes/components/shake_transition.dart';
import 'package:dorea_shoes/nike_shoes.dart';
import 'package:dorea_shoes/nike_shopping_cart.dart';

class NikeShoesDetails extends StatelessWidget {
  final NikeShoes shoes;
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  NikeShoesDetails({Key key, @required this.shoes}) : super(key: key);

  void _openShoppingCart(BuildContext context) async {
    notifierButtonsVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, __) {
          return FadeTransition(opacity: animation1, child: NikeShoppingCart(shoes: shoes,));
        },
      ),
    );
    notifierButtonsVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/nike_images/nike-logo.png',
          height: 40,
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCarousel(context),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ShakeTransition(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                shoes.model,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'R\$${shoes.oldPrice.toInt().toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      'R\$${shoes.currentPrice.toInt().toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ShakeTransition(
                          duration: const Duration(milliseconds: 1050),
                          child:
                              Text('TAMANHOS', style: TextStyle(fontSize: 11)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ShakeTransition(
                          duration: const Duration(milliseconds: 1100),
                          child:
                          Container(
                            height: 25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: shoes.sizes.length,
                              itemBuilder: (context, index) {
                                final tamanho = shoes.sizes[index];
                                return _ShoesSizeItem(
                                  text: tamanho,
                                );
                              },
                            ),
                          )
                          /* Row(
                            children: [
                              _ShoesSizeItem(text: '28'),
                              _ShoesSizeItem(text: '35'),
                              _ShoesSizeItem(text: '38'),
                              _ShoesSizeItem(text: '41'),
                            ],
                          ), */
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('DESCRIÇÃO', style: TextStyle(fontSize: 11)),
                        SizedBox(
                          height: 20,
                        ),
                        Text('blablablablablblablabalablablabl', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ]),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: notifierButtonsVisible,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    FloatingActionButton(
                      heroTag: 'fav_1',
                      onPressed: () {},
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      heroTag: 'fav_2',
                      onPressed: () {
                        _openShoppingCart(context);
                      },
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    left: 0,
                    right: 0,
                    bottom: value ? 0.0 : -kToolbarHeight * 1.5,
                    child: child);
              })
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .5,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'background_${shoes.model}',
              child: Container(
                color: Color(shoes.color),
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: 70,
            right: 70,
            child: Hero(
              tag: 'number_${shoes.model}',
              child: ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 1400),
                offset: 15,
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(.07),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
            itemBuilder: (context, index) {
              final tag = index == 0
                  ? 'image_${shoes.model}'
                  : 'image_${shoes.model}_$index';
              return Container(
                alignment: Alignment.center,
                child: ShakeTransition(
                  duration: index == 0
                      ? const Duration(milliseconds: 900)
                      : Duration.zero,
                  offset: 20,
                  axis: Axis.vertical,
                  child: Hero(
                    tag: tag,
                    child: Image.asset(
                      shoes.images[index],
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              );
            },
            itemCount: shoes.images.length,
          )
        ],
      ),
    );
  }
}

class _ShoesSizeItem extends StatelessWidget {
  final String text;

  const _ShoesSizeItem({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border:
            Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
      ),
      child: Text(text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
