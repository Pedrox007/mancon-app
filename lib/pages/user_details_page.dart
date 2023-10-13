import 'package:flutter/material.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/utils/secure_storage.dart';
import 'package:mancon_app/widgets/button.dart';
import 'package:mancon_app/widgets/line_card.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    User loggedUser = Provider.of<LoggedUser>(context, listen: false).user!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Detalhes do usuário",
          style: TextStyle(fontFamily: "inter", fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    radius: 65,
                    child: Icon(
                      Icons.person_outline,
                      size: 95,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("${loggedUser.firstName} ${loggedUser.lastName}",
                    style: const TextStyle(fontFamily: "inter", fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: LineCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text("Username: ",
                            style: TextStyle(
                                fontFamily: "inter",
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text(loggedUser.username,
                            style: const TextStyle(
                                fontFamily: "inter", fontSize: 18))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: LineCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text("Email: ",
                            style: TextStyle(
                                fontFamily: "inter",
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text(loggedUser.email,
                            style: const TextStyle(
                                fontFamily: "inter", fontSize: 18))
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Button(
                label: "Sair",
                onPressed: () {
                  SecureStorage storage = SecureStorage();
                  storage.deleteSecureData("access_token");
                  storage.deleteSecureData("refresh_token");
                  Provider.of<LoggedUser>(context, listen: false).logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (_) => false);
                },
                secondary: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
