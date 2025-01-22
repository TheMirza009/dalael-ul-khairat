import 'package:dalael_ul_kahirat/core/theme/theme_constants.dart';
import 'package:dalael_ul_kahirat/root/Presentation/widgets/audio_player.dart';
import 'package:dalael_ul_kahirat/root/Presentation/widgets/themeselection_dialog_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class PDFScreen extends StatelessWidget {
  const PDFScreen({super.key});

  // Function to load the PDF file
  Future<String> loadPdf() async {
    try {
      // Load the PDF from assets and save it to a temporary directory.
      final ByteData data = await rootBundle.load('Assets/Mulk.pdf');
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/Mulk.pdf';

      final File file = File(path);
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

      return path;
    } catch (e) {
      throw "Error loading PDF: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "صورۃالملک",
          style: GoogleFonts.notoNastaliqUrdu(fontSize: 20, color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          IconButton(
            onPressed: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => const ThemeSelectionDialogIOS(),
            ),
            icon: const Icon(CupertinoIcons.sun_max),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: AudioPlayerWidget(audioPath: "Assets/Surah al-mulk.mp3"),
          ),
          // Use FutureBuilder to load the PDF
          FutureBuilder<String>(
            future: loadPdf(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading PDF: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                final filePath = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 8, right: 8, bottom: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: ThemeConstants.screenHeight * 0.765,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: PDFView(
                        filePath: filePath,
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: true,
                        pageFling: false,
                        onRender: (pages) {
                          print("PDF rendered with $pages pages.");
                        },
                        onError: (error) {
                          print("Error opening PDF: $error");
                        },
                        onPageError: (page, error) {
                          print("Error on page $page: $error");
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ],
      ),
    );
  }
}
