import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/api/api_models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagsBox extends StatefulWidget {
  const TagsBox();

  @override
  _TagsBoxState createState() => _TagsBoxState();
}

class _TagsBoxState extends State<TagsBox> {
  List<String> tags = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    try {
      tags = (await Api.tagsGet(context, TagsGetRequest())).tags;
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFF3F3F3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.tagsTitle),
            const SizedBox(height: 10),
            if (isLoading) const Text('Loading tags...'),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: tags
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF818A91),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        e.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          height: 0.5,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
