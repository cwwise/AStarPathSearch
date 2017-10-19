//
//  TileMap.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation
import UIKit

class TileMap {
    
    private var columns: Int {
        return tiles.columns
    }
    
    private var rows: Int {
        return tiles.rows
    }
    
    var tileSize = CGSize(width: 40, height: 40)

    var tiles = Array2D<TileView>(columns: 9, rows: 8)

    var tilemapSize: CGSize {
        return CGSize(width: tileSize.width * CGFloat(tiles.columns),
                      height: tileSize.height * CGFloat(tiles.rows))
    }
    
    init() {
       generateMap()
    }
    
    func generateMap() {
        //Template Level
        let template =
            [
                [1, 1, 1, 1, 1, 1, 1, 1, 1],
                [1, 3, 3, 3, 3, 3, 3, 3, 1],
                
                [1, 3, 3, 3, 1, 3, 3, 3, 1],
                [1, 3, 3, 3, 1, 3, 3, 3, 1],
                
                [1, 3, 3, 3, 1, 3, 3, 3, 1],
                [1, 3, 1, 3, 1, 3, 3, 3, 1],
                
                [1, 3, 3, 3, 3, 3, 3, 3, 1],
                [1, 1, 1, 1, 1, 1, 1, 1, 1],

            ]
        
        for (indexr, row) in template.enumerated() {
            for (indexc, cvalue) in row.enumerated() {
                let tileView = TileView()
                tileView.type = TileType(type: cvalue)
                tiles[indexc, indexr] = tileView
            }
        }
        
    }
    
    func tileView(of tileCoord: TileCoord) -> TileView? {
        return tiles[tileCoord.column, tileCoord.row]
    }
    
    func isValid(tileCoord: TileCoord) -> Bool {
        return (0..<columns).contains(tileCoord.column) && (0..<rows).contains(tileCoord.row)
    }
    
    func isReachable(tileCoord: TileCoord) -> Bool {
        
        if isValid(tileCoord: tileCoord) == false {
            return false
        }
        
        if let tileView = tiles[tileCoord.column, tileCoord.row] {
            return tileView.type == .ground
        }
        return false
    }
    
}
