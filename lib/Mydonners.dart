import 'package:blooddonner/AddDoners.dart';
import 'package:flutter/material.dart';
import 'MyDBManager.dart';
import 'package:url_launcher/url_launcher.dart';




class Mydonners extends StatefulWidget {
  const Mydonners({super.key});

  @override
  State<Mydonners> createState() => _MydonnersState();
}

class _MydonnersState extends State<Mydonners> {

  bool _hasCallSupport = false;
  Future<void>? _launched;
  String phone = '';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: 'phone')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  final DBBdonnerManager dbBdonnerManager = DBBdonnerManager();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _bgroupController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Bdonner? bdonner;
  late int updateindex;

  late List<Bdonner> bdonnerlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Donners"),
      ),
      body: FutureBuilder(
        future: dbBdonnerManager.getBdonnerList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bdonnerlist = snapshot.data as List<Bdonner>;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: bdonnerlist == null ? 0 : bdonnerlist.length,
              itemBuilder: (BuildContext context, int index) {
                Bdonner bd = bdonnerlist[index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Name: ${bd.name}',),
                  subtitle: Text('Bldgroup:${bd.bgroup}',),
                  trailing: IconButton(onPressed: () async {
                    final String phone_number = "${bd.phone}";
                    String phone = "phone:$phone_number";

                    if (await canLaunch(phone)) {
                      await
                      launch(phone);
                    } else {
                      throw "Can't phone that number.";
                    }
                  }, icon: Icon(Icons.call),),

                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                AddDonners()));
          }
      ),

    );
  }

}

