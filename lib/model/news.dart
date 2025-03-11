class News {
 // String image;
  String title;
  String description;
  String date;
  int index;
  News({
   // required this.image,
    required this.title,
    required this.description,
    required this.date,
    required this.index,
  });
}

List<News> news = [
  News(
    //image: 'assets/images/news1.png',
    title: 'Abayomi John',
    description:
        "Since partnering with Onoseke-vwe Agro Ventures Ltd, my crop yield has doubled! Their guidance and high-quality products have made all the difference in my farm's success.",
    date: 'Nov. 28, 2023',
    index: 1,
  ),
  News(
//image: 'assets/images/news2.png',
      title: 'Erhisere Rukevwe',
      description:
          "The support I get from Onoseke-vwe Agro Ventures Ltd is incredible. They genuinely care about my farm’s progress and always have practical solutions to my challenges.",
      date: 'Dec. 20, 2023',
      index: 2),
  News(
   // image: 'assets/images/news3.png',
    title: 'BiniOdie Matt',
    description:
        "Onoseke-vwe Agro Ventures Ltd's seeds and inputs are unmatched. The results speak for themselves, and I’ve seen such healthy, resilient plants every season since I made the switch.",
    date: 'Mar. 25, 2024',
    index: 3,
  ),
  News(
  //  image: 'assets/images/news4.png',
    title: 'Blessing Douglas',
    description:
        "Thanks to Onoseke-vwe Agro Ventures Ltd's innovative irrigation systems, I've saved water and increased my harvest. Their commitment to sustainable farming is inspiring!",
    date: 'May. 28, 2023',
    index: 4,
  ),
  News(
   // image: 'assets/images/news5.png',
    title: 'Ogaga Sheriff',
    description:
        "From soil testing to expert advice, Onoseke-vwe Agro Ventures Ltd is with us every step of the way. I feel empowered to grow more and waste less thanks to their reliable products and knowledge",
    date: 'Aug. 15, 2023',
    index: 5,
  )
];
