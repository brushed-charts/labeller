import 'fragment_link.dart';

class FragmentTree {
  final _linkList = <FragmentLink>[];

  void upsert(FragmentLink linkToAdd) {
    // If link with the same ID already exist, it will be remove (replace)
    _linkList.removeWhere((storedLink) => storedLink.id == linkToAdd.id);
    _linkList.add(linkToAdd);
  }

  List<FragmentLink> getAll() {
    return _linkList;
  }

  FragmentLink? getByID(String idToRetrieve) {
    return _linkList.where((link) => link.id == idToRetrieve).firstOrNull;
  }
}
