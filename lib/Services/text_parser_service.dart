import 'dart:convert';
import 'package:http/http.dart' as http;

class TextParsesService {
  Future addDocument(String imageURL) async {
    try {
      final String apiURL = "https://vision.googleapis.com/v1/images:annotate";


      //ios api key AIzaSyBfpzGcHiARgjy6LuECSCTAsBrbjB9FmD0
      //android api key AIzaSyAFG7YdS97Xz56BgF0rZvIJ3jv89IYBJLw

      final response = await http.post(Uri.parse(apiURL),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer AIzaSyBfpzGcHiARgjy6LuECSCTAsBrbjB9FmD0',
          },
          body: {
            "requests":[
              {
                "image":{
                  "source":{
                    "imageUri":
                    "$imageURL"
                  }
                },
                "features":[
                  {
                    "type":"LABEL_DETECTION",
                    "maxResults":1
                  }
                ]
              }
            ]
          }
      );

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {

      } else {
        return null;
      }
    } catch (Exception) {
      return null;
    }
  }
}
