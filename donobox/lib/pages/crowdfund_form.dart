// import 'dart:convert' as convert;
import 'package:donobox/pages/crowdfunds.dart';
import 'package:donobox/drawer/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CrowdfundFormPage extends StatefulWidget {
  const CrowdfundFormPage({
    super.key,
    required this.loggedUsername,
    required this.loggedRole,
  });

  final String loggedUsername;
  final String loggedRole;

  @override
  State<CrowdfundFormPage> createState() => _CrowdfundFormPageState();
}

class _CrowdfundFormPageState extends State<CrowdfundFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? title = '';
  String? description = '';
  int target = 0;
  DateTime deadline = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4E4F),
        title: const Text('Galang Dana Baru')
      ),
      drawer: drawer(
        loggedUsername: widget.loggedUsername,
        loggedRole: widget.loggedRole,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    hintText: '1-50 karakter',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      title = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.length > 50) {
                      return 'Judul harus terdiri dari 1-50 karakter.';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: '0-1000 karakter',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      description = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.length > 1000) { // handle desc kosong nanti
                      return 'Deskripsi tidak melebihi 1000 karakter.';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Target Dana',
                    hintText: '1-1000000000 (tanpa tanda)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      target = (value == null || value.isEmpty) ? 0 : int.parse(value);
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      target = (value == null || value.isEmpty) ? 0 : int.parse(value);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty || int.parse(value) > 1000000000) {
                      return 'Target harus di antara 1 dan 1000000000.';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? value = await showDatePicker(
                      context: context,
                      initialDate: deadline,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (value == null) return;
                    setState(() => deadline = value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA2CC83),
                  ),
                  child: const Text('Batas Waktu Pengumpulan'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('Batas waktu harus melebihi saat ini.'),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate() && deadline.isAfter(DateTime.now())) {
                    //   final data = {
                    //     // 'fundraiser_name': widget.loggedUsername,
                    //     // 'title': title,
                    //     // 'description': (description == null) ? '' : description,
                    //     // 'target': target,
                    //     // 'deadlineYear': deadline.year,
                    //   };
                    //   final response = await request.post(
                    //     'https://pbp-c04.up.railway.app/crowdfund/flutter/funds/add/',
                    //     data,
                    //   );
                    //   if (response['status'] == 'success') {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => CrowdfundsPage(
                    //           loggedUsername: widget.loggedUsername,
                    //           loggedRole: widget.loggedRole,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA2CC83),
                  ),
                  child: const Text('Galang Dana'),
                ),
              ),
            ],
          )
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            backgroundColor: const Color(0xFFA2CC83),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CrowdfundsPage(
                  loggedUsername: widget.loggedUsername,
                  loggedRole: widget.loggedRole,
                ),
              ),
            );
          },
          child: const Text('Kembali'),
        ),
      ),
    );
  }
}