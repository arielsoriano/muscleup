import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';

/// Full privacy policy rendered natively so it is readable offline, mirroring
/// the hosted version published at [AppConstants.privacyPolicyUrl].
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyPolicy)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppTheme.spacingMedium,
          AppTheme.spacingMedium,
          AppTheme.spacingMedium,
          AppTheme.spacingXLarge,
        ),
        children: [
          Text(
            l10n.privacyPolicyLastUpdated(
              DateTime.parse(AppConstants.privacyPolicyLastUpdated),
            ),
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          _Paragraph(l10n.privacyPolicyIntro),
          _SectionTitle(l10n.privacyPolicyDataTitle),
          _Bullet(l10n.privacyPolicyDataItem1),
          _Bullet(l10n.privacyPolicyDataItem2),
          _Bullet(l10n.privacyPolicyDataItem3),
          _SectionTitle(l10n.privacyPolicyCollectionTitle),
          _Bullet(l10n.privacyPolicyCollectionItem1),
          _Bullet(l10n.privacyPolicyCollectionItem2),
          _Bullet(l10n.privacyPolicyCollectionItem3),
          _SectionTitle(l10n.privacyPolicyUsageTitle),
          _Bullet(l10n.privacyPolicyUsageItem1),
          _Bullet(l10n.privacyPolicyUsageItem2),
          _Bullet(l10n.privacyPolicyUsageItem3),
          _SectionTitle(l10n.privacyPolicySharingTitle),
          _Paragraph(l10n.privacyPolicySharingBody),
          _SectionTitle(l10n.privacyPolicySecurityTitle),
          _Paragraph(l10n.privacyPolicySecurityBody),
          _SectionTitle(l10n.privacyPolicyRetentionTitle),
          _Paragraph(l10n.privacyPolicyRetentionBody),
          _SectionTitle(l10n.privacyPolicyDeletionTitle),
          _Paragraph(l10n.privacyPolicyDeletionBody),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => _openUrl(
                    context,
                    Uri.parse(AppConstants.accountDeletionUrl),
                  ),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(l10n.privacyPolicyAccountDeletionPage),
                ),
                TextButton.icon(
                  onPressed: () => _openUrl(
                    context,
                    _mailTo(
                      subject: l10n.accountDeletionEmailSubject,
                      body: l10n.accountDeletionEmailBody,
                    ),
                  ),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(l10n.privacyPolicyAccountDeletion),
                ),
              ],
            ),
          ),
          _SectionTitle(l10n.privacyPolicyChildrenTitle),
          _Paragraph(l10n.privacyPolicyChildrenBody),
          _SectionTitle(l10n.privacyPolicyContactTitle),
          _Paragraph(l10n.privacyPolicyContactBody),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: () => _openUrl(context, _mailTo()),
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text(AppConstants.contactEmail),
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          OutlinedButton.icon(
            onPressed: () => _openUrl(
              context,
              Uri.parse(AppConstants.privacyPolicyUrl),
            ),
            icon: const Icon(Icons.open_in_new_rounded),
            label: Text(l10n.privacyPolicyOpenOnline),
          ),
        ],
      ),
    );
  }

  /// Builds a `mailto:` link to the support address, optionally pre-filling the
  /// subject and body so the user only has to hit send.
  Uri _mailTo({String? subject, String? body}) {
    final params = <String, String>{
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    };

    return Uri(
      scheme: 'mailto',
      path: AppConstants.contactEmail,
      query: params.isEmpty
          ? null
          : params.entries
              .map(
                (entry) =>
                    '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
              )
              .join('&'),
    );
  }

  Future<void> _openUrl(BuildContext context, Uri uri) async {
    final fallbackMessage = context.l10n.couldNotOpenLink;
    final copiedMessage = context.l10n.emailCopiedToClipboard;

    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      launched = false;
    }

    if (launched || !context.mounted) {
      return;
    }

    // No browser or email client available: leave the destination on the
    // clipboard so the user can still reach it.
    final isMailto = uri.scheme == 'mailto';
    await Clipboard.setData(
      ClipboardData(text: isMailto ? AppConstants.contactEmail : uri.toString()),
    );
    if (!context.mounted) {
      return;
    }

    context.showAppSnackBar(
      message: isMailto ? copiedMessage : fallbackMessage,
      type: SnackBarType.info,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppTheme.spacingLarge,
        bottom: AppTheme.spacingSmall,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•  ', style: style),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
