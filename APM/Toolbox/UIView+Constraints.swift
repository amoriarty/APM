//
//  UIView+Constraints.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

extension UIView {
	enum FillingType {
		case horizontaly, verticaly
	}
	enum DimensionAttribute {
		case width, height
	}
	
	func fill(_ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
		var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
		
		result.merge(fill(.horizontaly, view, constant: constant, multiplier: multiplier, active: active)) { (current, _) -> NSLayoutConstraint in current }
		result.merge(fill(.verticaly, view, constant: constant, multiplier: multiplier, active: active)) { (current, _) -> NSLayoutConstraint in current }
		return result
	}
	
	func fill(_ type: FillingType, _ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
		return fill(type, view, leading: constant, trailing: constant, multiplier: multiplier, active: active)
	}
	
	func fill(_ type: FillingType, _ view: UIView, leading: CGFloat, trailing: CGFloat, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
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
	
	func center(_ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
		var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
		
		result[.centerX] = center(.horizontaly, view, constant: constant, multiplier: multiplier, active: active)
		result[.centerY] = center(.verticaly, view, constant: constant, multiplier: multiplier, active: active)
		return result
	}
	
	func center(_ type: FillingType, _ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
		switch type {
		case .horizontaly: return constraint(.centerX, to: view, constant: constant, multiplier: multiplier, active: active)
		case .verticaly: return constraint(.centerY, to: view, constant: constant, multiplier: multiplier, active: active)
		}
	}
	
	func constraint(dimension attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
		var constraint = NSLayoutConstraint()
		
		switch attribute {
		case .height, .width: constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constant)
		default: return NSLayoutConstraint()
		}
		constraint.isActive = active
		return constraint
	}
	
	func constraint(_ attribute: NSLayoutAttribute, to view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
		return constraint(attribute, to: view, attribute, constant: constant, multiplier: multiplier, active: active)
	}
	
	func constraint(_ attribute: NSLayoutAttribute, to view: UIView, _ parentAttribute: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
		var inverse: CGFloat {
			switch attribute {
			case .bottom, .trailing, .right: return -1
			default: return 1
			}
		}
		
		let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: parentAttribute, multiplier: multiplier, constant: constant * inverse)
		
		constraint.isActive = active
		return constraint
	}
}
