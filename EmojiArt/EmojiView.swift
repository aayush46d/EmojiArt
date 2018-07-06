//
//  EmojiView.swift
//  EmojiArt
//
//  Created by Eyephone Developer on 7/5/18.
//  Copyright © 2018 Eyephone Developer. All rights reserved.
//

import UIKit

class EmojiView: UIView, UIDropInteractionDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    //MARK:- DRop
    private func setUp() {
        addInteraction(UIDropInteraction(delegate: self))
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSAttributedString.self) {provider in
            let dropPoint = session.location(in: self)
            
            for attributedString in provider as? [NSAttributedString] ?? [] {
                self.addLabel(with: attributedString, centeredAt: dropPoint)
            }
            
            
        }
    }
    
    private func addLabel (with attributedString: NSAttributedString, centeredAt point: CGPoint) {
        let label = UILabel()
        label.backgroundColor = .clear
        label.attributedText = attributedString
        label.sizeToFit()
        label.center = point
        addSubview(label)
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var backgroundImage: UIImage? { didSet {
//            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
 

}
