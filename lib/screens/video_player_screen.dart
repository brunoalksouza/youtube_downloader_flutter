import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void dispose() {
    urlController.dispose();
    urlFocusNode.dispose();
    super.dispose();
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
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextFormField(
                            urlController: urlController,
                            urlFocusNode: urlFocusNode,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 52,
                          child: MyButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {}
                            },
                            placeholder: 'Download',
                            icon: Icons.download,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
