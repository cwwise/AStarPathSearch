//
//  TileCoord.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation

struct TileCoord {
    
    let column: Int
    let row: Int
    
    var top: TileCoord {
        return TileCoord(column: column, row: row - 1)
    }
    
    var left: TileCoord {
        return TileCoord(column: column - 1, row: row)
    }
    
    var right: TileCoord {
        return TileCoord(column: column + 1, row: row)
    }
    
    var bottom: TileCoord {
        return TileCoord(column: column, row: row + 1)
    }
    
}

extension TileCoord: CustomStringConvertible {
    var description: String {
        return "[column=\(column) row=\(row)]"
    }
}

extension TileCoord: Equatable {
    static func ==(lhs: TileCoord, rhs: TileCoord) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}

