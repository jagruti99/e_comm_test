import 'package:e_com_task/model/product_model.dart';
import 'package:flutter/material.dart';

class ColorSwatchList extends StatelessWidget {
  final List<Attributes> attributes;

  const ColorSwatchList({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          final attr = attributes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(attr.swatchUrl.toString()),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
          );
        },
      ),
    );
  }
}
