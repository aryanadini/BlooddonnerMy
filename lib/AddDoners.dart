

import 'package:flutter/material.dart';

import 'MyDBManager.dart';
import 'Mydonners.dart';

class AddDonners extends StatefulWidget {
  const AddDonners({super.key});

  @override
  State<AddDonners> createState() => _AddDonnersState();
}

class _AddDonnersState extends State<AddDonners> {

  String dropdownvalue = 'gender';
  var items = [
    'male',
    'female',
    'other',

  ];
String dropdownbgvalue='bgroup';

var bgitems=['A+','A-','B+','B-','O+','O-'];

  final DBBdonnerManager dbBdonnerManager = DBBdonnerManager();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _bgroupController=TextEditingController();
  final _phoneController=TextEditingController();
  final _emailController=TextEditingController();
  final _genderController=TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Bdonner? bdonner;
  late int updateindex;

  late List<Bdonner> bdonnerlist;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Donners Details'),),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    controller: _nameController,
                    validator: (val) =>
                    val!.isNotEmpty ? null : "Name Should not be Empty",
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Age"),
                    controller: _ageController,
                    validator: (val) =>
                    val!.isNotEmpty ? null : "age Should not be Empty",
                  ),

                     TextFormField(
                      decoration: InputDecoration(labelText: "Gender"),
                      controller: _genderController,
                      validator: (val) =>
                      val!.isNotEmpty ? null : "gender Should not be Empty",
                    ),


                     TextFormField(
                      decoration: InputDecoration(labelText: "bgroup"),
                      controller: _bgroupController,
                      validator: (val) =>
                      val!.isNotEmpty ? null : "Phone Should not be Empty",
                    ),
                
                  TextFormField(
                    decoration: InputDecoration(labelText: "Phone"),
                    controller: _phoneController,
                    validator: (val) =>
                    val!.isNotEmpty ? null : "Phone Should not be Empty",
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    controller: _emailController,
                    validator: (val) =>
                    val!.isNotEmpty ? null : "Email Should not be Empty",
                  ),

                  ElevatedButton(

                    child: Container(
                        width: width * 0.9,
                        child: Text(
                          "Add",
                          textAlign: TextAlign.center,
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          Mydonners()));
                      submitBdonner(context);
                    },
                  ),
                  // FutureBuilder(
                  //   future: dbBdonnerManager.getBdonnerList(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       bdonnerlist = snapshot.data as List<Bdonner>;
                  //       return ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: bdonnerlist == null ? 0 : bdonnerlist.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           Bdonner bd = bdonnerlist[index];
                  //           return Card(
                  //             elevation: 50,
                  //
                  //             color: Colors.greenAccent[100],
                  //             child: Row(
                  //               children: <Widget>[
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(16.0),
                  //                   child: SizedBox(
                  //                     width: width * 0.50,
                  //                     child: Column(
                  //                       children: <Widget>[
                  //                         Text('ID: ${bd.id}',style: TextStyle(color: Colors.pinkAccent),),
                  //                         Text('Name: ${bd.name}',),
                  //                         Text('Gender: ${bd.gender}',),
                  //                         Text("Age:${bd.age}",),
                  //                         Text('Bldgroup:${bd.bgroup}',),
                  //                         Text('Phone:${bd.phone}',),
                  //                         Text('Email:${bd.email}',),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 IconButton(
                  //                   onPressed: () {
                  //                     _nameController.text = bd.name;
                  //                     _ageController.text=bd.age;
                  //                     _genderController.text=bd.gender;
                  //                     _phoneController.text = bd.phone;
                  //                     _emailController.text=bd.email;
                  //                     _bgroupController.text=bd.bgroup;
                  //                     bdonner = bd;
                  //                     updateindex = index;
                  //                   },
                  //                   icon: const Icon(
                  //                     Icons.edit,
                  //                     color: Colors.blue,
                  //                   ),
                  //                 ),
                  //                 IconButton(
                  //                   onPressed: () {
                  //                     dbBdonnerManager.deleteBdonner(bd.id);
                  //                     setState(() {
                  //                       bdonnerlist.removeAt(index);
                  //                     });
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.delete,
                  //                     color: Colors.red,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     }
                  //     return CircularProgressIndicator();
                  //   },
                  // )
                ],
              ),
            ),
          )
        ],
      ),



    );
  }
  void submitBdonner(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      if (bdonner == null) {
        Bdonner bd = Bdonner(
            name: _nameController.text,
            age: _ageController.text,
            gender:_genderController.text,
            bgroup: _bgroupController.text,
            phone: _phoneController.text,
            email: _emailController.text);
        dbBdonnerManager.insertBdonner(bd).then((value) =>
        {
          _nameController.clear(),
          _ageController.clear(),
          _genderController.clear(),
          _bgroupController.clear(),
          _phoneController.clear(),

          _emailController.clear(),
          print("Bdonner Data Add to database $value"),
        });
      }
      else {
        bdonner?.name = _nameController.text;
        bdonner?.age = _ageController.text;
        bdonner?.gender=_genderController.text;
        bdonner?.phone = _phoneController.text;
        bdonner?.bgroup = _bgroupController.text;
        bdonner?.email = _emailController.text;

        dbBdonnerManager.updateBdonner(bdonner!).then((value) {
          setState(() {
            bdonnerlist[updateindex].name = _nameController.text;
            bdonnerlist[updateindex].age = _ageController.text;
            bdonnerlist[updateindex].gender =  _genderController.text;
            bdonnerlist[updateindex].bgroup = _bgroupController.text;
            bdonnerlist[updateindex].phone = _phoneController.text;
            bdonnerlist[updateindex].email = _emailController.text;
          });
          _nameController.clear();
          _ageController.clear();
          _genderController.clear();
          _bgroupController.clear();
          _phoneController.clear();
          _emailController.clear();

          bdonner = null;
        });
      }
    }
  }
}
