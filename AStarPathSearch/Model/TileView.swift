//
//  TileView.swift
//  AStarPathSearch
//
//  Created by wei chen on 2017/10/18.
//  Copyright © 2017年 wei chen. All rights reserved.
//

import UIKit

private let textColor = UIColor.darkText
private let textFont = UIFont.systemFont(ofSize: 12)

class TileView: UIView {
    
    // h 曼哈顿距离 g到达目前位置花费 f总共
    var gLabel: UILabel = {
        let gLabel = UILabel()
        gLabel.textColor = textColor
        gLabel.font = textFont

        return gLabel
    }()
    
    var hLabel: UILabel = {
       let hLabel = UILabel()
        hLabel.textColor = textColor
        hLabel.font = textFont
       return hLabel
    }()
    
    var fLabel: UILabel = {
        let fLabel = UILabel()
        fLabel.textColor = textColor
        fLabel.font = textFont
        return fLabel
    }()
    
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
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
            DispatchQueue.main.async {
                self.setupStatus()
            }
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
        
        self.addSubview(gLabel)
        self.addSubview(hLabel)
        self.addSubview(fLabel)

        let lineColor = UIColor(hex: "#5C6B6C").cgColor
        rightLine.backgroundColor = lineColor
        self.layer.addSublayer(rightLine)
        
        bottomLine.backgroundColor = lineColor
        self.layer.addSublayer(bottomLine)
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        let linewidth = 1/UIScreen.main.scale
        rightLine.frame = CGRect(x: self.bounds.width-linewidth, y: 0, width: linewidth, height: self.bounds.height)
        bottomLine.frame = CGRect(x: 0, y: self.bounds.height-linewidth, width: self.bounds.width, height: linewidth)
        imageView.frame = self.bounds
        
        let size = CGSize(width: 15, height: 10)
        fLabel.frame = CGRect(x: 5, y: 5, width: size.width, height: size.height)

        gLabel.frame = CGRect(x: 5, y: self.bounds.height-5-size.height,
                              width: size.width, height: size.height)
        hLabel.frame = CGRect(x: self.bounds.width-size.width, y: self.bounds.height-5-size.height,
                              width: size.width, height: size.height)
    }
    
    // 设置A*搜索
    func setPathInfo(_ score:(g: Int, h: Int)) {
        DispatchQueue.main.async {
            self.hLabel.text = "\(score.h)"
            self.gLabel.text = "\(score.g)"
            self.fLabel.text = "\(score.h+score.g)"
        }
    }
    
    func setupType() {
        if type == .ground {
            self.backgroundColor = UIColor.white
            
            rightLine.isHidden = false
            bottomLine.isHidden = false
        } else {
            rightLine.isHidden = true
            bottomLine.isHidden = true

            let lineColor = UIColor(hex: "#767E83")
            self.backgroundColor = lineColor
        }
    }
    
    func setupStatus() {
        if self.type == .wall {
            return
        }
        var backgroundColor: UIColor
        switch status {
        case .successPath:
            backgroundColor = UIColor(hex: "#E27F77")
        case .openPath:
            backgroundColor = UIColor(hex: "#B2CDEB")
        case .closePath:
            backgroundColor = UIColor(hex: "#B7CE7F")
        default:
            backgroundColor = UIColor.white
            self.hLabel.text = ""
            self.gLabel.text = ""
            self.fLabel.text = ""
        }
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
