//
//  UIView+Constraints.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

import UIKit

public extension UIView {
    public enum FillingDirection {
        case horizontaly, verticaly
    }
    
    public enum DimensionAttribute {
        case width, height
    }
    
    public func fill(_ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
        
        result.merge(fill(.horizontaly, view, constant: constant, multiplier: multiplier, active: active)) { (current, _) -> NSLayoutConstraint in current }
        result.merge(fill(.verticaly, view, constant: constant, multiplier: multiplier, active: active)) { (current, _) -> NSLayoutConstraint in current }
        return result
    }
    
    public func fill(_ type: FillingDirection, _ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        return fill(type, view, leading: constant, trailing: constant, multiplier: multiplier, active: active)
    }
    
    public func fill(_ type: FillingDirection, _ view: Any, leading: CGFloat, trailing: CGFloat, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
        
        switch type {
        case .horizontaly:
            result[.leading] = constraint(.leading, to: view, constant: leading, multiplier: multiplier, active: active)
            result[.trailing] = constraint(.trailing, to: view, constant: trailing, multiplier: multiplier, active: active)
        case .verticaly:
            result[.top] = constraint(.top, to: view, constant: leading, multiplier: multiplier, active: active)
            result[.bottom] = constraint(.bottom, to: view, constant: trailing, multiplier: multiplier, active: active)
        }
        return result
    }
    
    public func center(_ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
        
        result[.centerX] = center(.horizontaly, view, constant: constant, multiplier: multiplier, active: active)
        result[.centerY] = center(.verticaly, view, constant: constant, multiplier: multiplier, active: active)
        return result
    }
    
    public func center(_ type: FillingDirection, _ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        switch type {
        case .horizontaly: return constraint(.centerX, to: view, constant: constant, multiplier: multiplier, active: active)
        case .verticaly: return constraint(.centerY, to: view, constant: constant, multiplier: multiplier, active: active)
        }
    }
    
    public func constraint(dimension attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        var constraint = NSLayoutConstraint()
        
        switch attribute {
        case .height, .width: constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constant)
        default: return NSLayoutConstraint()
        }
        constraint.isActive = active
        return constraint
    }
    
    public func constraint(_ attribute: NSLayoutAttribute, to view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        return constraint(attribute, to: view, attribute, constant: constant, multiplier: multiplier, active: active)
    }
    
    public func constraint(_ attribute: NSLayoutAttribute, to view: Any, _ parentAttribute: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        guard view as? UIView != nil || view as? UILayoutGuide != nil else {
            fatalError("[ToolboxLGNT]: Constraint can only be applied between view and another UIView or a UILayoutGuide.")
        }
        
        var inverse: CGFloat {
            switch attribute {
            case .bottom, .trailing, .right: return -1
            default: return 1
            }
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: parentAttribute, multiplier: multiplier, constant: constant * inverse)
        
        translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = active
        return constraint
    }
}
