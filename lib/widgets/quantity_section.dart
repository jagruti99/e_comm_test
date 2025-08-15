import 'package:e_com_task/theme/colors.dart';
import 'package:flutter/material.dart';

class QuantitySection extends StatefulWidget {
  const QuantitySection({super.key});

  @override
  State<QuantitySection> createState() => _QuantitySectionState();
}

class _QuantitySectionState extends State<QuantitySection> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (quantity > 1) quantity--;
              });
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    quantity > 1
                        ? AppColors.secondaryText
                        : AppColors.secondaryText.shade400,
                borderRadius: BorderRadius.zero,
              ),
              child: const Text(
                "-",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonText,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),

          Container(
            width: 80,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.border.shade400),
            ),
            child: Text(
              "$quantity",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: 20),

          GestureDetector(
            onTap: () {
              setState(() {
                quantity++;
              });
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.primaryText),
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
