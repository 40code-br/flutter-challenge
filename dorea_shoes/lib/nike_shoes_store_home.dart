import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dorea_shoes/layout/layout.dart';
import 'package:dorea_shoes/nike_shoes.dart';
import 'package:dorea_shoes/nike_shoes_details.dart';

class NikeShoesStoreHome extends StatelessWidget {
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  void _onShoesPressed(NikeShoes shoes, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (_, animation1, __) {
      return FadeTransition(
          opacity: animation1,
          child: NikeShoesDetails(
            shoes: shoes,
          ));
    }));
    notifierBottomBarVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Dórea Shoes',
          style: TextStyle(color: Colors.grey[600]),
        ),
        actions: [
          GestureDetector(
            child: Icon(Icons.notifications_none),
            onTap: () {},
          ),
          GestureDetector(
            child: Icon(Icons.shopping_cart_outlined),
            onTap: () {},
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/nike_images/nike-logo.png',
                  height: 40,
                ),
                Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: shoes.length,
                  itemBuilder: (context, index) {
                    final shoesItem = shoes[index];
                    return NikeShoesItem(
                      shoesItem: shoesItem,
                      onTap: () {
                        _onShoesPressed(shoesItem, context);
                      },
                    );
                  },
                ))
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: notifierBottomBarVisible,
              child: Container(
                color: Colors.white.withOpacity(.7),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.home,
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.favorite_border,
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 13,
                          backgroundImage:
                              AssetImage('assets/nike_images/user.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: 0,
                    right: 0,
                    bottom: value ? 0 : -kToolbarHeight,
                    height: kToolbarHeight,
                    child: child);
              })
        ],
      ),
    );
  }
}

class NikeShoesItem extends StatelessWidget {
  final NikeShoes shoesItem;
  final VoidCallback onTap;

  const NikeShoesItem({Key key, this.shoesItem, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const itemHeight = 290.0;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          height: itemHeight,
          child: Stack(fit: StackFit.expand, children: [
            Positioned.fill(
              child: Hero(
                tag: 'background_${shoesItem.model}',
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(shoesItem.color),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'number_${shoesItem.model}',
                child: SizedBox(
                  height: itemHeight * .65,
                  child: Material(
                    color: Colors.transparent,
                    child: FittedBox(
                      child: Text(
                        shoesItem.modelNumber.toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(.03),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 20,
                left: 0,
                right: 0,
                height: itemHeight * .6,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(
                    shoesItem.images.first,
                    fit: BoxFit.contain,
                  ),
                )),
            Positioned(
              bottom: 20,
              left: 20,
              child: Icon(
                Icons.favorite_border,
                color: Colors.grey,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Icon(
                Icons.shopping_basket_outlined,
                color: Colors.grey,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    shoesItem.model,
                    style: TextStyle(
                        color: Colors.grey[850],
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'R\$${shoesItem.oldPrice.toInt().toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'R\$${shoesItem.currentPrice.toInt().toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
