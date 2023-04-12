import 'package:flutter/material.dart';
import 'package:utils/utils.dart';
import 'package:widgets/widgets.dart';

import 'widgets/order_item.dart';
import 'widgets/order_tag_item.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with
        AutomaticKeepAliveClientMixin<OrderListPage>,
        ChangeNotifierMixin<OrderListPage> {
  final ScrollController _controller = ScrollController();
  final StateType _stateType = StateType.loading;

  /// 是否正在加载数据
  bool _isLoading = false;
  final int _maxPage = 3;
  int _page = 1;
  int _index = 0;
  List<String> _list = <String>[];

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    return {_controller: null};
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0,

        /// 默认40， 多添加的80为Header高度
        child: CustomScrollView(

            /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
            /// 这种方法的缺点是会重新layout列表
            /// TODO:
            // controller: _index != provider.index ? _controller : null,
            key: PageStorageKey<String>('$_index'),
            slivers: <Widget>[
              SliverOverlapInjector(
                ///SliverAppBar的expandedHeight高度,避免重叠
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: _list.isEmpty
                    ? SliverFillRemaining(child: StateLayout(type: _stateType))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return index < _list.length
                              ? (index % 5 == 0
                                  ? const OrderTagItem(
                                      date: '2021年2月5日', orderTotal: 4)
                                  : OrderItem(
                                      key: Key('order_item_$index'),
                                      index: index,
                                      tabIndex: _index,
                                    ))
                              : MoreWidget(_list.length, _hasMore(), 10);
                        }, childCount: _list.length + 1),
                      ),
              ),
            ]),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(10, (i) => 'newItem：$i');
      });
    });
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future<void> _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page++;
        _isLoading = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
