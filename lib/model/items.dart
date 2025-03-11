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
      image: 'assets/images/serve1.png',
      title: 'Solar System Design & Installation',
      subtitle:
          'Custom design and installation of solar photovoltaic (PV) systems\nfor homes, businesses, and large-scale facilities. Expertise in\nrooftop, ground-mounted, and carport solar systems.'),
  Item(
      image: 'assets/images/serve2.png',
      title: 'Energy Consulting',
      subtitle:
          'Comprehensive energy assessments and feasibility studies. Expert\nadvice on transitioning to solar energy and maximizing returns.'),
  Item(
      image: 'assets/images/serve3.png',
      title: 'Solar Financing',
      subtitle:
          'Assistance with financing options, including leasing and Power\nPurchase Agreements (PPA).'),
  Item(
      image: 'assets/images/serve4.png',
      title: 'Off-Grid and Hybrid Systems',
      subtitle:
          'Design and implementation of off-grid solar systems for remote\nlocations. Hybrid solutions combining solar with other energy\nsources for uninterrupted power supply.'),

];
