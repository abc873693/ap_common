import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:photo_view/photo_view.dart';

/// A glass-enhanced version of [ImageViewerScaffold].
///
/// Replaces the [AppBar] with [GlassAppBar]. Uses the standard
/// [TabBar] for multi-image navigation since [GlassTabBar]
/// requires [GlassTab] items and index-based selection rather
/// than a [TabController].
class GlassImageViewerScaffold extends StatefulWidget {
  const GlassImageViewerScaffold({
    super.key,
    this.title,
    required this.imageViewers,
    this.actions,
  });

  final String? title;
  final List<ImageViewer> imageViewers;
  final List<Widget>? actions;

  @override
  GlassImageViewerScaffoldState createState() =>
      GlassImageViewerScaffoldState();
}

class GlassImageViewerScaffoldState
    extends State<GlassImageViewerScaffold>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: widget.imageViewers.length,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(widget.title ?? ''),
        actions: widget.actions,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top +
                44,
          ),
          if (widget.imageViewers.length > 1)
            TabBar(
              controller: _tabController,
              tabs: <Tab>[
                for (final ImageViewer image
                    in widget.imageViewers)
                  Tab(text: image.title),
              ],
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                for (final ImageViewer image
                    in widget.imageViewers)
                  PhotoView(
                    imageProvider:
                        AssetImage(image.assetName),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
