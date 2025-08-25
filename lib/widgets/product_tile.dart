import 'package:e_com_task/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              product.image.isNotEmpty
                  ? Image.network(
                    product.image,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  )
                  : const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.image),
                  ),
        ),
        title: Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${product.currencyCode} ${product.price.toStringAsFixed(3)}'
          '${product.restaurantName != null ? " · ${product.restaurantName}" : ""}',
        ),
        onTap: onTap,
      ),
    );
  }
}
