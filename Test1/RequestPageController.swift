//
//  RequestPageController.swift
//  Test1
//
//  Created by Gokberk Ozcan on 28.12.2021.
//

import UIKit

class RequestPageController: UIViewController{
  
    


    @IBOutlet weak var requestScrollView: UIScrollView!
    
    @IBOutlet weak var lblMethodName: UILabel!
    
    @IBOutlet weak var lblRequest: UILabel!
    var methodName : String = ""
    var fileObject = RequestFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Request Details"
        lblMethodName.text = methodName
        LaunchFunction()
        fileObject.responseDelegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func LaunchFunction(){
//        if methodName == "LogolarListesiGetirDisaridan"{
//            fileObject.LogolarListesiGetir()
//        }
        switch methodName {
        case "LogolarListesiGetirDisaridan":
            fileObject.LogolarListesiGetir()

        default:
            print("nil")
        }
    }
    
    
    
    

}
extension  RequestPageController :  ResponseDelegate{
    func didReceiveResponse(data: String?) {
//        apply(data)
        DispatchQueue.main.async {
            self.lblRequest.text = data
        }
        
    }
    
    
}
