import 'package:e_com_task/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> images;

  const ProductImageCarousel({super.key, required this.images});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 420,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            enlargeCenterPage: false,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items:
              widget.images.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            // Show shimmer while loading
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 350,
                                color: Colors.white,
                              ),
                            );
                          },
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.images.asMap().entries.map((entry) {
                bool isActive = _currentIndex == entry.key;
                return GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: isActive ? 10 : 10,
                    height: isActive ? 10 : 10,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isActive
                              ? AppColors.primaryText
                              : AppColors.indicatorcolor,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
