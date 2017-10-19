//
//  AStarPathfinder.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation

protocol PathfinderDataSource: class {
    func walkableAdjacentTilesCoords(for tileCoord: TileCoord) -> [TileCoord]
    func costToMove(from fromTileCoord: TileCoord, toAdjacentTileCoord toTileCoord: TileCoord) -> Int
}


/// 搜索过程中的一些触发事件
protocol PathfinderDelegate: class {
    func didInsertOpenPath(_ tileCoord: TileCoord)
    func didInsertClosePath(_ tileCoord: TileCoord)

}


class AStarPathfinder {
    
    weak var dataSource: PathfinderDataSource?
    
    weak var delegate: PathfinderDelegate?

    func shortestPath(from fromTileCoord: TileCoord, toTileCoord: TileCoord) -> [TileCoord]? {
        
        guard let dataSource = self.dataSource else {
            return nil
        }
        
        var closedSteps = Set<ShortestPathStep>()
        // 可以替换为最小堆
        var openSteps = [ShortestPathStep(position: fromTileCoord)]
        
        while openSteps.isEmpty == false {
            
            let currentStep = openSteps.remove(at: 0)
            closedSteps.insert(currentStep)
            self.delegate?.didInsertClosePath(currentStep.position)
            
            // 找到目标位置
            if currentStep.position == toTileCoord {
                return convertSteps(to: currentStep)
            }
            
            // 从当前位置的周围可走位置 遍历
            let adjacentTiles = dataSource.walkableAdjacentTilesCoords(for: currentStep.position)
            for tile in adjacentTiles {
                
                let step = ShortestPathStep(position: tile)
                // 已经包含在封闭路径中 则已经走过了
                if closedSteps.contains(step) {
                    continue
                }
                
                // 计算移动的花费
                let moveCost = dataSource.costToMove(from: currentStep.position, toAdjacentTileCoord: step.position)
                // 如果包含在 待比较路径中
                if let existingIndex = openSteps.index(of: step) {
                    // 比较是否为最短路径 如果为更短位置
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
        
        return nil
    }
    
    //
    private func insert(step: ShortestPathStep, openSteps: inout [ShortestPathStep]) {
        openSteps.append(step)
        // 搜索路径
        self.delegate?.didInsertOpenPath(step.position)
        // 排序
        openSteps.sort { (left, right) -> Bool in
            // 如果g值一样 则按照运行 来排序 即取最近加入列表的
            if left.fScore == right.fScore {
//                return left.gScore >= right.gScore
            }
            return left.fScore < right.fScore
        }
    }
    
    // 转换为路径
    func convertSteps(to lastStep: ShortestPathStep) -> [TileCoord] {
        var shortestPath = [TileCoord]()
        var currentStep: ShortestPathStep? = lastStep
        // 寻找当前路径的上一个位置
        while let step = currentStep {
            shortestPath.insert(step.position, at: 0)
            currentStep = step.parent
        }
        return shortestPath
    }
    
    // 曼哈顿距离
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
        if self.parent != nil {
            print("找到更好的路径")
        }
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
