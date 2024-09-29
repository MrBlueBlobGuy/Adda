// contact_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart'; // Import the Contact class

class ContactScreen extends StatefulWidget {
  final Future<List<Contact>> Function() getContacts;

  ContactScreen({required this.getContacts});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    final contacts = await widget.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Contact'),
      ),
      body: _contacts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_contacts[index].displayName), // Use null-aware operator
                  subtitle: Text(_contacts[index].phones.first.number), // Use null-aware operator
                  onTap: () {
                    // Handle contact selection here
                    print('Selected contact: ${_contacts[index].displayName}');
                  },
                );
              },
            ),
    );
  }
}