import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title,decription,buttonText;
  final Widget image;

  const AppDialog({Key? key,required this.title,
  required this.decription,
  required this.buttonText,
  required this.image,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
                  backgroundColor: Colors.grey[800],
                  elevation: 8,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ) ,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          decription,
                          textAlign: TextAlign.center,
                        ),
                        
                      ),
                      if(image!=null)image else Image.network("https://www.themoviedb.org/assets/2/v4/marketing/sheldon-1a29d9f7807771f061c5a3799a61ed2f0a84505553c70fc99719df02335d9746.png"),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                       child:Text(buttonText,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),) ,
                      ),
                    ],
                    ),
                );
  }
}