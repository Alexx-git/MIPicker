//
//  UIView+UsefulConstraint.swift
//  MultipleImagePicker
//
//  Created by VLADIMIR on 3/26/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func pinToSuperview()
    {
        self.pinToSuperview(withEdgeInsets: .zero)
    }
    
    func pinToSuperview(withEdgeInsets: UIEdgeInsets)
    {
        if self.superview != nil
        {
            self.pin(edgeToSuperViewEdge: .top, withInset: withEdgeInsets.top, relation: .equal)
            self.pin(edgeToSuperViewEdge: .bottom, withInset: withEdgeInsets.bottom, relation: .equal)
            self.pin(edgeToSuperViewEdge: .right, withInset: withEdgeInsets.right, relation: .equal)
            self.pin(edgeToSuperViewEdge: .left, withInset: withEdgeInsets.left, relation: .equal)
        }
        
    }
    
    func pin(edgeToSuperViewEdge: NSLayoutConstraint.Attribute, withInset: CGFloat, relation: NSLayoutConstraint.Relation)
    {
        var offset = withInset
        var newRelation = relation
        if (edgeToSuperViewEdge == .bottom) || ((edgeToSuperViewEdge == .right))
        {
            offset = -withInset
            if relation == .greaterThanOrEqual
            {
                newRelation = .lessThanOrEqual
            }
            if relation == .lessThanOrEqual
            {
                newRelation = .greaterThanOrEqual
            }
        }
        if let superview = self.superview
        {
            self.pin(edge: edgeToSuperViewEdge, toEdge: edgeToSuperViewEdge, ofView: superview, withOffset: offset, relation: newRelation)
        }
    }
    
    func pin(edge: NSLayoutConstraint.Attribute, toEdge: NSLayoutConstraint.Attribute, ofView: UIView, withOffset: CGFloat, relation: NSLayoutConstraint.Relation)
    {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: relation, toItem: ofView, attribute: toEdge, multiplier: 1.0, constant: withOffset)
        constraint.isActive = true
    }
    
    func alignAxis(toSuperViewAxis: NSLayoutConstraint.Attribute)
    {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: toSuperViewAxis, relatedBy: .equal, toItem: self.superview, attribute: toSuperViewAxis, multiplier: 1.0, constant: 0)
        constraint.isActive = true
    }
    
    func match(dimension: NSLayoutConstraint.Attribute, toDimension: NSLayoutConstraint.Attribute, ofView: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: dimension, relatedBy: .equal, toItem: ofView, attribute: toDimension, multiplier: 1.0, constant: 0)
        constraint.isActive = true
    }
    
    func setDimensions(toSize: CGSize)
    {
        self.set(dimension: .width, to: toSize.width)
        self.set(dimension: .height, to: toSize.height)
    }
    
    func set(dimension: NSLayoutConstraint.Attribute, to: CGFloat)
    {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: dimension, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 0)
//        NSLayoutAttributeNotAnAttribute
        constraint.isActive = true
    }
}
