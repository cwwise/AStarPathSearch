//
//  AStarPathfinder.swift
//  APathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation

protocol PathfinderDataSource: class {
    func walkableAdjacentTilesCoords(for tileCoord: TileCoord) -> [TileCoord]
    func costToMove(from fromTileCoord: TileCoord, toAdjacentTileCoord toTileCoord: TileCoord) -> Int
}

/** A pathfinder based on the A* algorithm to find the shortest path between two locations */
class AStarPathfinder {
    
    weak var dataSource: PathfinderDataSource?
    
    func shortestPath(from fromTileCoord: TileCoord, toTileCoord: TileCoord) -> [TileCoord]? {

        guard let dataSource = self.dataSource else {
            return nil
        }
        
        var closedSteps = Set<ShortestPathStep>()
        var openSteps = [ShortestPathStep(position: fromTileCoord)]

        while openSteps.isEmpty == false {
            
            let currentStep = openSteps.remove(at: 0)
            closedSteps.insert(currentStep)
            
            if currentStep.position == toTileCoord {
                print("Path Found:")
                var step: ShortestPathStep? = currentStep
                while step != nil {
                    step = step?.parent
                }
                return []
            }
            
            //
            let adjacentTiles = dataSource.walkableAdjacentTilesCoords(for: currentStep.position)
            for tile in adjacentTiles {
                
                let step = ShortestPathStep(position: tile)
                if closedSteps.contains(step) {
                    continue
                }
                let moveCost = dataSource.costToMove(from: currentStep.position, toAdjacentTileCoord: step.position)
        
                if let existingIndex = openSteps.index(of: step) {

                    // retrieve the old one (which has its scores already computed)
                    let step = openSteps[existingIndex]
                    
                    // check to see if the G score for that step is lower if we use the current step to get there
                    if currentStep.gScore + moveCost < step.gScore {
                        step.set(parent: currentStep, with: moveCost)
                        openSteps.remove(at: existingIndex)
                        insert(step: step, openSteps: &openSteps)
                    }
                    
                } else {
                    
                    step.set(parent: currentStep, with: moveCost)
                    
                    step.hScore = hScore(from: step.position, toCoord: toTileCoord)
                    
                    insert(step: step, openSteps: &openSteps)
                }
                
            }
            
        }
        
        
        return [toTileCoord]
    }
    
    private func insert(step: ShortestPathStep, openSteps: inout [ShortestPathStep]) {
        openSteps.append(step)
        openSteps.sort { $0.fScore <= $1.fScore }
    }
    
    func convertSteps(to lastStep: ShortestPathStep) -> [TileCoord] {
        var shortestPath = [TileCoord]()
        var currentStep = lastStep
        while let parent = currentStep.parent {
            shortestPath.insert(currentStep.position, at: 0)
            currentStep = parent
        }
        return shortestPath
    }
    
    func hScore(from fromCoord: TileCoord, toCoord: TileCoord) -> Int {
        return abs(toCoord.column - fromCoord.column) + abs(toCoord.row - fromCoord.row)
    }
    
}


class ShortestPathStep: Hashable {
    
    let position: TileCoord
    var parent: ShortestPathStep?
    
    var gScore = 0
    var hScore = 0
    var fScore: Int {
        return gScore + hScore
    }
    
    init(position: TileCoord) {
        self.position = position
    }
    
    func set(parent: ShortestPathStep, with moveCost: Int) {
        self.parent = parent
        self.gScore = parent.gScore + moveCost
    }
    
    var hashValue: Int {
        return position.column.hashValue + position.row.hashValue
    }
}

extension ShortestPathStep: Equatable, CustomStringConvertible {
    static func ==(lhs: ShortestPathStep, rhs: ShortestPathStep) -> Bool {
        return lhs.position == rhs.position
    }
    
    var description: String {
        return "pos=\(position) g=\(gScore) h=\(hScore) f=\(fScore)"
    }

}



