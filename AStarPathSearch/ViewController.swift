//
//  ViewController.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isSearch: Bool = false
    
    var startCoord: TileCoord!
    var toCoord: TileCoord!
    var tilemap: TileMap = TileMap()

    var pathfinder = AStarPathfinder()
    
    var timer: Timer!
    var semaphore: DispatchSemaphore!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTileMap()
        setupTarget()
        
        pathfinder.dataSource = self
        pathfinder.delegate = self
        
        semaphore = DispatchSemaphore(value: 0)
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [unowned self] (timer) in
            self.semaphore.signal()
        })
        timer.fireDate = Date.distantFuture
    }

    func setupTileMap() {
    
        let size = tilemap.tileSize
        let top: CGFloat = 50
        let left: CGFloat = (self.view.bounds.width - tilemap.tilemapSize.width)/2
        
        // 添加边框
        let edgeWidth: CGFloat = 5
        let frame = CGRect(x: left-5, y: top-5,
                           width: tilemap.tilemapSize.width+2*edgeWidth, height: tilemap.tilemapSize.height+2*edgeWidth)
        let backgroundView = UIView(frame: frame)
        backgroundView.backgroundColor = UIColor.orange
        self.view.addSubview(backgroundView)
        
        for i in 0..<tilemap.rows {
            for j in 0..<tilemap.columns {
                let origin = CGPoint(x: size.width*CGFloat(j) + left, y: size.height*CGFloat(i) + top)
                let frame = CGRect(origin: origin, size: size)
                
                if let tileView = tilemap.tileView(of: (j, i)) {
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
        // 设置标示
        guard let startView = self.tilemap.tileView(of: startCoord),
              let endView = self.tilemap.tileView(of: toCoord) else { return }
    

        endView.imageView.image = UIImage(named: "endFlag")
        startView.imageView.image = UIImage(named: "startFlag")
    }

    func search() {
        DispatchQueue.global().async {
            guard let result = self.pathfinder.shortestPath(from: self.startCoord, toTileCoord: self.toCoord) else {
                self.timer.fireDate = Date.distantFuture
                return
            }
            self.timer.fireDate = Date.distantFuture
            for item in result {
                guard let view = self.tilemap.tileView(of: item) else { continue }
                view.status = .successPath
            }
            
        }
    }
    
    // MARK: 点击事件
    @IBAction func resetAction(_ sender: UIButton) {
        self.timer.fireDate = Date.distantFuture
        tilemap.resetMap()
        isSearch = false
    }
    
    @IBAction func stepSearchAction(_ sender: UIButton) {
        self.semaphore.signal()
        if isSearch == false {
            search()
            isSearch = true
        }
    }
    
    @IBAction func autoSearch(_ sender: UIButton) {
        timer.fireDate = Date.distantPast
        if isSearch == false {
            search()
            isSearch = true
        }
    }
    
    deinit {
        print("销毁...")
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
    func didInsertOpenPath(_ tileCoord: TileCoord, score: (g: Int, h: Int)) {
        _ = self.semaphore.wait(timeout: DispatchTime.distantFuture)
        if let view = tilemap.tileView(of: tileCoord) {
            view.status = .openPath
            view.setPathInfo(score)
        }

    }
    
    func didInsertClosePath(_ tileCoord: TileCoord, score: (g: Int, h: Int)) {
        _ = self.semaphore.wait(timeout: DispatchTime.distantFuture)
        if let view = tilemap.tileView(of: tileCoord) {
            view.status = .closePath
        }
    }
    
}



