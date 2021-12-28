//
//  ViewController.swift
//  Test1
//
//  Created by Gokberk Ozcan on 19.11.2021.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var methodList: [String] = []
    var filteredData : [String]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drive_ServiceRequests"
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        GetMethodList()
        filteredData = methodList
        // Do any additional setup after loading the view.
   
    }
    
    
    func GetMethodList(){
        
        let documentsUrl = URL(string: "/Users/gokberkozcan/Documents/Drive_ServiceRequests/Requests/")
        let pathString = documentsUrl?.path
        do {
            
            let directoryContents = try FileManager.default.subpaths(atPath: pathString!)
            methodList = directoryContents!
            methodList.sort()
//            print(methodList)
            
        } catch {
            print("Error",error)
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == ""{
            filteredData = methodList
        }else{
            for methods in methodList{
                if methods.lowercased().contains(searchText.lowercased()){
                    filteredData.append(methods)
                }
            }
        }
       
        self.tableView.reloadData()
    }
  
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "requestViewController", sender: self)
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
}



