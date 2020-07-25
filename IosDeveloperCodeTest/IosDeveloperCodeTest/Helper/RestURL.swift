//
//  RestURL.swift
//  IosDeveloperCodeTest
//
//  Created by a k azad on 26/7/20.
//  Copyright © 2020 a k azad. All rights reserved.
//
import Foundation

public class RestURL : NSObject{
    static let sharedInstance = RestURL()
    public var url = "https://www.bioscopelive.com/en/disclaimer"
    
    public var codeTestUrl = ""
    
    override public init() {
        codeTestUrl = url + codeTestUrl
    }
    
    
    public func getCommonHeader()->[String:String]{
        
        let headers : [String:String] = [
            "Content-type" : "text/html",
        ]
        return headers
    }
    
}
