
import UIKit

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Int
        
        switch section {
            case 0:
                rowCount = 5
            default:
                rowCount = self.friends.count
        }
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        
        switch section {
            case 0:
                title = "Important"
            default:
                title = "My friends"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: horizontalUserPreviewId) as! HorizontalUserPreviewTableViewCell
        
        switch indexPath.section {
            case 0:
                self.updateImage(cell: cell, url: self.friends[indexPath.row].photo)
                cell.surnameNameTextLabel.text = self.friends[indexPath.row].name + " " + self.friends[indexPath.row].surname
                cell.cityTextLabel.text = self.friends[indexPath.row].city
            default:
                self.updateImage(cell: cell, url: self.friends[indexPath.row].photo)
                cell.surnameNameTextLabel.text = self.friends[indexPath.row].name + " " + self.friends[indexPath.row].surname
                cell.cityTextLabel.text = self.friends[indexPath.row].city
        }
        
        cell.actionImageView.image = UIImage(systemName: "message")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let borderView = UIView()
        let headerLabel = UILabel(frame:CGRect(x: 10, y: 15, width: tableView.bounds.width, height: tableView.bounds.size.height))
        let headerView = UIView()
        
        borderView.backgroundColor = UIColor.systemGray6
        borderView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        borderView.frame = CGRect(x: 10, y: 5, width: tableView.bounds.width, height: 1)

        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor.black
        headerLabel.font = .boldSystemFont(ofSize: 17)
        headerLabel.sizeToFit()

        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        headerView.addSubview(borderView)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToFriendProfile", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToFriendProfile" {
            if let friendVC = segue.destination as? FriendViewController {
                let indexPath = sender as! IndexPath
                var friend: Friend?
                
                switch indexPath.section {
                    case 0:
                        friend = self.friends[indexPath.row]
                    default:
                        friend = self.friends[indexPath.row]
                }
                
                friendVC.personalInfo = friend
            }
        }
    }
    
    /// Асинхронное обновление фото друзей
    func updateImage(cell: HorizontalUserPreviewTableViewCell, url: String) {
        if let url = URL(string: url) {
            // подргузка фото друзей
            cell.DownloadIndicator.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = contentsOfURL {
                            cell.profilePhotoImageView.image = UIImage(data: imageData)
                    }
                    cell.DownloadIndicator.stopAnimating()
                }
            }
        }
    }
}
