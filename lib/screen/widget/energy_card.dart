import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solevad/model/news.dart';


class NewsCards extends StatefulWidget {
  final Newss newss;
  const NewsCards(this.newss, {super.key});

  @override
  State<NewsCards> createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards>{
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      child: SizedBox(
        height: 635,
        width: 480,
        child:  Column(
                    children: [
                      SizedBox(
                        height: 290.0,
                        width: 290.0,
                        child: Center(
                          child: SizedBox(
                            // height: imageReveal.value,
                            // width: imageReveal.value,
                            child: Container(
                              height: 450,
                              width: 450,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage(widget.newss.image),  fit: BoxFit.cover,
                                )
                              ),
                            
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                          child: Column(
                        children: [
                          Text(
                            widget.newss.title,
                            style: const TextStyle(
                              color: Color(0xff32CD32),
                              
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.newss.description,
                            style: const TextStyle(
                              color: Colors.black,
                              
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
    );
     
  }
}
