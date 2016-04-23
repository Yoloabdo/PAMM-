//
//  FeedsViewController.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/23/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feedsTableView: UITableView! {
        didSet{
            feedsTableView.delegate = self
            feedsTableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    struct StoryBoard {
        static let CellIDentfier = "feedsCell"
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellIDentfier) as! FeedsTableViewCell
        return cell
    }
}
