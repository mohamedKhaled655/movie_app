import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class DataSearch extends SearchDelegate{
  List<Movie> pop;
  List popularTitle;

  DataSearch({required this.pop,required this.popularTitle});



  List names=[
    "mohamed","ahmed","ali","said","khaled","wael","yasser","shady"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query="";
        },
        icon: Icon(Icons.close_outlined,),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    },
        icon: Icon(Icons.arrow_back_ios,),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(child: Text(query));
  }

  //محتوى البحث
  @override
  Widget buildSuggestions(BuildContext context) {

    //List filterNames=names.where((element) => element.contains(query)).toList();
    List filterTitle=popularTitle.where((element) => element.contains(query)).toList();
    // List<Movie>ff=pop.where((element) => element.title.startsWith(query)).toList();



    return ListView.builder(
        itemCount:(query.isEmpty)? pop.length:filterTitle.length,
        itemBuilder:(context,index){
          return InkWell(
            onTap: (){
              query=query.isEmpty?pop[index]:filterTitle[index];
              showResults(context);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 8),
             // child: Text((query.isEmpty)? names[index]:filterNames[index]),
              child:  Text((query.isEmpty)? pop[index].title:filterTitle[index]),
            ),
          );
        },
    );
  }
  
}