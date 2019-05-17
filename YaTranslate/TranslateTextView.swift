//
//  TranslateTextView.swift
//  YaTranslate
//
//  Created by Denis Tkachev on 17/05/2019.
//  Copyright © 2019 Denis Tkachev. All rights reserved.
//

import UIKit

class TranslateTextView: UITextView {
    
    @IBInspectable var delayValue : Double = 1.0
    var timer:Timer?
    
    var actionClosure : (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(changedTextFieldValue), for: .editingChanged)
    }
    
    func changedTextFieldValue(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(self.executeAction), userInfo: nil, repeats: false)
    }
    
    func executeAction(){
        actionClosure?()
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

}
