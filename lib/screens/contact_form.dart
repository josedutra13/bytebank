import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/widget/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('New contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
              style: const TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountController,
                decoration: const InputDecoration(labelText: 'Account number'),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        final String name = _nameController.text;
                        final int accountNumber =
                            int.tryParse(_accountController.text)!;
                        final nContact = Contact(
                            name: name, accountNumber: accountNumber, id: 0);
                        _save(dependencies.contactDao, nContact, context);
                      },
                      child: const Text('Create'))),
            )
          ],
        ),
      ),
    );
  }

  void _save(
      ContactDao contactDao, Contact nContact, BuildContext context) async {
    var response = await contactDao.save(nContact);
    print(response.toString());
    Navigator.pop(context, nContact);
  }
}
