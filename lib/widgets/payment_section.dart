// ignore_for_file: deprecated_member_use

import 'package:e_com_task/theme/textstyles.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "or 4 interest-free payments",
                  style: AppTextStyles.paymentsectiontext,
                ),
                Row(
                  children: [
                    Text(
                      "0.88 KWD",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Learn More",
                        style: TextStyle(
                          fontSize: 13,

                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFd6fff3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "tabby",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF009c84),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
