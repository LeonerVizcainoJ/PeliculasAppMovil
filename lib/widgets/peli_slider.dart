import 'dart:ffi';

import 'package:aplicacion_peliculas/modelos/peliculas.dart';
import 'package:flutter/material.dart';

class PeliSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const PeliSlider({Key? key,
  required this.movies,
  this.title, 
  required this.onNextPage,}) : 
  super(key: key);

  @override
  _PeliSliderState createState() => _PeliSliderState();
}

class _PeliSliderState extends State<PeliSlider> {

  final ScrollController scrollController = new ScrollController();

  
  @override
  void initState() { 
    super.initState();

    scrollController.addListener(() {

      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
      
      widget.onNextPage();

      }

    });
  }

  @override
  void dispose() { 
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

         if(this.widget.title != null) 
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          
          ),

          Expanded(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: ( _, int index) => _PeliPoster( widget.movies[index], '${widget.title}-$index-${widget.movies[index].id}')
            )
          )
        ],
      ),
    );
  }
}

class _PeliPoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _PeliPoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {

  movie.heroId = heroId;


  return  Container(
   width: 130,
   height: 190,
   margin: EdgeInsets.symmetric(horizontal: 10,),
   child: Column(
   children: [

     GestureDetector(
       onTap: () => Navigator.pushNamed(context, 'detalle', arguments: movie),
         child: Hero(
           tag: movie.heroId!,
           child: ClipRRect(
           borderRadius: BorderRadius.circular(20),
           child: FadeInImage(
           placeholder: AssetImage('assets/no-image.jpg'), 
           image: NetworkImage(movie.fullPosterImg),
           width: 130,
           height: 190,
           fit: BoxFit.cover,
           ),
       ),
         ),
     ),

     SizedBox( height: 5),

     Text(
       movie.title,
       maxLines: 2,
       overflow: TextOverflow.ellipsis,
       textAlign: TextAlign.center,
     )

    ],
   ),
   );
  }
}