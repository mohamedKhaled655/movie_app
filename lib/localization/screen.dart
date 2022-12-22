
import 'package:flutter/material.dart';

import 'app_localization.dart';
import 'languages.dart';
import 'translation_constants.dart';


class Screen extends StatelessWidget {
  const Screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:[
          for(int i=0;i<Languages.languages.length;i++)
          Text(Languages.languages.map((e) => e.value).toList().toString()),
        
        TextButton(
          onPressed:(){

          },
           child: Text(Languages.languages[0].value),
           ),

           TextButton(
          onPressed:(){
            
          },
           child: Text(Languages.languages[1].value),
           ),
      //  Text(AppLocalization.of(context)!.translate('language')),
        Text(AppLocalization.of(context)!.translate(TranslationConstants.soon)),
        ],
      ),
    );
  }
}