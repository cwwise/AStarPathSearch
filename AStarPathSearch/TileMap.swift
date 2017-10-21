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
    
    public var columns: Int {
        return tiles.columns
    }
    
    public var rows: Int {
        return tiles.rows
    }
    
    public var tileSize = CGSize(width: 38, height: 38)

    private var tiles: Array2D<TileView>

    public var tilemapSize: CGSize {
        return CGSize(width: tileSize.width * CGFloat(tiles.columns),
                      height: tileSize.height * CGFloat(tiles.rows))
    }
    
    init() {
        //Template Level
        let template =
            [
                [2, 2, 2, 2, 2, 2, 2, 2, 2],
                [2, 3, 3, 3, 3, 3, 3, 3, 2],
                
                [2, 3, 1, 1, 1, 1, 1, 3, 2],
                [2, 3, 3, 3, 1, 3, 3, 3, 2],
                
                [2, 3, 3, 3, 1, 3, 3, 3, 2],
                [2, 3, 1, 3, 1, 3, 3, 3, 2],
                
                [2, 3, 3, 3, 1, 3, 3, 3, 2],
                [2, 2, 2, 2, 2, 2, 2, 2, 2], ]
        
        tiles = Array2D<TileView>(columns: template.first?.count ?? 0, rows: template.count)
        generateMap(with: template)
    }
    
    func generateMap(with template: [[Int]]) {
    
        for (indexr, row) in template.enumerated() {
            for (indexc, cvalue) in row.enumerated() {
                let tileView = TileView()
                tileView.type = TileType(type: cvalue)
                tiles[indexc, indexr] = tileView
            }
        }
    }
    
    func resetMap() {
        for i in 0..<rows {
            for j in 0..<columns {
                if let tileView = tileView(of: (j, i)) {
                    tileView.status = .none
                }
            }
        }
    }
    
    // MARK: Helper
    func tileView(of tileCoord: TileCoord) -> TileView? {
        return tiles[tileCoord.column, tileCoord.row]
    }
    
    func tileView(of coord: (column: Int, row: Int)) -> TileView? {
        return tiles[coord.column, coord.row]
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
