import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:file_picker/file_picker.dart';

class VideoDownloader {
  static Future<String> downloadVideo(String videoUrl, String quality) async {
    String statusMessage;
    try {
      var yt = YoutubeExplode();

      // Parse the video URL
      var video = await yt.videos.get(videoUrl);

      // Get the manifest of streams
      var manifest = await yt.videos.streamsClient.getManifest(video.id);

      var selectedStream;

      // Choose the correct stream based on user selection
      if (quality == 'Audio') {
        selectedStream = manifest.audioOnly.withHighestBitrate();
      } else if (quality == '360p') {
        selectedStream =
            manifest.videoOnly.where((e) => e.qualityLabel == '360p').first;
      } else if (quality == '480p') {
        selectedStream =
            manifest.videoOnly.where((e) => e.qualityLabel == '480p').first;
      } else if (quality == '720p') {
        selectedStream =
            manifest.videoOnly.where((e) => e.qualityLabel == '720p').first;
      } else if (quality == '1080p') {
        selectedStream =
            manifest.videoOnly.where((e) => e.qualityLabel == '1080p').first;
      }

      // Ask for the location to save the file
      String? savePath = await FilePicker.platform.getDirectoryPath();
      if (savePath == null) {
        return 'No folder selected';
      }

      // Combine the path and file name
      var filePath = '$savePath/${video.title}.mp4';

      // Now download the file
      var fileStream = yt.videos.streamsClient.get(selectedStream);
      var output = await File(filePath).openWrite();

      await for (final chunk in fileStream) {
        output.add(chunk);
      }
      await output.close();

      yt.close();
      statusMessage = 'Download Completed: ${video.title}';
    } catch (e) {
      statusMessage = 'Error: $e';
    }
    return statusMessage;
  }
}
