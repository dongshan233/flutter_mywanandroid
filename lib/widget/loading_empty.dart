import 'package:flutter/material.dart';

class LoadingEmpty extends StatefulWidget {
  const LoadingEmpty({super.key});

  @override
  State<LoadingEmpty> createState() => _LoadingEmptyState();
}

class _LoadingEmptyState extends State<LoadingEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/ic_empty.png", width: 100, height: 100),
          SizedBox(height: 16),
          Text('暂无数据', style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 10),
          Text('内容正在赶来的路上', style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.red),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shadowColor: Colors.transparent,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }
}
