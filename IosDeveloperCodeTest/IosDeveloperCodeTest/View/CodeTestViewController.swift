//
//  ViewController.swift
//  IosDeveloperCodeTest
//
//  Created by a k azad on 26/7/20.
//  Copyright © 2020 a k azad. All rights reserved.
//

import UIKit
import WebKit

class CodeTestViewController: UIViewController{
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var apiCallBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var codeTestData: String?
    
    var presenter = CTPresenter(service: CTService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        
        self.enhanceActivityIndicator()
        
    }
    
    
    func initialSetup(){
        
        self.setUpCardView(uiview: textView)
        self.setUpCardView(uiview: apiCallBtn)
                
        //self.setupTextView()
        
        self.apiCallBtn.addTarget(self, action: #selector(onApiCallBtnTapped), for: .touchUpInside)
    }
    
    @objc func onApiCallBtnTapped(){
        self.attachPresenter()
        self.setupTextView()
    }
    
    func setupTextView(){
        //textView.contentInset = UIEdgeInsets()
        textView.clipsToBounds = true
    }
    
    func enhanceActivityIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
    }
    
    func showLoader(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoader(){
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CodeTestViewController{
    
    func lastCharacter(string: inout String) -> Character{
        
        string = String(string.filter { !" \n\t\r\0\\\"\'".contains($0) })
        
        var lastCharcter : Character?
        
        lastCharcter = string.last!
        
        return lastCharcter!
    }
    
    func tenthCharacter( string : inout String) -> String{
        
        string = self.removeSpecialCharacter(string: &string)
        
        var tengthString = ""
        
        for (index, char) in string.enumerated(){
            if index % 10 == 0{
                if !(index == 0) && char.isLetter == true{
                    tengthString = tengthString + String(char)
                }
            }
        }
        return tengthString
    }
    
    func removeSpecialCharacter(string: inout String) -> String{
        return String(string.filter { !" \n\t\r\0\\\"\'".contains($0) })
    }
    
    func wordCount(string: String) -> Int{
        var words: [Substring] = []
        string.enumerateSubstrings(in: string.startIndex..., options: .byWords) { _, range, _, _ in
            words.append(string[range])
        }
        return words.count
    }
    
}


extension CodeTestViewController {
    
    func firstQuestionAnswer() -> String{
        guard var string = self.codeTestData else {
            return ""
        }
        
        let lastCharacter = self.lastCharacter(string: &string)
        
        return String(lastCharacter)
        
    }
    
    func secondQuestionAnswer() -> String{
        guard var string = self.codeTestData else {
            return ""
        }
        
        let tengthCharacter = self.tenthCharacter(string: &string)
        
        return tengthCharacter
        
    }
    
    func thirdQuestionAnswer() -> String{
        guard let string = self.codeTestData else {
            return ""
        }
        
        let wordCount = self.wordCount(string: string)
        return "\(wordCount)"
    }
    
    func generateQuestionsAnswer() -> String{
        
        let firstQuestionAnswer = self.firstQuestionAnswer()
        let secondQuestionAnswer = self.secondQuestionAnswer()
        let thirdQuestionAnswer = self.thirdQuestionAnswer()
        
        let lastCharacter = textAppearance(string: "1. Last Character: ") + firstQuestionAnswer
        let everyTenthCharacter = textAppearance(string: "2. Every 10th Character : ") + secondQuestionAnswer
        let countOfEveryWord = textAppearance(string: "3. Count of Every word : ") + thirdQuestionAnswer
        
        let textViewText = lastCharacter + "\n\n" + everyTenthCharacter + "\n\n" + countOfEveryWord
        
        return textViewText
        
    }
    
    func updateUi(text textViewText: String){
        DispatchQueue.main.async {
            self.textView.text = textViewText
        }
    }
    
    func textAppearance(string: String) -> String{
        
        let myAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0)]
        let attributedString = NSMutableAttributedString(string: string, attributes: myAttribute )
        return attributedString.string
    }
    
    
}


extension CodeTestViewController : CTViewDelegate{
    func setCTData(data: CTDataModel) {
        self.codeTestData = data.cTData
        
        self.updateUi(text: self.generateQuestionsAnswer())
        
    }
    
    func onFailed(message: String) {
        self.showAlert(message: message)
    }
    
    func showLoading() {
        self.showLoader()
        DispatchQueue.main.async {
            
            self.apiCallBtn.isEnabled = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.apiCallBtn.isEnabled = true
        }
    }
    
    func attachPresenter(){
        self.presenter.attachView(viewDelegate: self)
        self.presenter.getCTDataFromServer()
    }
    
}




