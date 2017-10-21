//
//  PriorityQueue.swift
//  MinTreeAlgorithm
//
//  Created by chenwei on 2017/10/19.
//  Copyright © 2017年 wanzhao. All rights reserved.
//

import Foundation

public struct PriorityQueue<T: Hashable> {
    fileprivate var heap: Heap<T>
    
    public init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(priorityFunction: sort)
    }
    
    public func contains(_ element: T) -> Bool {
        return heap.elements.contains(element)
    }
    
    public var isEmpty : Bool {
        return heap.isEmpty
    }
    
    public var count : Int {
        return heap.count
    }
    
    public mutating func enqueue(_ element: T) {
        heap.enqueue(element)
    }
    
    public mutating func dequeue() -> T? {
        return heap.dequeue()
    }
}


