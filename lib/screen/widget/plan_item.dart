import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';


Widget planCard(Animation<double> planAnimation, Color textColor,
    Color containerColor, Color borderColor, String text, String price, BuildContext context) {


  return ScaleTransition(
    scale: planAnimation,
    child: Container(
      height: 480,
      width: 300,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0.5, color: borderColor),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'CH',
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            price,
            style: TextStyle(
              fontFamily: 'CH',
              color: textColor,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 240,
            child: Text(
              'Cat Fish, Chicken and Other Poultry birds',
              style: TextStyle(
                fontFamily: 'CH',
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  color: borderColor,
                  size: 20,
                ),
                label: Text(
                  'Healthy & Safe',
                  style: TextStyle(
                    fontFamily: 'CH',
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  color: borderColor,
                  size: 20,
                ),
                label: Text(
                  'High Quality',
                  style: TextStyle(
                    fontFamily: 'CH',
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  color: borderColor,
                  size: 20,
                ),
                label: Text(
                  'High Produce',
                  style: TextStyle(
                    fontFamily: 'CH',
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () {
                 context.go('/whatsapp');

                },
                style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                            fixedSize: const Size(150, 50),
                            backgroundColor:  Colors.blueGrey[900],
                ),
                child: const Text(
                  'Order Now',
                  style: TextStyle(
                    fontFamily: 'CH',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
