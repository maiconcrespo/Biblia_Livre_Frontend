import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * Devolve o texto passado como parâmetro, retirand os trechos entre [], ou seja,
 * as observações, referências e traduções alteranativas.
 **/

String cleanVerse(String verse) {
  if (verse == null) return "";

  List<String> listChars = verse.split("");
  List<String> newVerse = [];
  bool isReference = false;

  listChars.forEach((f) {
    if (f == "[") {
      isReference = true;
    } else if (f == "]") {
      isReference = false;
    } else if (!isReference) {
      if (newVerse.isEmpty || !(newVerse.last == " " && f == " ")) {
        newVerse.add(f);
      }
    }
  });
  return newVerse.join("");
}

/**
 * Devolve o texto passado como parâmetro, acrescido da tag <bold>
 *
 **/
String textTagged(String text, String term) {
  if (term.isEmpty) return text;

  List<String> terms = term.trim().split(" ");

  terms.forEach((part) {
    String termLC = part.toLowerCase();

    List<String> spanList = text.toLowerCase().split(termLC);
    int i = 0;
    String textTemp = "";

    spanList.forEach((v) {
      if (v.isNotEmpty) {
        textTemp += text.substring(i, i + v.length);
        i += v.length;
      }
      if (i < text.length) {
        textTemp += "<bold>${text.substring(i, i + part.length)}</bold>";
        i += part.length;
      }
    });
    text = textTemp;
  });
  return text;
}

Widget centerText(String msg, {color: Colors.redAccent, size: 14.0}) {
  return Center(
    child: Text(
      msg,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

String trunk(String text, length) {
  List<String> ret = [];
  int max = 0;

  List list = text.split(" ");

  list.forEach((l) {
    int len = l.length;
    if ((max + len) < length) {
      ret.add("$l ");
      max += len;
    } else {
      max = length;
    }
  });

  return "${ret.join("")}...";
}

String dotAtEnd(String txt) {
  String firstChar = txt.substring(0, 1);
  txt = txt.substring(1, txt.length - 1);
  txt = "${firstChar.toUpperCase()}$txt.";
  return cleanVerse(txt);
}
