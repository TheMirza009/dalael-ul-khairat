
import 'package:dalael_ul_kahirat/core/theme/theme_constants.dart';
import 'package:dalael_ul_kahirat/root/Presentation/widgets/themeselection_dialog_ios.dart';
import 'package:dalael_ul_kahirat/root/Presentation/widgets/utils/content_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentsPage extends StatelessWidget {
  final String title;

  const ContentsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            iconSize: 25,
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => const ThemeSelectionDialogIOS(),
              ),
              icon: const Icon(CupertinoIcons.sun_max),
            ),
        ),
        middle: Text(title,
        style: GoogleFonts.notoNastaliqUrdu(fontSize: 18, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary)),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                ContentTile(page: "۱", title: "مقدمہ", onTilePressed: () => print("TILE")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}