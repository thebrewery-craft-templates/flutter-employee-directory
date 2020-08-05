import 'package:flutter/material.dart';

class ScrollableListWithHeader extends StatefulWidget {
  final List<ListItemData> list;
  final bool boldFirstText;
  final ScrollableListWithHeaderListener listener;

  ScrollableListWithHeader(this.list, {this.boldFirstText, this.listener});

  @override
  State<StatefulWidget> createState() {
    return _ScrollableListWithHeaderState(boldFirstText);
  }
}

class _ScrollableListWithHeaderState extends State<ScrollableListWithHeader> {
  bool boldFirstText = true;
  List<ListItemData> _list = [];
  List<dynamic> directoryList = [];
  ScrollableListWithHeaderListener _listener;

  _ScrollableListWithHeaderState(boldFirstText) {
    this.boldFirstText = boldFirstText;
  }

  @override
  void didUpdateWidget(ScrollableListWithHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.list != widget.list){
      _init();
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    prepSections();
    return ListView.separated(
        separatorBuilder: (context, index) => Container(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              height: 1.0,
              width: MediaQuery.of(context).size.width,
            ),
        itemCount: directoryList.length,
        itemBuilder: (context, index) {
          if (directoryList[index] is ListViewItem) {

            var item = directoryList[index];
            var itemName1 =
                extractBeforeSpace(item.listItemData.name)?? "";
            var itemName2 =
                extractAfterSpace(item.listItemData.name)?? "";
            var name = RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: '$itemName1',
                      style: boldFirstText
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : TextStyle(fontWeight: FontWeight.normal)),
                  new TextSpan(
                    text: itemName2,
                  ),
                ],
              ),
            );

            return ListTile(
              title: name,
              contentPadding: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 15.0, right: 10.0),
              leading: CircleAvatar(
                child: item.listItemData.imageUrl != null
                    ? ClipOval(
                        child: Image.network(
                            item.listItemData.imageUrl),
                      )
                    : Text(
                        '${itemName1.substring(0, 1).toUpperCase()}'
                        '${itemName2.substring(0, 1).toUpperCase()}'),
              ),
              onTap: _listener != null ? () {
                _listener.onListItemClick(item.listItemData.id, item.listItemData);
              } : null,
            );
          } else {

            return Container(
              color: Color.fromRGBO(225, 225, 225, 1),
              padding: EdgeInsets.all(15.0),
              child: Text(
                directoryList[index].header,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
        });
  }

  _init(){
    _list = widget.list;
    _listener = widget.listener;
  }

  prepSections() {
    List<String> sections = [];
    directoryList.clear();
    _list.sort((a, b) => a.name.compareTo(b.name));
    _list.forEach((item) {

      String firstChar = item.name.substring(0, 1);
      if (sections != null && sections.length > 0) {
        String sec = sections[sections.length - 1];
        if (sec == firstChar) {
          directoryList.add(ListViewItem(item));
        } else {
          sections.add(firstChar);
          directoryList.add(ListViewHeader(firstChar));
          directoryList.add(ListViewItem(item));
        }
      } else {
        sections.add(firstChar);
        directoryList.add(ListViewHeader(firstChar));
        directoryList.add(ListViewItem(item));
      }
    });
  }

  String extractBeforeSpace(String text) {
    List<String> textBeforeString = text.split(" ");
    return textBeforeString[0] + " ";
  }

  String extractAfterSpace(String text) {
    List<String> textAfterString = text.split(" ");

    String textCreated = "";
    for (int i = 1; i < textAfterString.length; i++) {
      textCreated += textAfterString[i] + " ";
    }

    return textCreated;
  }

  addListener(ScrollableListWithHeaderListener listener) {
    this._listener = listener;
  }
}

class ListViewItem {
  final ListItemData listItemData;

  ListViewItem(this.listItemData);
}

class ListViewHeader {
  final String header;

  ListViewHeader(this.header);
}

class ListItemData {
  String name;
  String imageUrl;

  ListItemData(this.name, this.imageUrl);
}

class ScrollableListWithHeaderListener {
  void onListItemClick(String id, dynamic item) {}
}
