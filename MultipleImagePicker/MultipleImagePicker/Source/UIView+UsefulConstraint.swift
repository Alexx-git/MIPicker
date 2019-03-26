//
//  UIView+UsefulConstraint.swift
//  MultipleImagePicker
//
//  Created by VLADIMIR on 3/26/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import Foundation
import UIKit

enum ViewEdge: NSLayoutConstraint.Attribute {
    case top = .top
    case bottom = .bottom
    case left = .left
    case right = .right
}

enum ViewAxis: NSLayoutConstraint.Attribute {
    case vertical = .vertical
    case horizontal = .horizontal
}

enum ViewSize: NSLayoutConstraint.Attribute {
    case width = .width
    case height = .height
}

extension UIView
{
    func pinToSuperview()
    {
        self.pinToSuperview(withEdgeInsets: .zero)
    }
    
    func pinToSuperview(withEdgeInsets: UIEdgeInsets)
    {
        if let superview = self.superview
        {
            self.pin(edgeToSuperViewEdge: .top, withInset: withEdgeInsets.top, relation: .equal)
            self.pin(edgeToSuperViewEdge: .bottom, withInset: withEdgeInsets.bottom, relation: .equal)
            self.pin(edgeToSuperViewEdge: .right, withInset: withEdgeInsets.right, relation: .equal)
            self.pin(edgeToSuperViewEdge: .left, withInset: withEdgeInsets.left, relation: .equal)
        }
        
    }
    
    func pin(edgeToSuperViewEdge: ViewEdge, withInset: CGFloat, relation: NSLayoutConstraint.Relation)
    {
        var offset = inset
        if (edgeToSuperViewEdge == .bottom) ^^ ((edgeToSuperViewEdge == .left))
        {
            offset = -inset
        }
        self.pin(edge: edgeToSuperViewEdge, toEdge: edgeToSuperViewEdge, ofView: self.superview, withOffset: offset, relation: relation)
    }
    
    func pin(edge: ViewEdge, toEdge: ViewEdge, ofView: UIView, withOffset: CGFloat, relation: NSLayoutConstraint.Relation)
    {
        let constraint = NSLayoutConstraint(item: self, attribute: edge.rawValue, relatedBy: relation, toItem: ofView, attribute: ToEdge.rawValue, multiplier: 1.0, constant: withOffset)
        constraint.active = true
    }
    
    func alignAxis(toSuperViewAxis: ViewAxis)
    {
        let constraint = NSLayoutConstraint(item: self, attribute: toSuperViewAxis.rawValue, relatedBy: .equal, toItem: self.superview, attribute: toSuperViewAxis.rawValue, multiplier: 1.0, constant: 0)
        constraint.active = true
    }
    
    func match(dimension: ViewSize, toDimension: ViewSize, ofView: UIView)
    {
        let constraint = NSLayoutConstraint(item: self, attribute: dimension.rawValue, relatedBy: .equal, toItem: ofView, attribute: toDimension.rawValue, multiplier: 1.0, constant: 0)
        constraint.active = true
    }
    
    func set(dimension: ViewSize, to: CGFloat)
    {
        let constraint = NSLayoutConstraint(item: self, attribute: dimension.rawValue, relatedBy: .equal, toItem: self.superview, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
//        NSLayoutAttributeNotAnAttribute
        constraint.active = true
    }
}
