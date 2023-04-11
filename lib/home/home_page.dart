import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/res/colors.dart';
import 'package:utils/res/dimens.dart';
import 'package:utils/utils.dart';
import 'package:widgets/widgets.dart';

import '../goods/goods_page.dart';
import '../order/order_page.dart';
import '../shop/shop_page.dart';
import 'controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RestorationMixin {
  static const double _imageSize = 25.0;
  final HomeController _controller = Get.find();
  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['订单', '商品', '店铺'];
  final PageController _pageController = PageController();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const OrderPage(),
      const GoodsPage(),
      const ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const tabImages = [
        [
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ],
        // [
        //   LoadAssetImage(
        //     'home/icon_statistics',
        //     width: _imageSize,
        //     color: Colours.unselected_item_color,
        //   ),
        //   LoadAssetImage(
        //     'home/icon_statistics',
        //     width: _imageSize,
        //     color: Colours.app_main,
        //   ),
        // ],
        [
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.app_main,
          ),
        ]
      ];
      _list = List.generate(tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImages[i][0],
          activeIcon: tabImages[i][1],
          label: _appBarTitles[i],
          tooltip: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const tabImagesDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ],
        // [
        //   LoadAssetImage('home/icon_statistics', width: _imageSize),
        //   LoadAssetImage(
        //     'home/icon_statistics',
        //     width: _imageSize,
        //     color: Colours.dark_app_main,
        //   ),
        // ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: Colours.dark_app_main,
          ),
        ]
      ];

      _listDark = List.generate(tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImagesDark[i][0],
          activeIcon: tabImagesDark[i][1],
          label: _appBarTitles[i],
          tooltip: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return DoubleTapBackExitApp(
      child: Scaffold(
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              backgroundColor: context.backgroundColor,
              items: isDark
                  ? _buildDarkBottomNavigationBarItem()
                  : _buildBottomNavigationBarItem(),
              type: BottomNavigationBarType.fixed,
              currentIndex: _controller.selectIndex.value,
              elevation: 5.0,
              iconSize: 21.0,
              selectedFontSize: Dimens.font_sp10,
              unselectedFontSize: Dimens.font_sp10,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: isDark
                  ? Colours.dark_unselected_item_color
                  : Colours.unselected_item_color,
              onTap: (index) => _pageController.jumpToPage(index),
            )),

        // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 禁止滑动
          controller: _pageController,
          onPageChanged: (int index) => _controller.selectIndex.value = index,
          children: _pageList,
        ),
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }
}
