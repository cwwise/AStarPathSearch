//
//  TileDefine.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/21.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import Foundation

// 墙 或者 路
enum TileType: Int {
    case wall
    case ground
    
    init(type: Int) {
        if type == 1 {
            self = . wall
        } else {
            self = . ground
        }
    }
    
    // 是否可以到达
    var isReachable: Bool {
        return self == .ground
    }
}

// 状态 待搜索
enum TileStatus: Int {
    // 默认状态
    case none
    // 闭合路径
    case closePath
    // 开路径
    case openPath
    // 最后成功的路径
    case successPath
}
