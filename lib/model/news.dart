class News {
 String image;
  String title;
  String description;
  String ?date;
  int index;
  News({
   required this.image,
    required this.title,
    required this.description,
    this.date,
    required this.index,
  });
}

List<News> news = [
  News(
    image: 'assets/images/serve1.png',
    title: 'Solar Development',
    description:
        "We specialize in the custom design and installation of solar photovoltaic (PV) systems for homes, businesses, and large-scale facilities. Our expertise spans rooftop, ground-mounted, and carport solar systems.",
    index: 1,
  ),
  News(
image: 'assets/images/serve2.png',
      title: 'Energy Management',
      description:
          "We provide consulting and advisory services to help clients optimize energy usage, enhance reliability, and reduce costs.",
      index: 2),
  News(
   image: 'assets/images/serve4.png',
    title: 'Operation and Maintenance',
    description:
        "To ensure optimal performance and longevity, we provide comprehensive operation and maintenance services.",
    index: 3,
  ),
  News(
   image: 'assets/images/serve3.png',
    title: 'Solar Financing',
    description:
        "We make solar energy accessible and affordable by offering flexible financing solutions designed to meet diverse needs, through the following key components.",
    index: 4,
  ),
  
];


class Newss {
 String image;
  String title;
  String description;
  String ?date;
  int index;
  Newss({
   required this.image,
    required this.title,
    required this.description,
    this.date,
    required this.index,
  });
}

List<Newss> newss = [
  Newss(
    image: 'assets/images/learn1.png',
    title: 'Energy Audits',
    description:
        "Energy audits involve a comprehensive assessment of energy use in a facility. Provide detailed evaluations to identify opportunities for energy savings and efficiency improvements.",
    index: 1,
  ),
  Newss(
image: 'assets/images/learn2.png',
      title: 'Measurement and Verification',
      description:
          "Measurement and Verification, also known as M&V, refers to the overall strategy and methods used to estimate the savings that result from energy efficiency projects. M&V is important because sometimes energy efficiency projects do not save the energy they were supposed to save. There are many reasons energy efficiency might not deliver: Unrealistic estimates of energy savings, Improper installation of the technology, Improper writing of controls sequences, Failure to commission the retrofits. The cause of the savings shortfall does not matter.  Good M&V can alert you that there is a problem, if there is one.  It can also demonstrate that your energy efficiency project is performing as expected, or even better than expected.",
      index: 2),
  Newss(
   image: 'assets/images/learn33.jpg',
    title: 'Compliance & Carbon Footprint Reporting ',
    description:
        "We have listed what needs to happen in order to meet compliance standards, An Energy Star account must be created 30 days prior to required disclosure, Data collection forms/checklist to be distributed and completed, Utility providers must upload energy data within 30 day timeframe, Data entered into portfolio manager, Energy benchmark to be disclosed, Sales or lease contract signed, Loan Documentation submitted.",
    index: 3,
  ),
  Newss(
   image: 'assets/images/learn4.png',
    title: 'Utility Bill Monitoring',
    description:
        "Solevad Energy has provided superior utility analysis and utility auditing services for years. Our experience has taught us the best methods to use when dealing with your utility companies so that you get the savings that you deserve.",
    index: 4,
  ),
  
];

