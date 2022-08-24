import 'package:flutter/material.dart';
import 'package:test/pages/past_launch_page.dart';
import 'package:test/pages/upcoming_launch_page.dart';

enum TabItem {
  upcoming,
  past,
}

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController? _tabController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: selectedIndex,
      length: TabItem.values.length, 
      vsync: this,
    );
    _tabController!.addListener(_tabControllerListener);
  }

  _tabControllerListener() {
    if (_tabController!.index != selectedIndex) {
      _tabController!.animateTo(selectedIndex);
    }
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updatePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        index: selectedIndex,
        children: [
          for (var tabItem in TabItem.values)
            TabHelper.tabPage(tabItem),
        ],
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: selectedIndex,
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              for (var tabItem in TabItem.values)
                _buildBottomNavigationBarItem(context, tabItem)
            ],
            onTap: (int index) {
              _updatePage(index);
              _tabController!.animateTo(index);
            }
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    BuildContext context,
    TabItem tabItem,
  ) {
    return BottomNavigationBarItem(
      label: TabHelper.label(tabItem),
      icon: Icon(
          TabHelper.getIcon(tabItem),
          // color: colorWhite.withOpacity(0.65),
        ),
      activeIcon: Icon(
          TabHelper.getIcon(tabItem),
          // color: colorWhite
        )
    );
  }

}

class TabHelper {

  static Widget tabPage(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.upcoming:
        return const UpcomingLaunchPage();
      case TabItem.past:
        return const PastLaunchPage();
      default:
        return const UpcomingLaunchPage();
    }
  }

  static String label(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.upcoming:
        return 'Upcoming';
      case TabItem.past:
        return 'Past';
      default:
        return 'Upcoming';
    }
  }
  
  static IconData getIcon(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.upcoming:
        return Icons.rocket_launch;
      case TabItem.past:
        return Icons.update_outlined;
      default:
        return Icons.rocket_launch;
    }
  }
}