import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

enum BarCodeMode { code39, qrCode }

class UserInfoScaffold extends StatefulWidget {
  const UserInfoScaffold({
    super.key,
    required this.userInfo,
    this.heroTag,
    this.actions,
    this.onRefresh,
    this.enableBarCode = false,
  });

  final UserInfo userInfo;
  final String? heroTag;
  final List<Widget>? actions;
  final Future<UserInfo?> Function()? onRefresh;
  final bool enableBarCode;

  @override
  UserInfoScaffoldState createState() => UserInfoScaffoldState();
}

class UserInfoScaffoldState extends State<UserInfoScaffold> {
  ApLocalizations get app => ApLocalizations.of(context);

  BarCodeMode codeMode = BarCodeMode.qrCode;

  bool _isRefreshing = false;

  String get iconName {
    switch (codeMode) {
      case BarCodeMode.code39:
        return ApImageIcons.qrcode;
      case BarCodeMode.qrCode:
        return ApImageIcons.barcode;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? <Color>[
                            colorScheme.primaryContainer,
                            colorScheme.surface,
                          ]
                        : <Color>[
                            colorScheme.primary,
                            colorScheme.primaryContainer,
                          ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      _buildAvatar(colorScheme, isDark),
                      const SizedBox(height: 12),
                      Text(
                        widget.userInfo.name ?? '',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? colorScheme.onSurface
                              : colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              ...widget.actions ?? <Widget>[],
              if (widget.enableBarCode)
                IconButton(
                  icon: Image.asset(
                    iconName,
                    height: 24.0,
                    width: 24.0,
                  ),
                  onPressed: () {
                    setState(
                      () => codeMode = BarCodeMode.values[
                          (codeMode.index + 1) % BarCodeMode.values.length],
                    );
                    AnalyticsUtil.instance.logEvent('user_info_barcode_switch');
                  },
                ),
              IconButton(
                icon: _isRefreshing
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: isDark
                              ? colorScheme.onSurface
                              : colorScheme.onPrimary,
                        ),
                      )
                    : const Icon(Icons.refresh_rounded),
                onPressed: _isRefreshing ? null : _handleRefresh,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: RefreshIndicator(
              onRefresh: () async {
                await _handleRefresh();
                AnalyticsUtil.instance.logEvent('user_info_refresh');
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      _buildInfoCard(colorScheme),
                      if (widget.enableBarCode) ...<Widget>[
                        const SizedBox(height: 16),
                        _buildBarcodeCard(colorScheme),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme, bool isDark) {
    final bool hasImage = widget.userInfo.pictureBytes != null &&
        widget.userInfo.pictureBytes!.isNotEmpty;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? colorScheme.primary
              : colorScheme.onPrimary.withAlpha(128),
          width: 4,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.shadow.withAlpha(51),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 48,
        backgroundColor: isDark
            ? colorScheme.primaryContainer
            : colorScheme.onPrimary.withAlpha(51),
        backgroundImage:
            hasImage ? MemoryImage(widget.userInfo.pictureBytes!) : null,
        child: hasImage
            ? null
            : Icon(
                Icons.person_rounded,
                size: 56,
                color: isDark ? colorScheme.primary : colorScheme.onPrimary,
              ),
      ),
    );
  }

  Widget _buildInfoCard(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(77),
        ),
      ),
      child: Column(
        children: <Widget>[
          _buildInfoRow(
            icon: Icons.badge_outlined,
            title: app.studentId,
            value: widget.userInfo.id,
            colorScheme: colorScheme,
          ),
          _buildDivider(colorScheme),
          if (widget.userInfo.educationSystem != null) ...<Widget>[
            _buildInfoRow(
              icon: Icons.school_outlined,
              title: app.educationSystem,
              value: widget.userInfo.educationSystem!,
              colorScheme: colorScheme,
            ),
            _buildDivider(colorScheme),
          ],
          if (widget.userInfo.email != null) ...<Widget>[
            _buildInfoRow(
              icon: Icons.email_outlined,
              title: app.email,
              value: widget.userInfo.email!,
              colorScheme: colorScheme,
            ),
            _buildDivider(colorScheme),
          ],
          _buildInfoRow(
            icon: Icons.domain_outlined,
            title: app.department,
            value: widget.userInfo.department ?? '',
            colorScheme: colorScheme,
          ),
          _buildDivider(colorScheme),
          _buildInfoRow(
            icon: Icons.class_outlined,
            title: app.studentClass,
            value: widget.userInfo.className ?? '',
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeCard(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(77),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.badge_outlined,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '學號條碼',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  widget.userInfo.id,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                    letterSpacing: 4,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 12),
                BarcodeWidget(
                  barcode: codeMode == BarCodeMode.code39
                      ? Barcode.code39()
                      : Barcode.qrCode(),
                  data: widget.userInfo.id,
                  color: ApTheme.of(context).barCode,
                  height: codeMode == BarCodeMode.code39 ? 80 : 160,
                  width: codeMode == BarCodeMode.code39 ? double.infinity : 160,
                ),
                const SizedBox(height: 12),
                Text(
                  '可持本條碼於圖書館借書',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withAlpha(128),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                SelectableText(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      height: 1,
      indent: 72,
      color: colorScheme.outlineVariant.withAlpha(77),
    );
  }

  Future<void> _handleRefresh() async {
    if (widget.onRefresh == null) return;
    setState(() => _isRefreshing = true);
    await widget.onRefresh!();
    if (mounted) setState(() => _isRefreshing = false);
  }
}
