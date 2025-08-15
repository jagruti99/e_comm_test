import 'package:e_com_task/model/product_model.dart';
import 'package:e_com_task/service/product_service.dart';
import 'package:e_com_task/theme/colors.dart';
import 'package:e_com_task/theme/textstyles.dart';
import 'package:e_com_task/widgets/color_selection_list.dart';
import 'package:e_com_task/widgets/payment_section.dart';
import 'package:e_com_task/widgets/product_desc_tile.dart';
import 'package:e_com_task/widgets/product_image_slider.dart';
import 'package:e_com_task/widgets/quantity_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<Product> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = ProductService.fetchProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCoor,
      body: FutureBuilder<Product>(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
                color: AppColors.accent,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text("No data found"));
          }

          final product = snapshot.data!.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(CupertinoIcons.back, size: 22),
                onPressed: () {},
              ),
              title: Text(
                product.name != null && product.name!.trim().isNotEmpty
                    ? product.name.toString()
                    : "",
                style: AppTextStyles.title,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(CupertinoIcons.heart),
                  onPressed: () {},
                  color: AppColors.accent,
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.share),
                  onPressed: () {},
                  color: AppColors.accent,
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.bag),
                  onPressed: () {},
                  color: AppColors.accent,
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // image slider
                          ProductImageCarousel(
                            images:
                                product.images?.isNotEmpty == true
                                    ? product.images!
                                    : [],
                          ),

                          SizedBox(height: 15),

                          //title - subtitle section
                          Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.brandName
                                            .toString()
                                            .toUpperCase(),
                                        style: AppTextStyles.sectionTitle,
                                      ),
                                    ),
                                    Text(
                                      "${double.parse(product.finalPrice.toString()).toStringAsFixed(2)} KWD",
                                      style: AppTextStyles.sectionTitle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name.toString(),
                                        style: AppTextStyles.sectionSubTitle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "SKU: ",
                                      style: AppTextStyles.sectionSubTitle,
                                    ),
                                    Text(
                                      product.sku.toString(),
                                      style: AppTextStyles.sectionbody,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 15),

                          //color section
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Color:", style: AppTextStyles.subtitle),
                              ],
                            ),
                          ),

                          ColorSwatchList(
                            attributes:
                                product.configurableOption!.first.attributes!,
                          ),

                          SizedBox(height: 15),

                          //payment section
                          PaymentWidget(),
                          SizedBox(height: 15),

                          //quantity section
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Quantity:",
                                  style: AppTextStyles.subtitle,
                                ),
                              ],
                            ),
                          ),
                          QuantitySection(),

                          //expansion tile for product info section
                          ProductDescriptionTile(
                            description: product.description.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //bottom buttons
                  Container(
                    decoration: BoxDecoration(color: AppColors.backgroundCoor),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Text(
                              "Add to bag",
                              style: AppTextStyles.primarybuttontextstyle,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              side: BorderSide(
                                color: AppColors.accent,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Text(
                              "Share",
                              style: AppTextStyles.secondarybuttontextstyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
