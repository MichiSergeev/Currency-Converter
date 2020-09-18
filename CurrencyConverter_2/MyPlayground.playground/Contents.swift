//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var fm=FileManager.default
let path = "/Users/opium/Documents/userdef"

fm.fileExists(atPath: path)
fm.isWritableFile(atPath: path)
fm.isReadableFile(atPath: path)
fm.isDeletableFile(atPath: path)


// размер файла немного муторно узнается
//
//if let attribute = try? fm.attributesOfItem(atPath: path) {
//    if let nmb = attribute[.size] as? NSNumber {
//        let size = nmb.int64Value
//        print(size)
//    }
//}


// вычисление размера одного файла
func fileSize(path: String) -> Int64? {
    if let attr = try? fm.attributesOfItem(atPath: path) {
        if let nmb = attr[.size] as? NSNumber {
            return nmb.int64Value
        }
    }
    return nil
}
 

// сумма размеров всех файлов
func dirSize(at dirPath:String) -> Int64 {
    
    var result:Int64 = 0
    
    if let paths = try? fm.contentsOfDirectory(atPath: dirPath) {
        for path in paths {
            let fullpath = dirPath + "/" + path
            var isDir:ObjCBool=false
            if fm.fileExists(atPath: fullpath, isDirectory: &isDir) {
                if isDir.boolValue {
                    result+=dirSize(at: fullpath)
                } else {
                    if let size=fileSize(path: fullpath) {
                        result+=size
                    }
                }
            }
        }
    }
    
    return result
}


let docDir=fm.urls(for: .documentDirectory, in: .userDomainMask).first!
let docSize = dirSize(at: path)

print(docSize)
