//
//  Extensions.swift
//  IosDeveloperCodeTest
//
//  Created by a k azad on 26/7/20.
//  Copyright © 2020 a k azad. All rights reserved.
//

import UIKit

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension UIViewController{
    func setUpCardView(uiview : UIButton){
        uiview.backgroundColor = UIColor.white
        uiview.layer.cornerRadius = 5.0
        uiview.layer.masksToBounds = false
        
        uiview.layer.shadowColor = (UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.5)).cgColor
        uiview.layer.shadowOffset = CGSize(width: 1, height: 1)
        uiview.layer.shadowOpacity = 1
    }
    
    func setUpCardView(uiview : UITextView){
        uiview.backgroundColor = UIColor.white
        uiview.layer.cornerRadius = 5.0
        uiview.layer.masksToBounds = false
        
        uiview.layer.shadowColor = (UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.5)).cgColor
        uiview.layer.shadowOffset = CGSize(width: 1, height: 1)
        uiview.layer.shadowOpacity = 1
    }
    
}

