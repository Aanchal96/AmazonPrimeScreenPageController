//
//  ViewController.swift
//  MovieBuzz
//
//  Created by Appinventiv on 27/02/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let headerText = ["","Watch Next TV and Movies","Latest Movies","Thriller Movies","Action & Recommended Movies"]
    let bigMovieCell = ["LBogan","LCivilwar","LDarkknight","LHaider","LIronman","LLegion","LInception","LFida","LSherlockholmes","LPirates"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDataSourceDelegate()
        tableView.backgroundColor = UIColor.black
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: --> Table view delegates and data source methods
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func setDataSourceDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pageControlCell") as! PageControlCell
        cell.section = indexPath.section
        cell.row = indexPath.row
        return cell
    }
    
    //MARK: --> Delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 180
        }
        else {
            return 125
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            return header
        }
        else {
            let header = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            header.headerTitle.text = self.headerText[section]
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 64
        }
        else{
            return 50
        }
    }
}
