import 'package:flutter/material.dart';
import 'package:donobox/pages/homepage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DateTime selectedDate = DateTime.now();
  String _convertedDate = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _convertedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
      });
    }
  }


  final _formKey = GlobalKey<FormState>();
  String _bio = "";
  String _phoneNumber = "";
  String _birthDay = "";
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3F4E4F),
          title: const Text('Hi, username!'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_active,
                color: Color(0xFF879999),
                size: 30,),
              tooltip: 'Notification',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
        ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "",
                      labelText: "Bio",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.people),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    // Menambahkan behavior saat email diketik
                    onChanged: (String? value) {
                      setState(() {
                        _bio = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _bio = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "08123456789",
                      labelText: "Phone Number",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.phone),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    // Menambahkan behavior saat phone diketik
                    onChanged: (String? value) {
                      setState(() {
                        _phoneNumber = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _phoneNumber = value!;
                      });
                    },

                  ),
                ),

                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "dono@donobox.com",
                      labelText: "Email",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.mail),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    // Menambahkan behavior saat email diketik
                    onChanged: (String? value) {
                      setState(() {
                        _email = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _email = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 20.0,),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                            child: Container(
                              child: ListView(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Center(child: const Text("Profile Updated!")),
                                  Text('Phone Number : ' + _phoneNumber),
                                  Text('Email : ' + _email),
                                  Text('Birthday : ' + _convertedDate),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Kembali'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    }
                  },
                ),
              ],
            ),
          ),
        ),

      )
    );
  }
}