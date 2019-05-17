//
//  ViewController.swift
//  YaTranslate
//
//  Created by Denis Tkachev on 17/05/2019.
//  Copyright © 2019 Denis Tkachev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextViewDelegate{
    var transTimer: Timer?
    
    let langs = [
        "Русский": "ru",
        "Английский": "en"
    ]

    @IBOutlet var firstView: CardView!
    @IBOutlet var secondView: CardView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var transcriptionLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var posLabel: UILabel!
    @IBOutlet var changeLangImage: UIImageView!
    @IBOutlet var firstLangLabel: UILabel!
    @IBOutlet var secondLangLabel: UILabel!
    let dataArr = ["2,5","5,1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        changeLangImage.isUserInteractionEnabled = true
        changeLangImage.addGestureRecognizer(tapGestureRecognizer)
        textView.text = "Введите слово или текст"
        textView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func makeRequest(words: String){
        let lang = "\(langs[self.firstLangLabel.text!]!)-\(langs[self.secondLangLabel.text!]!)"
        if words.components(separatedBy: " ").filter({ !$0.isEmpty}).count == 1 {
            Alamofire
                .request("https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=\(Keys.dict)&lang=\(lang)&text=\(words)&ui=ru".addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
                .responseJSON { response in
                    print(response)
                    if let result = response.result.value {
                        let json = JSON(result);
                        self.resultLabel.text = json["def"][0]["tr"][0]["text"].stringValue.capitalizingFirstLetter()
                        self.transcriptionLabel.text = "[\(json["def"][0]["ts"])]"
                        self.wordLabel.text = json["def"][0]["text"].stringValue
                        self.posLabel.text = json["def"][0]["pos"].stringValue
                    }
            }
        } else {
            Alamofire
                .request("https://translate.yandex.net/api/v1.5/tr.json/translate?key=\(Keys.trnsl)&lang=\(lang)&text=\(words)&ui=ru".addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
                .responseJSON { response in
                    if let result = response.result.value {
                        let json = JSON(result);
                        self.resultLabel.text = json["text"][0].stringValue.capitalizingFirstLetter()
                        self.transcriptionLabel.text = ""
                        self.wordLabel.text = ""
                        self.posLabel.text = ""
                    }
            }
        }
    }
    
    @objc func imageTapped(){
        swap(&self.firstLangLabel.text, &self.secondLangLabel.text)
        self.textView.text = self.resultLabel.text
        refreshTimer()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        refreshTimer()
    }
    
    func refreshTimer(){
        transTimer?.invalidate()
        transTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
    }
    
    @objc func runTimedCode(){
        makeRequest(words: textView.text)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
