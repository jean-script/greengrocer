import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-#### ',
    filter: {'#': RegExp(r'[0-9]')},
  );

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
        children: [
          // email
          CustomTextField(
            icon: Icons.email,
            label: 'Email',
            initialValue: appData.user.email,
            readOnly: true,
          ),

          // nome
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: appData.user.name,
            readOnly: true,
          ),
          //celular
          CustomTextField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: appData.user.phone,
            readOnly: true,
            inputFormatters: [phoneFormatter],
          ),
          //cpf
          CustomTextField(
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
            initialValue: appData.user.cpf,
            readOnly: true,
            inputFormatters: [cpfFormatter],
          ),

          //botão de atualizar

          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                updadePassword();
              },
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(
                    color: Colors.green,
                  )),
              child: const Text('Atualizar senha'),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> updadePassword() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // titulo
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Atualização de senha',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // senha atual
                      const CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                      ),
                      // Nova senha
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        isSecret: true,
                      ),
                      //Confirmar senha
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar senha',
                        isSecret: true,
                      ),
                      // botão de cornfirmar

                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Atualizar'),
                        ),
                      ),
                    ],
                  ),
                ),

                // botão de fechar
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          );
        });
  }
}
