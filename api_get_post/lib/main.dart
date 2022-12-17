import 'package:api_get_post/service/user_service.dart';
import 'package:flutter/material.dart';
import 'model/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();

  final nameController = TextEditingController();
  final jobController = TextEditingController();
  //  final gonderilecekData = {"name": nameController.text, "job": jobController.text};

  UsersModel? gelenData;
  bool isLoading = false;
  bool isError = false;

  void apiyiCagir() {
    setState(() {
      isLoading = true;
    });
    _service.fetch().then((value) {
      if (value != null) {
        setState(() {
          gelenData = value;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    apiyiCagir();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material app',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'API İLE GET VE POST İŞLEMLERİ',
            style: TextStyle(fontSize: 19),
          )),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isError == true
                ? const Center(
                    child: Icon(
                      Icons.error,
                      size: 72,
                      color: Colors.red,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Name:",
                          ),
                        ),
                        TextField(
                          controller: jobController,
                          decoration: const InputDecoration(
                            labelText: "Job:",
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              _service.postIslemi().then((value) {
                                if (value == true) {
                                  print(
                                      "Veriler başarılı bir şekilde gönderildi");
                                } else {
                                  print(
                                      "Veriler gönderme işlemi başarısız oldu");
                                }
                              });
                            },
                            child: const Text("Verileri Gönder")),
                        Expanded(
                          child: ListView.builder(
                            itemCount: gelenData?.data?.length ?? 0,
                            itemBuilder: ((context, index) {
                              final item = gelenData?.data?[index];
                              return ListTile(
                                title:
                                    Text(item?.firstName ?? "İsim boş geldi"),
                                subtitle: Text(item?.email ?? "İsim boş geldi"),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(item?.avatar ?? ""),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
