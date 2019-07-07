import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/favourite_page.dart';
import 'package:flutter_movies/src/bloc/navbar_bloc.dart';
import 'package:flutter_movies/src/ui/popular_movie_list.dart';


class Filter{
  final Text title;
  final int id;
  const Filter({this.title, this.id});
}
const List<Filter> filter = <Filter> [
  const Filter(title: const Text('Mas populares'), id: 0),
  const Filter(title: const Text('Mas valoradas'), id: 1),
];

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  NavbarBloc _navbarBloc;
  Filter _selectedFilter = filter[0];

  void _selectedFilterMenu(Filter filter){
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  void initState() {
    super.initState();
    _navbarBloc = NavbarBloc();
  }

  @override
  void dispose() {
    _navbarBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NavbarItem>(
        stream: _navbarBloc.itemStream,
        initialData: _navbarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavbarItem> snapshot) {
          switch (snapshot.data) {
            case NavbarItem.INICIO:
              return Scaffold(
                  appBar: AppBar(
                    title: Text(_selectedFilter.title.data),
                    actions: <Widget>[
                      new PopupMenuButton(
                          itemBuilder: (BuildContext context){
                            return filter.map((Filter filter){
                              return new PopupMenuItem(
                                value: filter,
                                child: new ListTile(
                                  title: filter.title,
                                ),
                              );
                            }).toList();
                          },
                        onSelected: _selectedFilterMenu,
                      )
                    ],
                  ),
                  body: new PopularPage(id: _selectedFilter.id)
              );
            case NavbarItem.FAVORITOS:
              return Scaffold(
                  appBar: AppBar(
                    title: Text("Favoritos"),
                  ),
                  body: FavouritePage()
              );
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _navbarBloc.itemStream,
        initialData: _navbarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavbarItem> snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data.index,
            onTap: _navbarBloc.pickItem,
            items: _buildNavigationItems(),
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("Inicio"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text("Favoritos"),
      ),
    ];
  }
}

