import 'package:finance/core/constants/app_icons.dart';
import 'package:finance/core/extensions/align_ext_on_widget.dart';
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void _shareWithFriends() {
    Share.share('Check out this awesome finance app!', subject: 'Finance App');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      children: [
        const Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ).paddingOnly(bottom: 45).align(),
        _buildSettingItem(
          icon: AppIcons.terms,
          title: 'Terms & Conditions',
          onTap: () => _launchURL(
              'https://docs.google.com/document/d/1E262hAvAdtDCI4a0pdav5Cz0bgWTf9Yy1uJWbk2CIyE/edit?usp=sharing'),
        ),
        _buildSettingItem(
          icon: AppIcons.privacy,
          title: 'Privacy Policy',
          onTap: () => _launchURL(
              'https://docs.google.com/document/d/16JLdHQMLrGpBGaNzqVni2d1my9NLgf84h4AbDtidbic/edit?usp=sharing'),
        ),
        _buildSettingItem(
          icon: AppIcons.support,
          title: 'Support',
          onTap: () => _launchURL('https://forms.gle/YMTJZf3C3WPnAPok7'),
        ),
        _buildSettingItem(
          icon: AppIcons.share,
          title: 'Share with friends',
          onTap: _shareWithFriends,
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.10000000149011612),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 20,
              height: 20,
            ).paddingOnly(right: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ).expanded(),
            Image.asset(
              AppIcons.chevronRight,
              width: 7,
            ).paddingOnly(left: 8),
          ],
        ),
      ),
    );
  }
}
