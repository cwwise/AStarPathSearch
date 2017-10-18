//
//  PlayerEntity.swift
//  APathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerEntity {
    
}

extension PlayerEntity: PathfinderDataSource {
    
    func walkableAdjacentTilesCoords(for tileCoord: TileCoord) -> [TileCoord] {
    
        let adjacentTiles = [tileCoord.top, tileCoord.left, tileCoord.bottom, tileCoord.right]
        return adjacentTiles.filter({ (tileCoord) -> Bool in
            return false
        })
    }
    
    func costToMove(from fromTileCoord: TileCoord, toAdjacentTileCoord toTileCoord: TileCoord) -> Int {
        return 1
    }
    
}



