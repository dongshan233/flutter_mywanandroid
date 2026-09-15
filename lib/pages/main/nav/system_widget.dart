import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_wanandroid/base/base_state_page.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/model/system_tree.info.dart';
import 'package:my_wanandroid/pages/main/controller/system_controller.dart';

class SystemWidget
    extends BaseStatePage<BaseResult<List<SystemTreeInfo>>, SystemController> {
  const SystemWidget({super.key});

  @override
  Widget buildSuccessContent(BaseResult<List<SystemTreeInfo>> data) {
    return Stack(
      children: [
        //列表
        ListView.builder(
          controller: controller.scorllController,
          itemCount: data.data?.length ?? 0,
          itemBuilder: (context, index) {
            return _systemItem(data.data![index]);
          },
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.only(top: 45, left: 16),
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: controller.opacity.value),
              boxShadow: controller.opacity.value > 0.5
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              '知识体系',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87.withValues(
                  alpha: controller.opacity.value,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _systemItem(SystemTreeInfo item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 12),
          child: Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Wrap(
            textDirection: TextDirection.ltr,
            spacing: 10,
            children: item.children
                .map(
                  (e) => InkWell(
                    onTap: () {},
                    child: Chip(
                      label: Text(
                        e.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: controller.getColor(e.id.toString()),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
