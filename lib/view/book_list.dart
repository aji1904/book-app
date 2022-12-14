import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/book_controller.dart';
import 'package:flutter_application_2/models/BookListResponse.dart';
import 'package:flutter_application_2/view/detail_book.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.FetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: Consumer<BookController>(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context, controller, child) => Container(
          child: bookController!.bookListResponse == null
              ? child
              : ListView.builder(
                  itemCount: bookController!.bookListResponse!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook =
                        bookController!.bookListResponse!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => DetailBookPage(
                                  isbn: currentBook.isbn13!,
                                )),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.network(
                            currentBook.image!,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentBook.title!),
                                  Text(currentBook.subtitle!),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(currentBook.price!)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
