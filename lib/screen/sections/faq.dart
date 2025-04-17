import 'package:flutter/material.dart';
class FAQ {
  final String question;
  final String answer;
  FAQ({required this.question, required this.answer});
}

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int? _expandedIndex;

  final List<FAQ> faqList = [
    FAQ(
      question: "What does Solevad Energy do?",
      answer:
          "We help Nigerians find and finance great solar products. Our experts negotiate pricing, warranty, payment plans and handle the process end-to-end on your behalf. 150+ solar companies and dozens of financiers nationwide use our services to get customers and support.",
    ),
    FAQ(
      question: "Can my solar system switch between inverter and grid supply?",
      answer: "Yes, modern solar systems can switch seamlessly between inverter and grid supply depending on configuration.",
    ),
    FAQ(
      question: "How soon can I access financing?",
      answer: "Financing can usually be accessed within a few business days after successful application and approval.",
    ),
    FAQ(
      question: "Where is your office?",
      answer: "Our main office is located in Lagos, Nigeria.",
    ),
    FAQ(
      question: "Is the estimated quote what I am paying for the solar system?",
      answer: "Yes, unless changes are made to your system design or options.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
    Column(
      children: [
                  const SizedBox(height: 16),

        const Center(
          child: Text(
              "Frequently Asked Questions",
              style: TextStyle(
                              color: Color(0xff32CD32),
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
        ),
          const SizedBox(height: 16),
        ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: faqList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final faq = faqList[index];
              final isExpanded = _expandedIndex == index;
        
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              faq.question,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 12),
                        Text(
                          faq.answer,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    ),
    );
  }
}