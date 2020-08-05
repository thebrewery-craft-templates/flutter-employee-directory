import 'package:flutter/material.dart';

import 'widgets/recent_search_tile.dart';
import 'widgets/search_result_tile.dart';
import '../../models/employee.dart';
import '../../screens/directory/directory_provider.dart';
import '../../screens/profile/profile_screen.dart';
import '../../utils/routes.dart';
import '../../widgets/brewery/brewery_searchbar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> implements DirectoryProviderListener{
  List _recents = <String>[
    'Sarah Lim',
    'Mylene Bayan',
    'Catriona Gray',
    'Chuck Reyes'
  ];

  bool _isSearching = false;
  List _items = <Employee>[];
  List _employeeList = <Employee>[];

  DirectoryProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = DirectoryProvider(this);
    _provider.getAllEmployees(context);

    _items.addAll(_employeeList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrewerySearchBar(
        hintText: 'Search',
        cursorColor: Colors.yellow,
        textTheme: TextTheme(
            title: TextStyle(color: Colors.yellow),
            caption: TextStyle(color: Colors.yellow)),
        iconTheme: IconThemeData(color: Colors.yellow),
        onClear: () {},
        onTextChanged: (text) {
          filterSearchResults(text);
        },
        hintStyle: TextStyle(fontSize: 20.0),
        backgroundColor: Colors.black,
      ),
      body: _isSearching ? _buildResultsList() : _buildRecentSearchesList(),
    );
  }

  Widget _buildRecentSearchesList() {
    return ListView.builder(
      itemCount: _recents.length,
      itemBuilder: (context, index) {
        return RecentSearchTile(
          text: _recents[index],
        );
      },
    );
  }

  Widget _buildResultsList() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        var firstname = "";
        var lastname = "";
        if (_items != null && _items[index] is Employee) {
          Employee item = _items[index];
          firstname = _items[index].firstName;
          lastname = _items[index].lastName;

        }
        return SearchResultTile(
          text: '$firstname $lastname',
          onTap: () {
            Employee employee = Employee(
                _items[index].id,
                _items[index].firstName,
                _items[index].lastName,
                _items[index].primaryNumber,
                _items[index].primaryEmail,
                _items[index].position,
                imageUrl: _items[index].imageUrl);
            Navigator.popAndPushNamed(context, Routes.profile,
                arguments:
                    ProfileArguments(employee: employee, enableEdit: false));
          },
        );
      },
    );
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Employee> searchedList = [];
      _employeeList.forEach((item) {
        if (item is Employee) {
          if (item.firstName != null && item.lastName != null) {
            String fullName = '${item.firstName} ${item.lastName}';
            if (fullName.toLowerCase().contains(query.toLowerCase())) {
              searchedList.add(item);
            }
          }
        }
      });
      setState(() {
        _isSearching = true;
        _items.clear();
        _items.addAll(searchedList);
      });
      return;
    } else {
      setState(() {
        _isSearching = false;
        _items.clear();
        _items.addAll(_employeeList);
      });
    }
  }

  @override
  void onFailed(String error) {
    // TODO: implement onFailed
  }

  @override
  void onLoading(bool loading) {
    // TODO: implement onLoading
  }

  @override
  void onSuccess(List<Employee> employeeList) {
    setState(() {
      _employeeList = employeeList;
    });
  }
}
