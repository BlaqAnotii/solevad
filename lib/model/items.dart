class Item {
  String image;
  String title;
  String subtitle;
  Item({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

List<Item> items = [
  Item(
      image: 'assets/images/service4.jpg',
      title: 'Agro-Inputs',
      subtitle:
          'We supply premium-quality inputs for livestock, poultry, and fish farming, including drugs, vaccines, feeds, vitamins, and other essential agricultural commodities..'),
  Item(
      image: 'assets/images/service6.jpg',
      title: 'Feed Manufacturing',
      subtitle:
          'Onoseke-vwe Agro Ventures Ltd produces high-quality poultry and fish feeds, including pelleted and floating fish feeds, using advanced production techniques that ensure optimal nutrition for livestock.'),
  Item(
      image: 'assets/images/service2.jpg',
      title: 'Farming',
      subtitle:
          'We operate poultry and catfish farms, providing fresh, high-quality chicken and fish products. '),
  Item(
      image: 'assets/images/service3.jpg',
      title: 'Food Processing',
      subtitle:
          'We process and distribute frozen chicken and dried catfish, ensuring a consistent supply of hygienic and nutritious food products to meet market demands.'),

];
