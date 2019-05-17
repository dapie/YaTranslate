//
//  ViewController.swift
//  YaTranslate
//
//  Created by Denis Tkachev on 17/05/2019.
//  Copyright © 2019 Denis Tkachev. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstView.makeCard();
        secondView.makeCard();
    }

}

func makeRequest(word: String){
}

extension UIView {
    func makeCard(){
        layer.cornerRadius = 10;
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowOffset = CGSize(width: 0, height: 14)
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 18
        layer.masksToBounds = false
    }
}
