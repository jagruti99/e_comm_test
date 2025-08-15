import 'package:e_com_task/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDescriptionTile extends StatelessWidget {
  final String description;

  const ProductDescriptionTile({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.all(8.0),
        childrenPadding: EdgeInsets.zero,
        title: Text(
          "Product Information".toUpperCase(),
          style: AppTextStyles.title,
        ),
        children: [
          Html(
            data: description,
            style: {
              "body": Style(
                fontSize: FontSize(14),
                color: Colors.grey.shade700,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              "ul": Style(fontFamily: GoogleFonts.poppins().fontFamily),
              "ol": Style(fontFamily: GoogleFonts.poppins().fontFamily),
              "li": Style(fontFamily: GoogleFonts.poppins().fontFamily),
            },
          ),
        ],
      ),
    );
  }
}
