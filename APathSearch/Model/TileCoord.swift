//
//  TileCoord.swift
//  APathSearch
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
        return lhs.left == rhs.left && lhs.right == rhs.right
    }
}

// Allow expressions such as let diff = coord1 - coord2
func -(lhs: TileCoord, rhs: TileCoord) -> TileCoord {
    return TileCoord(column: lhs.column - rhs.column, row: lhs.row - rhs.row)
}













