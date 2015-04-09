//
//  LeeExtension.swift
//  CirclePingpong
//
//  Created by Mercurial Lee on 14-8-25.
//  Copyright (c) 2014年 Mercurial Lee. All rights reserved.
//

import SpriteKit


// CGVector Extensions
infix operator * {}

func * (left: CGVector, right: CGVector) -> CGFloat {
    return CGFloat(left.dx * right.dx) + CGFloat(left.dy * right.dy)
}

func * (vector: CGVector, times: CGFloat) -> CGVector {
    return CGVectorMake(times * vector.dx, times * vector.dy)
}

func * (times: CGFloat, vector: CGVector) -> CGVector {
    return vector * times
}

func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVectorMake(left.dx + right.dx, left.dy + right.dy)
}

func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVectorMake(left.dx - right.dx, left.dy - right.dy)
}


extension CGVector {
    
    var mode: CGFloat {
        return pow(pow(self.dx, 2)+pow(self.dy, 2), 0.5)
    }
    
    var unitVector: CGVector {
        return CGVectorMake(self.dx / self.mode, self.dy / self.mode)
    }
    
    init (point: CGPoint) {
        self = CGVectorMake(point.x, point.y)
    }
    
    init (fromA: CGPoint, toB: CGPoint) {
        self = CGVectorMake(toB.x - fromA.x, toB.y - fromA.y)
    }
    
    func projectionToVector(vector: CGVector) -> CGVector {
        return (self * vector.unitVector) * vector.unitVector
    }
}

// Basic operator extension
infix operator ** { associativity left precedence 155 }

func ** (left: CGFloat, right: CGFloat) -> CGFloat {
    return CGFloat(pow(Double(left), Double(right)))
}

func ** (left: Int, right: Int) -> Int {
    return Int(pow(Double(left), Double(right)))
}

func ** (left: Float, right: Float) -> Float {
    return Float(pow(Double(left), Double(right)))
}

func ** (left: Double, right: Double) -> Double {
    return pow(left, right)
}