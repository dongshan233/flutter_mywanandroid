import 'package:flutter/material.dart';
import 'package:my_wanandroid/routes/route_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  var title = '';
  var link = '';
  var originId = '';
  var isCollect = false;

  var _progress = 0;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    final articleInfo = RouteUtils.getArgument() as Map<String, dynamic>;
    title = articleInfo['title'];
    link = articleInfo['link'];
    originId = articleInfo['originId'];
    isCollect = articleInfo['collect'];

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              _progress = 0;
            });
          },
          onPageStarted: (url) {
            setState(() {
              _progress = 0;
            });
          },
          onPageFinished: (url) {
            _progress = 100;
          },
        ),
      )
      ..loadRequest(Uri.parse(link));
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, size: 24, color: Colors.black87),
        ),
        Text(
          '文章详情',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          onPressed: () async {},
          icon: Icon(
            isCollect ? Icons.favorite : Icons.favorite_outline,
            size: 24,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, size: 24, color: Colors.black87),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_progress < 100)
              LinearProgressIndicator(
                minHeight: 1,
                valueColor: AlwaysStoppedAnimation(Colors.red),
                backgroundColor: Colors.grey.shade200,
                value: _progress / 100,
              ),
            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ),
      ),
    );
  }
}
