//
//  CardView.swift
//  YaTranslate
//
//  Created by Denis Tkachev on 17/05/2019.
//  Copyright © 2019 Denis Tkachev. All rights reserved.
//

import UIKit

class CardView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup () {
        layer.cornerRadius = 10;
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowOffset = CGSize(width: 0, height: 14)
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 18
        layer.masksToBounds = false
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
