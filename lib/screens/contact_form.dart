import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountController = TextEditingController();
  final _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
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
                        _contactDao
                            .save(nContact)
                            .then((id) => Navigator.pop(context));
                      },
                      child: const Text('Create'))),
            )
          ],
        ),
      ),
    );
  }
}
