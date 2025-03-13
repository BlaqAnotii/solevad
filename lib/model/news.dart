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
    image: 'assets/images/learn1.png',
    title: 'Load Audit and system design',
    description:
        "At Solevad Energy, we specialize in providing comprehensive Load Audit and System Design solutions to meet your energy needs efficiently and sustainably. By performing a detailed load audit and designing a solar system to meet our client’s unique energy needs, organizations can maximize efficiency, minimize costs, and contribute to environmental sustainability.",
    index: 1,
  ),
  News(
image: 'assets/images/learn2.png',
      title: 'Energy Usage Analysis Service',
      description:
          "We also specialize on providing Energy Usage Analysis services designed to help individuals, businesses, and organizations understand and optimize their energy consumption. By understanding consumption patterns, the right capacity for solar panels, inverters, and battery storage can be determined, ensuring cost-effectiveness and reliability.",
      index: 2),
  News(
   image: 'assets/images/learn33.jpg',
    title: 'Energy Efficiency Conversion Studies\nand Implementation',
    description:
        "At Solevad we are committed to helping clients transition to more energy-efficient systems through Energy Efficiency Conversion Studies and Implementation Services. Our expertise ensures that you maximize energy savings, enhance system performance, and reduce your environmental footprint.",
    index: 3,
  ),
  News(
   image: 'assets/images/learn4.png',
    title: 'After-Sales Support Services',
    description:
        "Customer satisfaction is our top priority. That’s why we provide comprehensive After-Sales Support Services to ensure the smooth operation of your purchased products and solutions long after the initial sale.",
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

