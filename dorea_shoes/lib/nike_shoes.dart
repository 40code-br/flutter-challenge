class NikeShoes {
  NikeShoes({
    this.model, 
    this.oldPrice, 
    this.currentPrice, 
    this.images,
    this.modelNumber,
    this.color,
    this.sizes
  });

  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color;
  final List<String> sizes;
}

final shoes = <NikeShoes>[
  NikeShoes(
    model: 'Nike Air Max Sneakers Running Orange',
    currentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/nike_images/nike-air-max-sneakers-running-orange-outdoor.png',
      'assets/nike_images/nike-air-max-sneakers-running-orange-outdoor.png',
      'assets/nike_images/nike-air-max-sneakers-running-orange-outdoor.png',
    ],
    modelNumber: 90,
    color: 0xFFF6DADA,
    sizes: [
      '28', '32', '38', '41', '42'
    ]
  ),
  NikeShoes(
    model: 'Nike Basketball Sportswear',
    currentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/nike_images/basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running.png',
      'assets/nike_images/basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running.png',
      'assets/nike_images/basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running.png',
    ],
    modelNumber: 90,
    color: 0xFFF6f6f6,
    sizes: [
      '28', '32', '38', '41', '42'
    ]
  ),
  NikeShoes(
    model: 'Nike Free Air Force',
    currentPrice: 120,
    oldPrice: 148,
    images: [
      'assets/nike_images/nike-free-air-force-nike-shoes-image-file-formats-fashion.png',
      'assets/nike_images/nike-free-air-force-nike-shoes-image-file-formats-fashion.png',
      'assets/nike_images/nike-free-air-force-nike-shoes-image-file-formats-fashion.png',
    ],
    modelNumber: 56,
    color: 0xFFF6f6f6,
    sizes: [
      '28', '32', '38', '41', '42'
    ]
  ),
  NikeShoes(
    model: 'Nike Free Air Max Sneakers',
    currentPrice: 250,
    oldPrice: 275,
    images: [
      'assets/nike_images/nike-free-nike-air-max-sneakers-shoe-red-shoes-white-outdoor.png',
      'assets/nike_images/nike-free-nike-air-max-sneakers-shoe-red-shoes-white-outdoor.png',
      'assets/nike_images/nike-free-nike-air-max-sneakers-shoe-red-shoes-white-outdoor.png',
    ],
    modelNumber: 57,
    color: 0xFFF6f6f6,
    sizes: [
      '28', '32', '38', '41', '42'
    ]
  ),
  NikeShoes(
    model: 'Nike free sneakers skate white',
    currentPrice: 255,
    oldPrice: 333,
    images: [
      'assets/nike_images/nike-free-sneakers-skate-shoe-nike-nike-sneakers-white-outdoor.png',
      'assets/nike_images/nike-free-sneakers-skate-shoe-nike-nike-sneakers-white-outdoor.png',
      'assets/nike_images/nike-free-sneakers-skate-shoe-nike-nike-sneakers-white-outdoor.png',
    ],
    modelNumber: 80,
    color: 0xFFF6f6f6,
    sizes: [
      '28', '32', '38', '41', '42'
    ]
  ),
];