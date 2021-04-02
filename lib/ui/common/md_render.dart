import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:markdown/markdown.dart' as md;
import 'package:personal_website/ui/demos/index.dart';

import '../../data/blocs/blocs.dart';
import '../../plugins/url_launcher/url_launcher.dart';
import '../router.dart';

class MarkdownRender extends StatelessWidget {
  const MarkdownRender({
    Key key,
    @required String html,
  })  : _html = html,
        super(key: key);

  final String _html;

  get UriUtils => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: _html == null
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: 900,
                    child: Html(
                      data: md.markdownToHtml(_html),
                      //Optional parameters:
                      // routes: Router.routes(blocState),
                      routes: {
                        // -- Demos --
                        TestDemo.routeName: (_) => TestDemo(),
                        PianoFinalDemo.routeName: (_) => PianoFinalDemo(),
                      },
                      padding: EdgeInsets.all(8.0),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      defaultTextStyle: TextStyle(fontFamily: 'serif'),
                      linkStyle: const TextStyle(color: Colors.redAccent),
                      onLinkTap: (url) => UrlUtils.open(url, name: 'Info'),
                      onImageTap: (src) => UrlUtils.open(src, name: 'Preview'),
                      //Must have useRichText set to false for this to work.
                      useRichText: true,
                      // customTextAlign: (dom.Node node) {
                      //   if (node is dom.Element) {
                      //     switch (node.localName) {
                      //       case "p":
                      //         return TextAlign.justify;
                      //     }
                      //   }
                      // },
                      // customTextStyle: (dom.Node node, TextStyle baseStyle) {
                      //   if (node is dom.Element) {
                      //     switch (node.localName) {
                      //       case "p":
                      //         return baseStyle
                      //             .merge(TextStyle(height: 2, fontSize: 20));
                      //     }
                      //   }
                      //   return baseStyle;
                      // },
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
