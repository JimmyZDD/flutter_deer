/*
 * @Author: zdd
 * @Date: 2023-04-11 21:48:07
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-13 22:51:46
 * @FilePath: /flutter_deer/lib/shop/shop_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_deer/shop/controllers/shop_controller.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';
import 'package:widgets/widgets.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
    this.isAccessibilityTest = false,
  });

  final bool isAccessibilityTest;

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with AutomaticKeepAliveClientMixin<ShopPage> {
  final List<String> _menuTitle = ['账户流水', '资金管理', '提现账号'];
  final List<String> _menuImage = ['zhls', 'zjgl', 'txzh'];
  final List<String> _menuDarkImage = ['dark_zhls', 'dark_zjgl', 'dark_txzh'];

  final ShopController _controller = Get.find();
  // @override
  // void setUser(UserEntity? user) {
  //   provider.setUser(user);
  // }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color? iconColor = ThemeUtils.getIconColor(context);
    final Widget line = Container(
      height: 0.6,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16.0),
      child: Gaps.line,
    );
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: '消息',
            onPressed: () {
              // NavigatorUtils.push(context, ShopRouter.messagePage);
            },
            icon: LoadAssetImage(
              'shop/message',
              key: const Key('message'),
              width: 24.0,
              height: 24.0,
              color: iconColor,
            ),
          ),
          IconButton(
            tooltip: '设置',
            onPressed: () {
              // NavigatorUtils.push(context, SettingRouter.settingPage);
            },
            icon: LoadAssetImage(
              'shop/setting',
              key: const Key('setting'),
              width: 24.0,
              height: 24.0,
              color: iconColor,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap12,
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MergeSemantics(
                  child: Stack(
                    children: <Widget>[
                      const SizedBox(width: double.infinity, height: 56.0),
                      const Text(
                        '官方直营店',
                        style: TextStyles.textBold24,
                      ),
                      Positioned(
                          right: 0.0,
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: ImageUtils.getImageProvider(
                                _controller.user.value.avatarUrl,
                                holderImg: 'shop/tx'),
                          )),
                      Positioned(
                        top: 38.0,
                        left: 0.0,
                        child: Row(
                          children: const <Widget>[
                            LoadAssetImage(
                              'shop/zybq',
                              width: 40.0,
                              height: 16.0,
                            ),
                            Gaps.hGap8,
                            Text('店铺账号:15000000000',
                                style: TextStyles.textSize12)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Gaps.vGap24,
          line,
          Gaps.vGap24,
          const MergeSemantics(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '账户',
                style: TextStyles.textBold18,
              ),
            ),
          ),
          _ShopFunctionModule(
            data: _menuTitle,
            image: _menuImage,
            darkImage: _menuDarkImage,
            onItemClick: (index) {
              // if (index == 0) {
              //   NavigatorUtils.push(
              //       context, AccountRouter.accountRecordListPage);
              // } else if (index == 1) {
              //   NavigatorUtils.push(context, AccountRouter.accountPage);
              // } else if (index == 2) {
              //   NavigatorUtils.push(
              //       context, AccountRouter.withdrawalAccountPage);
              // }
            },
          ),
          line,
          Gaps.vGap24,
          const MergeSemantics(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '店铺',
                style: TextStyles.textBold18,
              ),
            ),
          ),

          /// 使用Flexible防止溢出
          Flexible(
            child: _ShopFunctionModule(
              data: const ['店铺设置'],
              image: const ['dpsz'],
              darkImage: const ['dark_dpsz'],
              onItemClick: (index) {
                // NavigatorUtils.push(context, ShopRouter.shopSettingPage);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopFunctionModule extends StatelessWidget {
  const _ShopFunctionModule({
    required this.onItemClick,
    required this.data,
    required this.image,
    required this.darkImage,
  });

  final Function(int index) onItemClick;
  final List<String> data;
  final List<String> image;
  final List<String> darkImage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.18,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(
                  context.isDark
                      ? 'shop/${darkImage[index]}'
                      : 'shop/${image[index]}',
                  width: 32.0),
              Gaps.vGap4,
              Text(
                data[index],
                style: TextStyles.textSize12,
              )
            ],
          ),
          onTap: () {
            onItemClick(index);
          },
        );
      },
    );
  }
}
