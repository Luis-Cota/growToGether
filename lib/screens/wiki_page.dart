import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import '../database_manager/database_config_wiki.dart';
import '../model/wiki_item.dart';

class WikiPage extends StatelessWidget {
  final DatabaseConfig dbConfig = DatabaseConfig();

  WikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wiki (Solo Lectura)')),
      body: StreamBuilder<List<WikiItem>>(
        stream: dbConfig.getWikiStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar la Wiki: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay contenido en la Wiki.'));
          }

          final wikiItems = snapshot.data!;

          return ListView.builder(
            itemCount: wikiItems.length,
            itemBuilder: (context, index) {
              final item = wikiItems[index];
              final firstImageUrl = item.mediaUrls.isNotEmpty
                  ? item.mediaUrls[0]
                  : null;

              return ListTile(
                leading: firstImageUrl != null
                    ? Image.network(
                        firstImageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.menu_book),
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  item.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // Navegar a la vista detallada si es necesario
                },
              );
            },
          );
        },
      ),
    );
  }
}
