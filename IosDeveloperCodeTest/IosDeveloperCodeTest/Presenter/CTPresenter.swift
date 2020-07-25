//
//  CTPresenter.swift
//  IosDeveloperCodeTest
//
//  Created by a k azad on 26/7/20.
//  Copyright © 2020 a k azad. All rights reserved.
//

import UIKit

protocol CTViewDelegate : NSObjectProtocol {
    func setCTData(data : CTDataModel) 
    func onFailed(message : String)
    func showLoading()
    func hideLoading()
}
class CTPresenter: NSObject {
    
    private let service : CTService
    weak private var viewDelegate : CTViewDelegate?
    
    init(service : CTService) {
        self.service = service
    }
    
    func attachView(viewDelegate : CTViewDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func getCTDataFromServer(){
        self.viewDelegate?.showLoading()
        self.service.getCTData(success: { (data) in
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.setCTData(data: data)
        }, failure: { message in
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.onFailed(message: message)
        })
        
    }
    
}

