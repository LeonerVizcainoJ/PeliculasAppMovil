



import 'package:aplicacion_peliculas/modelos/peliculas.dart';
import 'package:aplicacion_peliculas/proveedores/peli_proveedor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

 @override
  String get searchFieldLabel => 'Buscar Pelicualas';

  @override
  List<Widget> buildActions(BuildContext context) {
     return[
       IconButton(
       onPressed: () => query = '', 
       icon:Icon(Icons.clear)
       )
     ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back));
    }
  
    @override
    Widget buildResults(BuildContext context) {
     return Text('buildActions');
    }
  
    Widget _emtuContainer(){
      return Container(
        child: Center(child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
        )
      );
    }
     
    @override
    Widget buildSuggestions(BuildContext context) {


    if (query.isEmpty){
      return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
        )
      );
    }

    final moviesProvider = Provider.of<PelisProveedor>(context, listen: false);
    moviesProvider.getSuggetionsByQuery(query);
    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

       if(!snapshot.hasData) return _emtuContainer();
       
       

       final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index])
        );
      },
    );
  } 

}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
          child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain, 
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){

        Navigator.pushNamed(context,'detalle', arguments: movie);
      },
    );
  }
 
 void getSuggetionsByQuery(String searchTerm){

 }

}