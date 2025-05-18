import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/snackbar.dart';

class UrlService {
  // Function to Open URLs
  static void launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    final urlPattern = r'^(http|https):\/\/([\w.]+\/?)\S*';
    final isValidUrl = RegExp(urlPattern, caseSensitive: false).hasMatch(url);

    if (!isValidUrl) {
      if (context.mounted) {
        MySnackbar.showError(context, "Invalid URL: $url");
      }
      return;
    }

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        MySnackbar.showError(context, "Could not launch $url");
      }
    }
  }
}
