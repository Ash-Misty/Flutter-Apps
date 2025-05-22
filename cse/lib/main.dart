// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
void main()
{
  runApp(MaterialApp(home:StudentDetail(),debugShowCheckedModeBanner:false ));
}
// ignore: use_key_in_widget_constructors
class StudentDetail extends StatefulWidget{
  @override
  State<StudentDetail>  createState() =>_StudentDetailState();
}
class _StudentDetailState extends State<StudentDetail>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold( 
      backgroundColor:const Color.fromARGB(255, 246, 250, 123),
      appBar:AppBar(title:Text('CSE-A'),
      backgroundColor: Colors.orange[400],
      titleTextStyle:TextStyle(
        color:Colors.black87,fontSize:20,fontWeight:FontWeight.bold),
        centerTitle:true,elevation:0.0
    ),
    floatingActionButton: TextButton(
      onPressed: (){},
      style:TextButton.styleFrom(
        backgroundColor:Colors.blue,
        foregroundColor:Colors.white,
        padding:EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
        shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
      ),
      child:Text('Next',style:TextStyle(fontSize:16.0),
      )
      ),
      body:Padding(padding:const EdgeInsets.fromLTRB(30.0,40.0,30.0,0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text('STUDENT INFORMATION',style:TextStyle(color:Colors.green,letterSpacing:2.0,fontSize:15.0,fontWeight: FontWeight.bold),),
          SizedBox(height:10.0),
          Center(child: ClipOval(child: Image.asset('asserts/ash.jpg',
          width:80,height:80,fit:Boxfit.cover),),),
          Divider (height:60.0,color:Colors.black),
          Text('Name',style:TextStyle(color:const Color.fromARGB(255, 72, 5, 40),letterSpacing:2.0,fontSize:15.0,fontWeight: FontWeight.bold),),
          SizedBox(height:10.0),
          Text('Ashini',style:TextStyle(color:const Color.fromARGB(255, 202, 71, 139),letterSpacing:2.0,fontSize:20.0,fontWeight: FontWeight.bold),),
          SizedBox(height:10.0),
          Text('Register Nmber',style:TextStyle(color:const Color.fromARGB(255, 72, 5, 40),letterSpacing:2.0,fontSize:15.0,fontWeight: FontWeight.bold),),
          SizedBox(height:10.0),
          Text('810023104002',style:TextStyle(color:const Color.fromARGB(255, 202, 71, 139),letterSpacing:2.0,fontSize:20.0,fontWeight: FontWeight.bold),),
          SizedBox(height:10.0),
         Row(children: [
          Icon(Icons.mail,color:Colors.grey[900]),
          SizedBox(width:10.0),
          Text('ash@gmail.com',style:TextStyle(color:const Color.fromARGB(255, 200, 52, 190),letterSpacing:2.0,fontSize:20.0,fontWeight:FontWeight.bold),),  
         ],)
                  ]
      )
    )
    );
}


}

class Boxfit {
  static var cover;
}
