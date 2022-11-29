//
//  GradientView.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 05.10.17.
//
#if os(iOS)
import UIKit

class GradientView: UIView {
    
    public var gradientLayer: CAGradientLayer!
    
    open override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    private func style() {
        gradientLayer = layer as? CAGradientLayer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        let color = UIColor.groupTableViewBackground
        gradientLayer.colors = [color.withAlphaComponent(0.0).cgColor, color.cgColor]
        backgroundColor = UIColor.white.withAlphaComponent(0.0)
    }
}
#endif
