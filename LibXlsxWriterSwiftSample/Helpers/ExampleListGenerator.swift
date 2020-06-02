//
//  ExampleListGenerator.swift
//  LibXlsxWriterSwiftSample
//

import Foundation

class ExampleListGenerator {
    func generate() -> [Example] {
        var exampleList = [Example]()
        
        let helloExample = Example(id: 0,
                                   title: "hello.swift",
                                   subtitle: "A simple hello world example",
                                   code: """
                                   let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                                   let fileURL = documentDirectory.appendingPathComponent("hello_world.xlsx")
                                   
                                   let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
                                   let worksheet = workbook_add_worksheet(workbook, nil)
                                   worksheet_write_string(worksheet, 0, 0, "Hello", nil)
                                   worksheet_write_number(worksheet, 1, 0, 123, nil)
                                   workbook_close(workbook)
                                   """,
                                   generateFunction: Hello().generate)
        exampleList.append(helloExample)
        
        let anatomyExample = Example(id: 1,
                                     title: "anatomy.swift",
                                     subtitle: "The anatomy of a libxlsxwriter program",
                                     code: """
                                     let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                                     let fileURL = documentDirectory.appendingPathComponent("anatomy.xlsx")
                                     
                                     //Create a new workbook.
                                     //Ditch first 6 characters, because they are of the form file://
                                     let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
                                     //Add a worksheet with a user defined sheet name.
                                     let worksheet1 = workbook_add_worksheet(workbook, "Demo")
                                     //Add a worksheet with Excel's default sheet name: Sheet2.
                                     let worksheet2 = workbook_add_worksheet(workbook, nil)
                                     //Add some cell formats.
                                     let myformat1 = workbook_add_format(workbook)
                                     let myformat2 = workbook_add_format(workbook)
                                     //Set the bold property for the first format.
                                     format_set_bold(myformat1)
                                     //Set a number format for the second format.
                                     format_set_num_format(myformat2, "$#,##0.00")
                                     //Widen the first column to make the text clearer.
                                     worksheet_set_column(worksheet1, 0, 0, 20, nil)
                                     //Write some unformatted data.
                                     worksheet_write_string(worksheet1, 0, 0, "Peach", nil)
                                     worksheet_write_string(worksheet1, 1, 0, "Plum", nil)
                                     //Write formatted data.
                                     worksheet_write_string(worksheet1, 2, 0, "Pear", myformat1)
                                     //Formats can be reused.
                                     worksheet_write_string(worksheet1, 3, 0, "Persimmon", myformat1)
                                     //Write some numbers.
                                     worksheet_write_number(worksheet1, 5, 0, 123, nil)
                                     worksheet_write_number(worksheet1, 6, 0, 4567.555, myformat2)
                                     //Write to the second worksheet.
                                     worksheet_write_string(worksheet2, 0, 0, "Some text", myformat1)
                                     //Close the workbook, save the file and free any memory.
                                     let error = workbook_close(workbook)
                                     //Check if there was any error creating the xlsx file.
                                     if (error.rawValue != LXW_NO_ERROR.rawValue){
                                         print("Error in workbook_close().\nError %d = %s\n", error, lxw_strerror(error)!)
                                     }
                                     """,
                                     generateFunction: Anatomy().generate)
        exampleList.append(anatomyExample)
        
        let demoExample = Example(id: 2,
                                  title: "demo.swift",
                                  subtitle: "Demo of some of the libxlsxwriter features",
                                  code: """
                                  let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                                  let fileURL = documentDirectory.appendingPathComponent("demo.xlsx")
                                  
                                  //Create a new workbook.
                                  //Ditch first 6 characters, because they are of the form file://
                                  let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
                                  let worksheet = workbook_add_worksheet(workbook, nil)
                                  //Add a format.
                                  let format = workbook_add_format(workbook)
                                  //Set the bold property for the format
                                  format_set_bold(format)
                                  //Change the column width for clarity.
                                  worksheet_set_column(worksheet, 0, 0, 20, nil)
                                  //Write some simple text
                                  worksheet_write_string(worksheet, 0, 0, "Hello", nil)
                                  //Text with formatting.
                                  worksheet_write_string(worksheet, 1, 0, "World", format)
                                  //Write some numbers
                                  worksheet_write_number(worksheet, 2, 0, 123,     nil)
                                  worksheet_write_number(worksheet, 3, 0, 123.456, nil)
                                  //Insert an image
                                  var imageBuffer = getArrayOfBytesFromImage(imageData: (UIImage(named: "logo")?.jpegData(compressionQuality: .greatestFiniteMagnitude)!)! as NSData)
                                  worksheet_insert_image_buffer(worksheet, 1, 2, &imageBuffer, imageBuffer.count)
                                  workbook_close(workbook)

                                  ...

                                  func getArrayOfBytesFromImage(imageData:NSData) -> [UInt8]
                                  {
                                      //Determine array size
                                      let count = imageData.length / MemoryLayout.size(ofValue: UInt8())
                                      //Create an array of the appropriate size
                                      var bytes = [UInt8](repeating: 0, count: count)
                                      //Copy image data as bytes into the array
                                      imageData.getBytes(&bytes, length:count * MemoryLayout.size(ofValue: UInt8()))

                                      return bytes
                                  }
                                  """,
                                  generateFunction: Demo().generate)
        exampleList.append(demoExample)
        
        let tutorial01 = Example(id: 3,
                             title: "tutorial1.swift",
                             subtitle: "Tutorial 1 from the documentation",
                             code: """
                             // Some data we want to write to the worksheet.
                             struct Expense {
                                 let item: String!
                                 let cost: Double!
                             }

                             ...

                             let expenses = [
                                 Expense(item: "Rent", cost: 1000),
                                 Expense(item: "Gas", cost: 100),
                                 Expense(item: "Food", cost: 300),
                                 Expense(item: "Gym", cost: 50),
                             ]

                             ...

                             let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                              let fileURL = documentDirectory.appendingPathComponent("tutorial01.xlsx")
                              
                              //Create a new workbook.
                              //Ditch first 6 characters, because they are of the form file://
                              let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
                             
                              let worksheet = workbook_add_worksheet(workbook, nil)
                              //Start from the first cell. Rows and columns are zero indexed.
                              var row = 0
                              let col = 0
                              //Iterate over the data and write it out element by element.
                              for row in (0...3).reversed() {
                                  worksheet_write_string(worksheet, lxw_row_t(row), lxw_col_t(col),     expenses[row].item, nil)
                                  worksheet_write_number(worksheet, lxw_row_t(row), lxw_col_t(col + 1), expenses[row].cost, nil)
                              }
                              row = 4

                              //Write a total using a formula.
                              worksheet_write_string (worksheet, lxw_row_t(row), lxw_col_t(col), "Total", nil)
                              worksheet_write_formula(worksheet, lxw_row_t(row), lxw_col_t(col + 1), "=SUM(B1:B4)", nil)
                              workbook_close(workbook)
                             """,
                             generateFunction: Tutorial1().generate)
        exampleList.append(tutorial01)
        
        let tutorial02 = Example(id: 4,
                                 title: "tutorial2.swift",
                                 subtitle: "Tutorial 2 from the documentation",
                                 code: """
                                 // Some data we want to write to the worksheet.
                                 struct Expense {
                                     let item: String!
                                     let cost: Double!
                                 }

                                 ...

                                 let expenses = [
                                     Expense(item: "Rent", cost: 1000),
                                     Expense(item: "Gas", cost: 100),
                                     Expense(item: "Food", cost: 300),
                                     Expense(item: "Gym", cost: 50),
                                 ]

                                 ...

                                  let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                                  let fileURL = documentDirectory.appendingPathComponent("tutorial02.xlsx")
                                  
                                  //Create a new workbook.
                                  //Ditch first 6 characters, because they are of the form file://
                                  let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
                                 
                                  let worksheet = workbook_add_worksheet(workbook, nil)
                                  
                                  //Add a bold format to use to highlight cells
                                  let bold = workbook_add_format(workbook)
                                  format_set_bold(bold);
                                  //Add a number format for cells with money.
                                  let money = workbook_add_format(workbook)
                                  format_set_num_format(money, "$#,##0")
                                  
                                  //Write some data header.
                                  worksheet_write_string(worksheet, 0, 0, "Item", bold)
                                  worksheet_write_string(worksheet, 0, 1, "Cost", bold)
                                  
                                  //Start from the first cell. Rows and columns are zero indexed.
                                  var row = 0
                                  let col = 0
                                  //Iterate over the data and write it out element by element.
                                  for row in (0...3).reversed() {
                                      //Write from the first cell below the headers.
                                      worksheet_write_string(worksheet, lxw_row_t(row+1), lxw_col_t(col),     expenses[row].item, nil)
                                      worksheet_write_number(worksheet, lxw_row_t(row+1), lxw_col_t(col + 1), expenses[row].cost, money)
                                  }
                                  row = 5

                                  //Write a total using a formula.
                                  worksheet_write_string (worksheet, lxw_row_t(row), lxw_col_t(col), "Total", bold)
                                  worksheet_write_formula(worksheet, lxw_row_t(row), lxw_col_t(col + 1), "=SUM(B1:B4)", money)
                                  workbook_close(workbook)
                                 """,
                                 generateFunction: Tutorial2().generate)
        exampleList.append(tutorial02)
        
        let tutorial03 = Example(id: 5,
                                 title: "tutorial3.swift",
                                 subtitle: "Tutorial 3 from the documentation",
                                 code: """
                                 // Some data we want to write to the worksheet.
                                 struct Expense {
                                     let item: String!
                                     let cost: Double!
                                     let datetime: lxw_datetime!
                                 }

                                 ...

                                 let expenses = [
                                     Expense(item: "Rent", cost: 1000, datetime: lxw_datetime(year: 2013, month: 1, day: 13, hour: 0, min: 0, sec: 0.0)),
                                     Expense(item: "Gas", cost: 100, datetime: lxw_datetime(year: 2013, month: 1, day: 14, hour: 0, min: 0, sec: 0.0)),
                                     Expense(item: "Food", cost: 300, datetime: lxw_datetime(year: 2013, month: 1, day: 16, hour: 0, min: 0, sec: 0.0)),
                                     Expense(item: "Gym", cost: 50, datetime: lxw_datetime(year: 2013, month: 1, day: 20, hour: 0, min: 0, sec: 0.0)),
                                 ]

                                 ...

                                  let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                                  let fileURL = documentDirectory.appendingPathComponent("tutorial02.xlsx")
                                  
                                  //Create a new workbook.
                                  //Ditch first 6 characters, because they are of the form file://
                                  let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
                                 
                                  let worksheet = workbook_add_worksheet(workbook, nil)
                                  
                                  //Add a bold format to use to highlight cells
                                  let bold = workbook_add_format(workbook)
                                  format_set_bold(bold);
                                  //Add a number format for cells with money.
                                  let money = workbook_add_format(workbook)
                                  format_set_num_format(money, "$#,##0")
                                  
                                  //Write some data header.
                                  worksheet_write_string(worksheet, 0, 0, "Item", bold)
                                  worksheet_write_string(worksheet, 0, 1, "Cost", bold)
                                  
                                  //Start from the first cell. Rows and columns are zero indexed.
                                  var row = 0
                                  let col = 0
                                  //Iterate over the data and write it out element by element.
                                  for row in (0...3).reversed() {
                                      //Write from the first cell below the headers.
                                      worksheet_write_string(worksheet, lxw_row_t(row+1), lxw_col_t(col),     expenses[row].item, nil)
                                      worksheet_write_number(worksheet, lxw_row_t(row+1), lxw_col_t(col + 1), expenses[row].cost, money)
                                  }
                                  row = 5

                                  //Write a total using a formula.
                                  worksheet_write_string (worksheet, lxw_row_t(row), lxw_col_t(col), "Total", bold)
                                  worksheet_write_formula(worksheet, lxw_row_t(row), lxw_col_t(col + 1), "=SUM(B1:B4)", money)
                                  workbook_close(workbook)
                                 """,
                                 generateFunction: Tutorial3().generate)
        exampleList.append(tutorial03)
        
        return exampleList
    }
}
