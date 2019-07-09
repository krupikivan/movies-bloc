import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/favourite_page.dart';
import 'package:flutter_movies/src/bloc/movie/movie_provider.dart';
import 'package:flutter_movies/src/bloc/navbar/navbar_bloc.dart';
import 'package:flutter_movies/src/model/filter.dart';
import 'package:flutter_movies/src/ui/popular_movie_list.dart';



class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  NavbarBloc _navbarBloc;

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


  Filter _selectedFilter = filter[0];
  @override
  Widget build(BuildContext context) {
    final _movieBloc = MovieProvider.of(context);
    //final _navbarBloc = NavBarProvider.of(context);
    return Scaffold(
      body: StreamBuilder<NavbarItem>(
        stream: _navbarBloc.itemStream,
        initialData: _navbarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavbarItem> snapshot) {
          switch (snapshot.data) {
            case NavbarItem.INICIO:
              return StreamBuilder<Filter>(
                  stream: _movieBloc.outputFilters,
                initialData: _selectedFilter,
                builder: (context, AsyncSnapshot<Filter> snapFilter) {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(snapFilter.data.title),
                        actions: <Widget>[
                          new PopupMenuButton(
                              itemBuilder: (BuildContext context){
                                return filter.map((Filter filter){
                                  return new PopupMenuItem(
                                    value: filter,
                                    child: new ListTile(
                                      title: Text(filter.title),
                                    ),
                                  );
                                }).toList();
                              },
                            onSelected: (Filter newValue) {
                              // _popupBloc.addFilter(newValue);
                              _movieBloc.inputFiltes.add(newValue);
                            },
                          ),
                        ],
                      ),
                      body: PopularPage()
                  );
                }
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

