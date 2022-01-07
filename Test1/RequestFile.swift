//
//  RequestFile.swift
//  Test1
//
//  Created by Gokberk Ozcan on 28.12.2021.
//

import Foundation
import Drive_ServiceRequests
protocol ResponseDelegate : AnyObject {
    func didReceiveResponse(data: String?)
}
class RequestFile : NSObject{
   
    
    
    weak var responseDelegate : ResponseDelegate?
    func LogolarListesiGetir(){
        
        
        let req = LogolarListesiGetirDisaridan()
        let postObj = LogolarListesiGetirDisaridan.post(
            alias: "GgYLfKZTC1vzhlRkUCKgNmL/",
            tip: "17",
            dil: "TR",
            versiyon: "11354"
        )
        let postParams = req.initPost(post: postObj)
        let commonRequestObj = RequestObjCommon(parameters: postParams, nesil: req.nesil)
        
        let driveSVC = Drive_ServiceRequests(
            isSSLPinningEnabled: .Yes,
            serviceURL: "https://tibdsf.isnet.net.tr/DasMainMobileServices/Service.svc/LogolarListesiGetirDisaridan")
        
        driveSVC.setHttpRequest(requestObj: commonRequestObj, completionBlock: { (result) in
            switch result {
            case .success(let data):
                if let responseObj = LogolarListesiGetirDisaridan().initResponse(response: data) {
                    let responseStr = serializeObject(responseObj)
                    self.responseDelegate?.didReceiveResponse(data: responseStr)
//                    print(responseStr)
                    
                }
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    
    
}
internal func serializeObject<T: Encodable>(_ value: T) -> String {
    do {
        let encodedData = try JSONEncoder().encode(value)
        if let encodedString = String(data: encodedData, encoding: .utf8) {
            return encodedString
        }
    } catch let error {
        print(error.localizedDescription)
    }
    return String()
    
}

