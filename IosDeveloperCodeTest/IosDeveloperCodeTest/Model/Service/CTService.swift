//
//  CTService.swift
//  IosDeveloperCodeTest
//
//  Created by a k azad on 26/7/20.
//  Copyright © 2020 a k azad. All rights reserved.
//

import UIKit

public class CTService: NSObject{
    func getCTData(success: @escaping (CTDataModel) -> (), failure : @escaping (String) -> ()){
        
        let session = URLSession.shared
        
        let url = RestURL.sharedInstance.codeTestUrl
        
        let dataURL = URL(string: url)!
        
        var request = URLRequest(url: dataURL)
        
        let headers = [
            "Content-Type": "text/html"
        ]
        
        request.allHTTPHeaderFields = headers
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let response = response as? HTTPURLResponse, response.isResponseOK() {
                guard let data = data else {
                    return
                }
                
                let contents = CTDataModel(cTData: data.html2String)
                success(contents)
            }
            guard let error = error else{
                return
            }
        })
        
        task.resume()
        
    }
    
    
}

extension HTTPURLResponse {
     func isResponseOK() -> Bool {
      return (200...299).contains(self.statusCode)
     }
}
