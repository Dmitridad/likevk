
import UIKit
import RealmSwift

class FriendListViewController: UIViewController {
    
    var dataBaseService = DataBaseService.commonService
    var realm = RealmHelper()
    let horizontalUserPreviewId: String = "HorizontalUserPreviewTableViewCell"
    var friends = [Friend]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var scanQrButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var thirdFriendRequestImageView: UIImageView!
    @IBOutlet weak var secondFriendRequestImageView: UIImageView!
    @IBOutlet weak var firstFriendRequestImageView: UIImageView!
    @IBOutlet weak var friendRequestCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: self.horizontalUserPreviewId, bundle: nil), forCellReuseIdentifier: self.horizontalUserPreviewId)
        
        self.searchTextField.layer.cornerRadius = 10
        self.searchTextField.setLeftImage(image: UIImage(systemName: "magnifyingglass")!, color: UIColor.systemGray4, size: 15)
        
        self.friendRequestCountLabel.layer.cornerRadius = 15
        
        self.setupButtons(for: [self.scanQrButton, self.addFriendButton])
        self.setupfriendsRequests(for: [self.firstFriendRequestImageView, self.secondFriendRequestImageView, self.thirdFriendRequestImageView])
        
//        self.tableView.reloadData()
    }
    
    /// Установка параметров для определенных кнопок
    private func setupButtons(for buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 10
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.systemGray6.cgColor
            button.layer.borderWidth = 0.7
            button.layer.shadowColor = UIColor.systemGray.cgColor
            button.layer.shadowOffset = CGSize(width: 10, height: 10)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 20
            button.layer.masksToBounds = false
        }
    }
    
    /// Установка параметров для запросов в друзья
    private func setupfriendsRequests(for batch: [UIImageView]) {
        
        for imageView in batch {
            imageView.layer.cornerRadius = 30
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.white.cgColor
        }
        
        let reversedArray: [User] = self.dataBaseService.friendsRequests.reversed()
        
        // hardcode
        self.thirdFriendRequestImageView.image = reversedArray[0].profilePhoto
        self.secondFriendRequestImageView.image = reversedArray[1].profilePhoto
        self.firstFriendRequestImageView.image = reversedArray[2].profilePhoto
        
        self.friendRequestCountLabel.text = String(self.dataBaseService.friendsRequests.count)
    }
}
