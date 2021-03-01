//
//  TestTableViewViewController.swift
//  likeVK
//
//  Created by Jambau on 09.11.2020.
//

import UIKit

class TestTableViewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let IDENTIFIER: String = "TestTableViewCell"
    var friendListService = FriendListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: IDENTIFIER, bundle: nil), forCellReuseIdentifier: IDENTIFIER)
    }
}

extension TestTableViewViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Int
        switch section {
            case 0:
                rowCount = friendListService.important.count
            case 1:
                rowCount = 3
            default:
                rowCount = friendListService.myFriends.count
            }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        switch section {
            case 0:
                title = "Important"
            case 1:
                title = "Potential friends"
            default:
                title = "My friends"
            }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER) as! TestTableViewCell
        switch indexPath.section {
            case 0:
                cell.profilePhotoImageView.image = friendListService.important[indexPath.row].profilePhoto
                cell.surnameNameTextLabel.text = friendListService.important[indexPath.row].name + " " + friendListService.important[indexPath.row].surname
            case 1:
                cell.profilePhotoImageView.image = friendListService.potential[indexPath.row].profilePhoto
                cell.surnameNameTextLabel.text = friendListService.potential[indexPath.row].name + " " + friendListService.potential[indexPath.row].surname
            default:
                cell.profilePhotoImageView.image = friendListService.myFriends[indexPath.row].profilePhoto
                cell.surnameNameTextLabel.text = friendListService.myFriends[indexPath.row].name + " " + friendListService.myFriends[indexPath.row].surname
            }
        
        return cell
    }
}
