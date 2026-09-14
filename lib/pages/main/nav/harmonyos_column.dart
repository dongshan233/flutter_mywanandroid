import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_wanandroid/base/base_state_page.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/model/harmony_column_info.dart';
import 'package:my_wanandroid/pages/main/controller/harmonyos_column_controller.dart';
import 'package:my_wanandroid/utils/string_util.dart';

class HarmonyosColumnWidget
    extends
        BaseStatePage<BaseResult<HarmonyColumn>, HarmonyosColumnController> {
  const HarmonyosColumnWidget({super.key});

  @override
  Widget buildSuccessContent(BaseResult<HarmonyColumn> data) {
    return Obx(() {
      return SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            _tabList(),
            SizedBox(height: 12),
            Expanded(
              child: _articleList(
                controller.currentIndexValue,
                data.data!.tools,
                data.data!.links,
                data.data!.open_sources,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _tabList() {
    return Row(
      children: [
        for (int i = 0; i < controller.tabList.length; i++)
          GestureDetector(
            onTap: () {
              controller.currentIndexValue = i;
            },
            child: Container(
              margin: i == 0
                  ? const EdgeInsets.symmetric(horizontal: 10)
                  : null,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: controller.currentIndexValue == i
                    ? Color(0xFF0077F1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                StringUtil.removeHarmonyosDevPrefix(controller.tabList[i]),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: controller.currentIndexValue == i
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _articleList(
    int currentIndex,
    HarmonyosColumnTools tools,
    HarmonyosColumnLinks links,
    HarmonyosColumnOpenSources openSources,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: currentIndex == 0
            ? tools.articleList.length
            : currentIndex == 1
            ? links.articleList.length
            : openSources.articleList.length,
        itemBuilder: (context, index) {
          return _articleItem(
            currentIndex == 0
                ? tools.articleList[index]
                : currentIndex == 1
                ? links.articleList[index]
                : openSources.articleList[index],
          );
        },
      ),
    );
  }

  Widget _articleItem(HarmonyosColumnArticle article) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringUtil.removeMdash(article.author),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              if (article.desc.isNotEmpty)
                Text(
                  StringUtil.removeMdash(article.desc),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              if (article.desc.isNotEmpty) SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${article.superChapterName}/${article.chapterName}',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  Text(
                    article.niceDate,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
