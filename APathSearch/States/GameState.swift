//
//  GameState.swift
//  APathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameSceneState: GKState {
    unowned let levelScene: GameScene
    init(scene: GameScene) {
        self.levelScene = scene
    }
}


// 初始化的状态
class GameSceneInitialState: GameSceneState {
    override func didEnter(from previousState: GKState?) {
        levelScene.setupLevel()
    }
}

class GameSceneActiveState: GameSceneState {
    
}
class GameScenePausedState: GameSceneState {
    
}
class GameSceneLimboState: GameSceneState {
    
}
class GameSceneSuccessState: GameSceneState {
    
}
class GameSceneFailState: GameSceneState {
    
}
