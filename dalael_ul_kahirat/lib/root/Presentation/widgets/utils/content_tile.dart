import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentTile extends StatelessWidget {
  final String page;
  final String title;
  final void Function()? onTilePressed;

  const ContentTile({
    super.key,
    required this.page,
    required this.title,
    this.onTilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTilePressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  page,
                  style: GoogleFonts.notoNastaliqUrdu(fontSize: 12),
                ),
                Text(
                  title,
                  style: GoogleFonts.notoNastaliqUrdu(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
