import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/book_controller.dart';
import 'package:flutter_application_2/view/image_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? bookDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookDetail = Provider.of<BookController>(context, listen: false);
    bookDetail!.FetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Book")),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<BookController>(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context, controller, child) => Container(
              child: bookDetail!.detailBook == null
                  ? child
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageViewScreen(
                                      ImageUrl: bookDetail!.detailBook!.image!,
                                    ),
                                  )),
                              child: Image.network(
                                bookDetail!.detailBook!.image!,
                                height: 150,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookDetail!.detailBook!.title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bookDetail!.detailBook!.subtitle!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(bookDetail!.detailBook!.authors!),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 12.0)),
                                    Row(
                                      children: List.generate(
                                          5,
                                          (index) => Icon(
                                                Icons.star,
                                                color: index <
                                                        int.parse(bookDetail!
                                                            .detailBook!
                                                            .rating!)
                                                    ? Colors.yellow
                                                    : Colors.grey,
                                              )),
                                    ),
                                    Text(
                                      bookDetail!.detailBook!.price!,
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.green),
                            ),
                            onPressed: () async {
                              Uri urlBook =
                                  Uri.parse(bookDetail!.detailBook!.url!);
                              try {
                                await launchUrl(urlBook);
                              } catch (e) {
                                // ignore: avoid_print
                                print(e);
                              }
                            },
                            child: const Text("BUY",
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(12.0),
                          child: Text(bookDetail!.detailBook!.desc!),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("ISBN : ${bookDetail!.detailBook!.isbn13!}"),
                              Text("Year : ${bookDetail!.detailBook!.year!}"),
                              Text("${bookDetail!.detailBook!.pages!} Page"),
                              Text(
                                  "Publisher : ${bookDetail!.detailBook!.publisher!}"),
                              Text(
                                  "Language : ${bookDetail!.detailBook!.language!}"),
                            ],
                          ),
                        ),
                        const Divider(),
                        bookDetail!.similiarBook == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                height: 140,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount:
                                      bookDetail!.similiarBook!.books!.length,
                                  itemBuilder: (context, index) {
                                    // ignore: non_constant_identifier_names
                                    final CurrentSimilarBook =
                                        bookDetail!.similiarBook!.books![index];
                                    return Container(
                                      width: 80,
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  DetailBookPage(
                                                    isbn: CurrentSimilarBook
                                                        .isbn13!,
                                                  )),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Image.network(
                                              CurrentSimilarBook.image!,
                                              height: 100,
                                            ),
                                            Text(
                                              CurrentSimilarBook.title!,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const Divider(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
