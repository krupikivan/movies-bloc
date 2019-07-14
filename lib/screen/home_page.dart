import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/movie/movie_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_provider.dart';
import 'package:flutter_movies/bloc/navbar/navbar_bloc.dart';
import 'package:flutter_movies/model/filter.dart';
import 'package:flutter_movies/model/movie_list.dart';
import 'package:flutter_movies/screen/tabs/favorite_list_view.dart';
import 'package:flutter_movies/screen/tabs/movie_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Filter _selectedFilter = filter[0];
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

  @override
  Widget build(BuildContext context) {
    final _movieBloc = MovieProvider.of(context);
    return StreamBuilder<String>(
        stream: _navbarBloc.titleOut,
        initialData: _selectedFilter.title,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data),
              actions: <Widget>[
                _buildPopupMenu(context, _movieBloc),
              ],
            ),
            body: _buildBody(context, _movieBloc),
            bottomNavigationBar: _buildBottomNavigationBar(context),
          );
        }
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

  Widget _buildPopupMenu(BuildContext context, _movieBloc) {
    return PopupMenuButton(
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
        _movieBloc.inputFiltes.add(newValue);
        _navbarBloc.titleIn.add(newValue.title);
      },
    );
  }

  Widget _buildInicio(BuildContext context, MovieBloc _movieBloc) {
    return StreamBuilder<Filter>(
        stream: _movieBloc.outputFilters,
        initialData: _selectedFilter,
        builder: (context, AsyncSnapshot<Filter> snapFilter) {
          return _buildMoviesByFilter(context, _movieBloc);
        }
    );
  }

  Widget _buildFavoritos(BuildContext context) {
    return Container(
        padding: new EdgeInsets.all(5.0),
        child: FavoriteListView()
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return StreamBuilder(
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
    );
  }

  Widget _buildBody(BuildContext context, MovieBloc _movieBloc) {
    return StreamBuilder<NavbarItem>(
      stream: _navbarBloc.itemStream,
      initialData: _navbarBloc.defaultItem,
      builder: (BuildContext context, AsyncSnapshot<NavbarItem> snapshot) {
        switch (snapshot.data) {
          case NavbarItem.INICIO:
            return _buildInicio(context, _movieBloc);
          case NavbarItem.FAVORITOS:
            return _buildFavoritos(context);
        }
      },
    );
  }

  Widget _buildMoviesByFilter(BuildContext context, MovieBloc _movieBloc) {
    return StreamBuilder<MovieList>(
      stream: _movieBloc.outputMovies,
      builder: (BuildContext context, AsyncSnapshot<MovieList> snapshot) {
        return Container(
            padding: new EdgeInsets.all(5.0),
            child: MovieListView(
              listItems: snapshot,
            )
        );
      },
    );
  }
}
