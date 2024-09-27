import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_downloader_flutter/services/download_service.dart';
import 'package:youtube_downloader_flutter/widgets/my_button.dart';
import 'package:youtube_downloader_flutter/widgets/my_text_field.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final TextEditingController urlController = TextEditingController();
  final FocusNode urlFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String statusMessage = '';
  String? selectedQuality;
  List<String> qualityOptions = ['Audio', '360p', '480p', '720p', '1080p'];

  @override
  void dispose() {
    urlController.dispose();
    urlFocusNode.dispose();
    super.dispose();
  }

  Future<void> handleDownload() async {
    if (urlController.text.isEmpty || selectedQuality == null) {
      setState(() {
        statusMessage = 'Please provide a URL and select a quality';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Downloading...';
    });

    String resultMessage = await VideoDownloader.downloadVideo(
      urlController.text,
      selectedQuality!,
    );

    setState(() {
      statusMessage = resultMessage;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YouTube Downloader',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextFormField(
                          urlController: urlController,
                          urlFocusNode: urlFocusNode,
                        ),
                        const SizedBox(height: 16),
                        DropdownButton<String>(
                          value: selectedQuality,
                          hint: const Text('Select Quality'),
                          onChanged: (value) {
                            setState(() {
                              selectedQuality = value;
                            });
                          },
                          items: qualityOptions.map((quality) {
                            return DropdownMenuItem<String>(
                              value: quality,
                              child: Text(quality),
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 52,
                          child: MyButton(
                            onTap: handleDownload,
                            placeholder: 'Download',
                            icon: Icons.download,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (isLoading) const CircularProgressIndicator(),
                  if (statusMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        statusMessage,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
