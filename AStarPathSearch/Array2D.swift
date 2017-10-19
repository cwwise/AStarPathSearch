//
//  Array2D.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation

struct Array2D<T: CustomStringConvertible>: CustomStringConvertible {
    let columns: Int
    let rows: Int
    private var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows*columns)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
    
    var description: String {
        var string = ""
        for i in 0..<rows {
            var temp = "["
            for j in 0..<columns {
                temp += self[j, i]?.description ?? ""
                if j != columns - 1 {
                    temp += ", "
                }
            }
            temp += "],\n"
            string += temp
        }
        return string
    }
    
}

