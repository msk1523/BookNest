import 'package:boookie/pages/ticket_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String collectionName;
  final String documentId;

  const Details(
      {Key? key, required this.collectionName, required this.documentId})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Stream<DocumentSnapshot> getContentDetails() {
    return FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(widget.documentId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E251A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              StreamBuilder<DocumentSnapshot>(
                stream: getContentDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(
                        child: Text(
                      "No content available.",
                      style: TextStyle(color: Colors.white),
                    ));
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data['description'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            if (data['imageURL'] != null)
                              Image.network(
                                data['imageURL'],
                                height: 150,
                                width: 150,
                              ),
                            if (data['price'] != null)
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Price: ${data['price']}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              if (widget.collectionName == 'event_content' ||
                  widget.collectionName == 'book_content')
                StreamBuilder<DocumentSnapshot>(
                    stream: getContentDetails(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () {
                          final data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TicketPage(
                                        eventName: data['title'] ?? 'Event',
                                        eventPrice:
                                            data['price'] ?? "Not Mentioned",
                                      )));
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Buy This",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
