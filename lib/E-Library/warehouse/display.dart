// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

//import 'dart:convert';
//import 'dart:html' as html;
//import 'package:excel/excel.dart';

import 'package:flutter/material.dart';

import 'package:e_library/E-Library/warehouse/warehouse.dart';

var dataTable = DataTable(
  headingRowColor: MaterialStateColor.resolveWith((states) {return const Color(0xFFAB47BC);},),
  dataRowColor: MaterialStateColor.resolveWith((states) {return const Color(0xFFE1BEE7);},),
  border: TableBorder.all(color: Colors.deepPurple,width: 2,borderRadius:const BorderRadius.all(Radius.circular(10)) ),
  rows: tableData.map((item) => DataRow(cells: [
    DataCell(Text(item['product'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
    DataCell(Text(item['amount'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
    if(dropdownvalueImplement == "Recent Quantity")
      DataCell(Text(item['siz'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
    if(dropdownvalueImplement == "Corrupted")
      DataCell(Text(item['cause'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
    if(dropdownvalueImplement != "Recent Quantity")
      DataCell(Text(item['date'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
  ])).toList(),
  columns:  [
    const DataColumn(
        label:Text('Name',
            style:TextStyle(
              color: Color(0xFFF3E5F5),
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ))),

    const DataColumn(
        label:Text('Amount',
            style:TextStyle(
              color: Color(0xFFF3E5F5),
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ))),

    if(dropdownvalueImplement == "Recent Quantity")
      const DataColumn(
          label:Text('Size Area',
              style:TextStyle(
                color: Color(0xFFF3E5F5),
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ))),

    if(dropdownvalueImplement == "Corrupted")
      const DataColumn(
          label:Text('Cause',
              style:TextStyle(
                color: Color(0xFFF3E5F5),
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ))),

    if (dropdownvalueImplement != "Recent Quantity")
      const DataColumn(
          label:Text('Date',
              style:TextStyle(
                color: Color(0xFFF3E5F5),
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ))),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
          titleSmall: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: 11),
        )
            .apply(
          bodyColor: Colors.black,
          displayColor: Colors.grey,
        ),
        listTileTheme: const ListTileThemeData(iconColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            iconTheme: IconThemeData(color: Colors.black54, size: 25)),
      ),
      home: Display(),
    );
  }
}

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Display $dropdownvalueImplement",
            style: const TextStyle(
                color: Color(0xFFF8BBD0),
                fontWeight: FontWeight.w700,
                fontSize: 25,
                fontFamily: 'Lucida Calligraphy Font',
                fontStyle: FontStyle.italic)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF8BBD0),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.all(25),
            child: Center(
              child:  Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Display Movement of Products',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            fontFamily: 'Lucida Calligraphy Font',
                            fontStyle: FontStyle.italic
                        ),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) {return const Color(0xFFAB47BC);},),
                    dataRowColor: MaterialStateColor.resolveWith((states) {return const Color(0xFFE1BEE7);},),
                    border: TableBorder.all(color: Colors.deepPurple,width: 2,borderRadius:const BorderRadius.all(Radius.circular(10)) ),
                    rows: tableData.map((item) => DataRow(cells: [
                      DataCell(Text(item['product'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
                      DataCell(Text(item['amount'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
                      if(dropdownvalueImplement == "Recent Quantity")
                        DataCell(Text(item['siz'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
                      if(dropdownvalueImplement == "Corrupted")
                        DataCell(Text(item['cause'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
                      if(dropdownvalueImplement != "Recent Quantity")
                        DataCell(Text(item['date'].toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300),)),
                    ])).toList(),
                    columns:  [
                      const DataColumn(
                          label:Text('Name',
                              style:TextStyle(
                                color: Color(0xFFF8BBD0),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ))),

                      const DataColumn(
                          label:Text('Amount',
                              style:TextStyle(
                                color: Color(0xFFF8BBD0),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ))),

                      if(dropdownvalueImplement == "Recent Quantity")
                        const DataColumn(
                            label:Text('Size Area',
                                style:TextStyle(
                                  color: Color(0xFFF8BBD0),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ))),

                      if(dropdownvalueImplement == "Corrupted")
                        const DataColumn(
                            label:Text('Cause',
                                style:TextStyle(
                                  color: Color(0xFFF3E5F5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ))),

                      if (dropdownvalueImplement != "Recent Quantity")
                        const DataColumn(
                            label:Text('Date',
                                style:TextStyle(
                                  color: Color(0xFFF8BBD0),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ))),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                      padding: const EdgeInsets.all(20),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                          height: 20,
                          child: Row(
                            children:const [
                              Icon(Icons.save, color: Color(0xFFF8BBD0)),
                              SizedBox(width: 10),
                              Text('Download Excel',style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                            ],
                          )
                      ),

                      onPressed: () async {

                        /*
                        // Create a new Excel workbook
                        final excel = Excel.createExcel();

                        // Add a worksheet to the workbook
                        final sheet = excel['Sheet1'];

                        // Add the DataTable headers to the worksheet
                        for (var i = 0; i < dataTable.columns.length; i++) {
                          final column = dataTable.columns[i];
                          sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = (column.label as Text).data.toString();
                        }

                        // Add the DataTable rows to the worksheet
                        for (var i = 0; i < dataTable.rows.length; i++) {
                          final row = dataTable.rows[i];
                          for (var j = 0; j < row.cells.length; j++) {
                            final cell = row.cells[j];
                            sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1)).value = (cell.child as Text).data.toString();
                          }
                        }

                        // Convert the Excel workbook to a byte array
                        final bytes = excel.encode();

                        // Convert the byte array to a base64 string
                        final base64String = base64.encode(bytes as List<int>);

                        // Create a download link for the Excel file
                        final anchor = html.AnchorElement(href: 'data:application/vnd.ms-excel;base64,$base64String')
                          ..download = 'WMS $dropdownvalueImplement.xlsx'
                          ..click();
                        */
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}