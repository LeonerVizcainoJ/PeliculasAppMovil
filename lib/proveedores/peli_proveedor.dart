//import 'dart:convert';

import 'dart:async';

import 'package:aplicacion_peliculas/ayudas/debouncer.dart';
import 'package:aplicacion_peliculas/modelos/creditos.dart';
import 'package:aplicacion_peliculas/modelos/peliculas.dart';
import 'package:aplicacion_peliculas/modelos/popular_response.dart';
import 'package:aplicacion_peliculas/modelos/response.dart';
import 'package:aplicacion_peliculas/modelos/search_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PelisProveedor extends ChangeNotifier {

  String _apiKey ='a7e054d7dbdb36e6dcfe5c34a308b6d4';
  String _baseUrl ='api.themoviedb.org';
  String _lenguaje = 'es-ES';
  
  List<Movie> enPantalla =[];
  List<Movie> popularMovies =[];

  Map<int, List<Cast>> movieCast = {};

  int _popularpage = 0;

  final deboncer = Debouncer(
  duration: Duration (milliseconds: 500) 
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  PelisProveedor(){

  print('PelisProveedor inicializado');

  this.getOnDisplayMovies();
  this.getPopularMovie();

  }

 Future <String> _getJsonData(String endpoint, [int page = 1]) async{
 final url = Uri.https(_baseUrl, endpoint, {
       'api_key':_apiKey,
       'lenguaje': _lenguaje,
       'page': '$page' 
       });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);
  return response.body;

 }
  
  getOnDisplayMovies() async{
     
   final jsonData = await this._getJsonData('3/movie/now_playing');
   final nowPlayingResponse =NowPlayingResponse.fromJson(jsonData);

   enPantalla = nowPlayingResponse.results;
  
  notifyListeners();

  }

  getPopularMovie() async{

    _popularpage++;

   final jsonData = await this._getJsonData('3/movie/popular', _popularpage );
   final popularResponse = PopularResponse.fromJson(jsonData);

  popularMovies = [...popularMovies,...popularResponse.results];

  
  notifyListeners();

  } 

  Future<List<Cast>> getMovieCaste(int movieId)async{

    if(movieCast.containsKey(movieId)) return movieCast[movieId]!;
  print('pidiendo info al servidor - Cast');

  final jsonData = await this._getJsonData('3/movie/$movieId/credits');
  final creditos = Creditos.fromJson(jsonData);

  movieCast[movieId] = creditos.cast;
  return creditos.cast;
  }
  Future<List<Movie>> searchMovies(String query) async{

  final url = Uri.https(_baseUrl, '3/search/movie', {
       'api_key':_apiKey,
       'lenguaje': _lenguaje,
       'query':  query,
       });

       final response = await http.get(url);
       final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;  

  }

   void getSuggetionsByQuery(String searchTerm){

     deboncer.value='';
     deboncer.onValue = (value) async{
     final results = await this.searchMovies(value);

     this._suggestionStreamController.add(results);
     };

     final timer = Timer.periodic(Duration(milliseconds: 300), (_) { 
       deboncer.value = searchTerm;
     });

     Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());

 }

}