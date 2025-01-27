import 'package:dalael_ul_kahirat/core/theme/theme_constants.dart';
import 'package:dalael_ul_kahirat/root/Presentation/Screens/contents.dart';
import 'package:dalael_ul_kahirat/root/Presentation/Screens/pdfview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          border: Border(),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          height: 60,
          iconSize: 30,
          activeColor: const Color.fromARGB(255, 228, 186, 1),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // icon: Icon(CupertinoIcons.book),
              icon: Text("کتاب", style: GoogleFonts.notoNastaliqUrdu(fontSize: 12,)),
              // label: 'Home',
            ),
            BottomNavigationBarItem(
              // icon: Icon(CupertinoIcons.sun_haze),
              icon: Text("ایام", style: GoogleFonts.notoNastaliqUrdu(fontSize: 12,)),
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.bookmark),
              icon: Text("دعائیں", style: GoogleFonts.notoNastaliqUrdu(fontSize: 12,)),
              // label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Text("بکمارکس", style: GoogleFonts.notoNastaliqUrdu(fontSize: 12,)),
              // label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return const ContentsPage(title: "فہرست");
            case 1:
              return const TabScreen(title: "ایام");
            case 2:
              return const TabScreen(title: "دعائیں");
            case 3:
            default:
              return const TabScreen(title: "Bookmarks");
          }
        },
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;

  const TabScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        
        middle: Text(title,
        style: GoogleFonts.notoNastaliqUrdu(fontSize: 18, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary)),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}