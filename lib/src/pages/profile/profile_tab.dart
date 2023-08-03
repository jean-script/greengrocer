import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil do usuário'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (c) {
                    return const SignInScreen();
                  }),
                );
              },
            ),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          children: const [
            // email
            CustomTextField(
              icon: Icons.email,
              label: 'Email',
              
            ),

            // nome
            CustomTextField(
              icon: Icons.person,
              label: 'Nome',
            ),
            //celular
            CustomTextField(
              icon: Icons.phone,
              label: 'Celular',
            ),
            //cpf
            CustomTextField(
              icon: Icons.file_copy,
              label: 'CPF',
              isSecret: true,
            ),
            //botão de atualizar
          ],
        ));
  }
}
