//
//  TileView.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import UIKit

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
    // 当前搜索
    case search
    // 闭合路径
    case closePath
    // 开路径
    case openPath
    // 最后成功的路径
    case successPath
}

class TileView: UIView {
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Wall1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // 样式
    var type: TileType = .wall {
        didSet {
           setupType()
        }
    }
    
    var status: TileStatus = .none {
        didSet {
            setupStatus()
        }
    }
    
    // 位置
    var tileCoord = TileCoord(column: 0, row: 0)
    let bottomLine = CAShapeLayer()
    let rightLine = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        
        //self.addSubview(imageView)
        
        let lineColor = UIColor(hex: "#5C6B6C").cgColor
        rightLine.backgroundColor = lineColor
        self.layer.addSublayer(rightLine)
        
        bottomLine.backgroundColor = lineColor
        self.layer.addSublayer(bottomLine)
    }
    
    override func layoutSubviews() {
        let linewidth = 1/UIScreen.main.scale
        rightLine.frame = CGRect(x: self.bounds.width-linewidth, y: 0, width: linewidth, height: self.bounds.height)
        bottomLine.frame = CGRect(x: 0, y: self.bounds.height-linewidth, width: self.bounds.width, height: linewidth)
        imageView.frame = self.bounds
    }
    
    func setupType() {
        if type == .ground {
            self.backgroundColor = UIColor.white
            
            rightLine.isHidden = false
            bottomLine.isHidden = false
            imageView.isHidden = true
        } else {
            rightLine.isHidden = true
            bottomLine.isHidden = true
            imageView.isHidden = false

            let lineColor = UIColor(hex: "#767E83")
            self.backgroundColor = lineColor
        }
    }
    
    func setupStatus() {
        var backgroundColor: UIColor?
        switch status {
        case .successPath:
            backgroundColor = UIColor(hex: "#E27F77")
        case .openPath:
            backgroundColor = UIColor(hex: "#B2CDEB")
        case .closePath:
            backgroundColor = UIColor(hex: "#B7CE7F")
        default:
            break
        }
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
