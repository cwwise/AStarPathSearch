//
//  ViewController.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tilemap: TileMap = TileMap()
    
    var startCoord: TileCoord!
    var toCoord: TileCoord!
    
    var pathfinder = AStarPathfinder()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTileMap()
        setupTarget()
    }

    func setupTileMap() {
    
        let size = tilemap.tileSize
        let top: CGFloat = 50
        let left: CGFloat = (self.view.bounds.width - tilemap.tilemapSize.width)/2
        
        for i in 0..<tilemap.tiles.rows {
            for j in 0..<tilemap.tiles.columns {
                let origin = CGPoint(x: size.width*CGFloat(j) + left, y: size.height*CGFloat(i) + top)
                let frame = CGRect(origin: origin, size: size)
                
                if let tileView = tilemap.tiles[j, i] {
                    tileView.frame = frame
                    self.view.addSubview(tileView)
                }
            }
        }
    }
    
    // 设置开始 结束位置
    func setupTarget() {
        startCoord = TileCoord(column: 2, row: 4)
        toCoord = TileCoord(column: 6, row: 5)

        // 判断开始结束位置是否可用
        if tilemap.isReachable(tileCoord: startCoord) == false {
            print("开始位置不在道路上")
        }
        
        if tilemap.isReachable(tileCoord: toCoord) == false {
            print("结束位置不在道路上")
        }
        
        pathfinder.dataSource = self
        pathfinder.delegate = self
        if let result = pathfinder.shortestPath(from: startCoord, toTileCoord: toCoord) {

            for item in result {
                if let view = tilemap.tileView(of: item) {
                    view.status = .successPath
                }
            }
            
        } else {
            print("没有找到路径")
        }
        
    
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: PathfinderDataSource, PathfinderDelegate {
    func walkableAdjacentTilesCoords(for tileCoord: TileCoord) -> [TileCoord] {
        let adjacentTiles = [tileCoord.top, tileCoord.left, tileCoord.bottom, tileCoord.right]
        return adjacentTiles.filter { self.tilemap.isReachable(tileCoord: $0) }
    }
    
    func costToMove(from fromTileCoord: TileCoord, toAdjacentTileCoord toTileCoord: TileCoord) -> Int {
        return 1
    }
    
    // 搜索到的路径
    func didInsertOpenPath(_ tileCoord: TileCoord) {
        if let view = tilemap.tileView(of: tileCoord) {
            view.status = .openPath
        }
    }
    
    func didInsertClosePath(_ tileCoord: TileCoord) {
        if let view = tilemap.tileView(of: tileCoord) {
            view.status = .closePath
        }
    }
    
}



