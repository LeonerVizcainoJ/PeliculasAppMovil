import 'package:aplicacion_peliculas/modelos/peliculas.dart';
import 'package:aplicacion_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';


class DetallePantalla extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    // TODO:
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    print(movie.title);
    
    
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [

         _CustomAppBar(movie),
         SliverList(
           delegate: SliverChildListDelegate([
         
         _Posterytitulo(movie),
         _Sobrevista(movie),
         _Sobrevista(movie),
         CarruselActor(movie.id),
         ]))
        ],
        
        )
  );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(this.movie);
  

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
    backgroundColor: Colors.blueGrey,
    floating: false,
    pinned: true,
    expandedHeight: 200,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      titlePadding: EdgeInsets.all(0),
      title: Text(movie.title,
      style: TextStyle(
        fontSize: 16),
        ),
        background: FadeInImage(
        placeholder: AssetImage('assets/loading.gif'), 
        image: NetworkImage(movie.fullBackdropPath),
        fit: BoxFit.cover,
      ),
    ),

    );
  }
}

class _Posterytitulo extends StatelessWidget {

  final Movie movie;

  const _Posterytitulo( this.movie);
  @override
  Widget build(BuildContext context) {

   final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
             ),
            ),
          ),
          
          SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width -190),
          
            child: Column(
              
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [

              
            Text(movie.title, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
            Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1,),
            
            Row(
              children: [
                Icon(Icons.star_border_outlined, size: 15, color: Colors.grey),
                SizedBox(width: 5),
                Text('${movie.voteAverage}', style: Theme.of(context).textTheme.caption,),
              ]
            )

            ],
            ),
          ),



        ],),
    );
  }
}

class _Sobrevista extends StatelessWidget {

  final Movie movie;

  const _Sobrevista(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}