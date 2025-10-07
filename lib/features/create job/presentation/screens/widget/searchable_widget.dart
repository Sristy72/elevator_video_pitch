// import 'package:flutter/material.dart';

// class SearchableDropdownField extends StatefulWidget {
//   final String label;
//   final String hintText;
//   final List<String> items;
//   final String? value;
//   final Function(String) onChanged;
//   final bool isRequired;

//   const SearchableDropdownField({
//     super.key,
//     required this.label,
//     required this.hintText,
//     required this.items,
//     required this.onChanged,
//     this.value,
//     this.isRequired = false,
//   });

//   @override
//   State<SearchableDropdownField> createState() => _SearchableDropdownFieldState();
// }

// class _SearchableDropdownFieldState extends State<SearchableDropdownField> {
//   late TextEditingController _searchController;
//   late List<String> filteredItems;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//     filteredItems = List.from(widget.items);
//   }

//   void _openDropdownDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.label,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: "Search ${widget.label.toLowerCase()}...",
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setStateDialog(() {
//                       filteredItems = widget.items
//                           .where((item) =>
//                               item.toLowerCase().contains(value.toLowerCase()))
//                           .toList();
//                     });
//                   },
//                 ),
//               ],
//             ),
//             content: SizedBox(
//               width: double.maxFinite,
//               height: 300,
//               child: filteredItems.isEmpty
//                   ? const Center(child: Text("No items found"))
//                   : ListView.builder(
//                       itemCount: filteredItems.length,
//                       itemBuilder: (context, index) {
//                         final item = filteredItems[index];
//                         return ListTile(
//                           title: Text(item),
//                           onTap: () {
//                             widget.onChanged(item);
//                             Navigator.pop(context);
//                           },
//                         );
//                       },
//                     ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: widget.label,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//             children: [
//               if (widget.isRequired)
//                 const TextSpan(
//                   text: ' *',
//                   style: TextStyle(color: Colors.red),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 6),
//         InkWell(
//           onTap: _openDropdownDialog,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade400),
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.white,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.value?.isNotEmpty == true
//                         ? widget.value!
//                         : widget.hintText,
//                     style: TextStyle(
//                       color: widget.value?.isNotEmpty == true
//                           ? Colors.black
//                           : Colors.grey.shade600,
//                     ),
//                   ),
//                 ),
//                 const Icon(Icons.arrow_drop_down),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class SearchableDropdownField extends StatefulWidget {
  final String label;
  final String hintText;
  final List<String> items;
  final String? value;
  final Function(String)? onChanged; // nullable
  final bool isRequired;
  final bool enabled; // NEW

  const SearchableDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.value,
    this.isRequired = false,
    this.enabled = true, // default true
  });

  @override
  State<SearchableDropdownField> createState() =>
      _SearchableDropdownFieldState();
}

class _SearchableDropdownFieldState extends State<SearchableDropdownField> {
  late TextEditingController _searchController;
  late List<String> filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredItems = List.from(widget.items);
  }

  // void _openDropdownDialog() {
  //   if (!widget.enabled) return; // prevent opening when disabled

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setStateDialog) {
  //           return AlertDialog(
  //             title: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   widget.label,
  //                   style: const TextStyle(fontWeight: FontWeight.w600),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextField(
  //                   controller: _searchController,
  //                   decoration: InputDecoration(
  //                     hintText: "Search ${widget.label.toLowerCase()}...",
  //                     prefixIcon: const Icon(Icons.search),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                   ),
  //                   onChanged: (value) {
  //                     setStateDialog(() {
  //                       filteredItems = widget.items
  //                           .where(
  //                             (item) => item.toLowerCase().contains(
  //                               value.toLowerCase(),
  //                             ),
  //                           )
  //                           .toList();
  //                     });
  //                   },
  //                 ),
  //               ],
  //             ),
  //             content: SizedBox(
  //               width: double.maxFinite,
  //               height: 300,
  //               child: filteredItems.isEmpty
  //                   ? const Center(child: Text("No items found"))
  //                   : ListView.builder(
  //                       itemCount: filteredItems.length,
  //                       itemBuilder: (context, index) {
  //                         final item = filteredItems[index];
  //                         return ListTile(
  //                           title: Text(item),
  //                           onTap: () {
  //                             if (widget.onChanged != null) {
  //                               widget.onChanged!(item);
  //                             }
  //                             Navigator.pop(context);
  //                           },
  //                         );
  //                       },
  //                     ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _openDropdownSheet() {
    if (!widget.enabled) return;

    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    // Text(
                    //   widget.label,
                    //   style: const TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black87,
                    //   ),
                    // ),
                    const SizedBox(height: 12),

                    // Search box
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setStateSheet(() {
                            filteredItems = widget.items
                                .where(
                                  (item) => item.toLowerCase().contains(
                                    value.toLowerCase(),
                                  ),
                                )
                                .toList();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Items
                    Expanded(
                      child: filteredItems.isEmpty
                          ? const Center(
                              child: Text(
                                "No items found",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = filteredItems[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 0,
                                    ),
                                    title: Text(
                                      item,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    onTap: () {
                                      if (widget.onChanged != null) {
                                        widget.onChanged!(item);
                                      }
                                      Navigator.pop(context);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    tileColor: Colors.grey.shade50,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sync filteredItems with latest items
    filteredItems = List.from(widget.items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2A2A2A),
              fontWeight: FontWeight.w500,
            ),
            children: [
              if (widget.isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: widget.enabled ? _openDropdownSheet : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.enabled ? Color(0xFF484848) : Color(0xFF484848),
              ),
              borderRadius: BorderRadius.circular(8),
              // color: widget.enabled ? Colors.white : Colors.grey.shade200,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.value?.isNotEmpty == true
                        ? widget.value!
                        : widget.hintText,
                    style: TextStyle(
                      color: widget.value?.isNotEmpty == true
                          ? Color(0xFF2A2A2A)
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
