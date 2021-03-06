import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/books_bloc/books_bloc.dart';
import 'package:library_app/data/model/category.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemBookCategory.dart';

class CategoryBookHomePage extends StatefulWidget {
  final String category;
  CategoryBookHomePage({@required this.category});
  @override
  _CategoryBookHomePageState createState() => _CategoryBookHomePageState();
}

class _CategoryBookHomePageState extends State<CategoryBookHomePage>
    with TickerProviderStateMixin {
  final _bookBloc = BooksBloc();
  GlobalKey bookKey = GlobalKey();
  TabController _controller;

  final List<Tab> myTabs = <Tab>[
    Tab(text: categoryList[0].name),
    Tab(text: categoryList[1].name),
    Tab(text: categoryList[2].name),
    Tab(text: categoryList[3].name),
    Tab(text: categoryList[4].name),
    Tab(text: categoryList[5].name),
    Tab(text: categoryList[6].name),
    Tab(text: categoryList[7].name),
    Tab(text: categoryList[8].name),
    Tab(text: categoryList[9].name),
    Tab(text: categoryList[10].name),
    Tab(text: categoryList[11].name),
    Tab(text: categoryList[12].name),
    Tab(text: categoryList[13].name),
    Tab(text: categoryList[14].name),
  ];

  @override
  void initState() {
    _controller = TabController(length: categoryList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _bookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.grey[100],
            ),
          ),
          // appbar
          Positioned(
              top: 0,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              child: AppBarApp(
                buttonBack: 1,
                width: screenWidth,
                height: screenHeight,
                title: "Categories",
              )),
          // tabbar
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: screenWidth * 0.06),
              height: screenHeight * 0.08,
              child: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  labelColor: Colors.purple[900],
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                  indicatorColor: Colors.purple,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: myTabs),
            ),
          ),
          // contain
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: containPage(screenHeight, screenWidth),
          )
        ],
      ),
    );
  }

  Widget containPage(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.8,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Column(
        children: <Widget>[
          // search
          search(screenHeight, screenWidth),
          SizedBox(height: screenHeight * 0.02),
          // tabbar view
          tabbarView(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget tabbarView(double screenWidth, double screenHeight) {
    return Container(
        width: screenWidth,
        height: screenHeight * 0.64,
        child: TabBarView(controller: _controller, children: [
          gridViewWG(screenWidth, screenHeight, categoryList[0].name),
          gridViewWG(screenWidth, screenHeight, categoryList[1].name),
          gridViewWG(screenWidth, screenHeight, categoryList[2].name),
          gridViewWG(screenWidth, screenHeight, categoryList[3].name),
          gridViewWG(screenWidth, screenHeight, categoryList[4].name),
          gridViewWG(screenWidth, screenHeight, categoryList[5].name),
          gridViewWG(screenWidth, screenHeight, categoryList[6].name),
          gridViewWG(screenWidth, screenHeight, categoryList[7].name),
          gridViewWG(screenWidth, screenHeight, categoryList[8].name),
          gridViewWG(screenWidth, screenHeight, categoryList[9].name),
          gridViewWG(screenWidth, screenHeight, categoryList[10].name),
          gridViewWG(screenWidth, screenHeight, categoryList[11].name),
          gridViewWG(screenWidth, screenHeight, categoryList[12].name),
          gridViewWG(screenWidth, screenHeight, categoryList[13].name),
          gridViewWG(screenWidth, screenHeight, categoryList[14].name),
          // Placeholder(),
          // Placeholder(),
        ]));
  }

  Widget search(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.07,
      width: screenWidth,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: screenHeight * 0.01),
          prefixIcon: Icon(
            Icons.search,
            size: 23,
          ),
          hintText: "Search here",
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey[800]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
      ),
    );
  }

  Widget gridViewWG(double screenWidth, screenHeight, String category) {
    return BlocProvider(
      create: (context) =>
          _bookBloc..add(LoadBookCategoryEvent(category: category)),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) {},
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            if (state is LoadedBookState) {
              return GridView.builder(
                itemCount: state.bookList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookPage(
                              book: state.bookList[index],
                            ),
                          ),
                        );
                      },
                      child: ItemBookCategory(
                          width: screenWidth,
                          height: screenHeight,
                          itemBook: state.bookList[index],
                          function: (v) {
                            v
                                ? BlocProvider.of<BooksBloc>(context).add(
                                    LoadBookCategoryEvent(category: category))
                                : BlocProvider.of<BooksBloc>(context).add(
                                    LoadBookCategoryEvent(category: category));
                          }));
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
