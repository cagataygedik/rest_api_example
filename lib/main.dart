import 'package:flutter/material.dart';
import 'package:restapitest/model/users_model.dart';
import 'package:restapitest/service/user_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  bool? isLoading;

  List<UsersModelData?> users = [];

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restfull API Test',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Restfull API Test',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading == true
                ? ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            users[index]!.firstName! + users[index]!.lastName!),
                        subtitle: Text(users[index]!.email!),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index]!.avatar!),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Bir sorun oluştu.."),
                  ),
      ),
    );
  }
}
