//
//  GameScene.swift
//  APathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //State Machine
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        GameSceneInitialState(scene: self),
        GameSceneActiveState(scene: self),
        GameScenePausedState(scene: self),
        GameSceneLimboState(scene: self),
        GameSceneSuccessState(scene: self),
        GameSceneFailState(scene: self)
        ])
    
    override func didMove(to view: SKView) {
        
    }
    
    func setupLevel() {
        
        let start = TileCoord(column: 0, row: 0)
        let end = TileCoord(column: 10, row: 10)
        let result = end - start
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
