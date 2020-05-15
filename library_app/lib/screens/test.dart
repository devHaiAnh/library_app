import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];
  TabController _tabController;

  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    setState(() {
      _currentIndex = this._controller.index;
      print(_controller.index);
    });
    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.removeListener(onChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          
          tabs: myTabs,
          // onTap: (index) => _tabScope.setTabIndex(index),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Container(
          child: Center(
            child: Text("data"),
          ),
        ),
        Container(
          child: Center(
            child: Text("data"),
          ),
        ),
      ]),
    );
  }
}
