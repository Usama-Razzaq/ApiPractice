import 'package:flutter/material.dart';

import 'fetch_Services/api_service.dart';

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  State<ApiExample> createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {
final ApiService apiService = ApiService();
 List<dynamic> posts = [];
bool isLoading = true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

Future<void> fetchPosts() async{
  try{
    final data = await apiService.fetchData();
    setState(() {
      posts = data;
      isLoading = false;
    });

  }catch(e){
    setState(() {
      isLoading = false;
    });
    debugPrint("Error; $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts[index]['id'].toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        posts[index]["title"],
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey, overflow: TextOverflow.clip),
                      )),
                    ],
                  ),
                  subtitle: Text(posts[index]["body"]),
                );
              }),
    );
  }
}
