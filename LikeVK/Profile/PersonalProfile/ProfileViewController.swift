
import UIKit
import VK_ios_sdk

class ProfileViewController: UIViewController {
    
    var dataBaseService = DataBaseService.commonService
    var photoGalleryService = PhotoGalleryService.commonGallery
    let verticalUserPreviewId = "VerticalUserPreviewCollectionViewCell"
    let userPhotoPreviewId = "UserPhotoPreviewCollectionViewCell"
    let feedId = "FeedTableViewCell"
    var personalInfo: PersonalInfo?
    var friends = [Friend]()
    var realm = RealmHelper()
    var userDefaults = UserDefaultsHelper()
    
    @IBOutlet weak var mainPhotoImageView: UIImageView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userInfoContentView: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeImageView: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var workplaceImageView: UIImageView!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var friendsContentView: UIView!
    @IBOutlet weak var friendCountLabel: UILabel!
    @IBOutlet weak var friendListPreviewCollectionView: UICollectionView!
    @IBOutlet weak var photosContentView: UIView!
    @IBOutlet weak var photoCountLabel: UILabel!
    @IBOutlet weak var photoGalleryPreviewCollectionView: UICollectionView!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollContentViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
            
        // Получаем личные данные из хранилища
        if let personalInfo = self.realm.getPersonalInfo() {
            self.personalInfo = personalInfo
        } else {
            self.personalInfo = PersonalInfo()
        }
        
        // Получаем данные друзей из хранилища
        if let friends = self.realm.getFriends() {
            self.friends = friends
        }
        
        self.friendListPreviewCollectionView.delegate = self
        self.friendListPreviewCollectionView.dataSource = self
        self.friendListPreviewCollectionView.register(UINib(nibName: verticalUserPreviewId, bundle: nil), forCellWithReuseIdentifier: verticalUserPreviewId)
        
        self.photoGalleryPreviewCollectionView.delegate = self
        self.photoGalleryPreviewCollectionView.dataSource = self
        self.photoGalleryPreviewCollectionView.register(UINib(nibName: userPhotoPreviewId, bundle: nil), forCellWithReuseIdentifier: userPhotoPreviewId)
        
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        self.feedTableView.register(UINib(nibName: feedId, bundle: nil), forCellReuseIdentifier: feedId)
        
        self.mainPhotoImageView.layer.cornerRadius = 45
        self.editButton.layer.cornerRadius = 10
        
        self.setupTableViewHeight()
        self.addSeparators(viewArr: [self.userInfoContentView, self.friendsContentView, self.photosContentView])
        self.outputPersonalInfo()
        self.updateFriendsCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                
        self.updateFriendsCount()
    }
    
    /// Сброс всех данных входа для VK
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        VKSdk.forceLogout()
        
        userDefaults.deleteData(key: "vk_user_id")
        userDefaults.deleteData(key: "vk_access_token")
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendsList" {
            if let destinationVC = segue.destination as? FriendListViewController {
                destinationVC.friends = self.friends
            }
        } else if segue.identifier == "personalProfileToFriend" {
            if let friendVC = segue.destination as? FriendViewController {
                let indexPath = sender as! IndexPath
                
                friendVC.personalInfo = self.friends[indexPath.row]
            }
        }
    }
    
    /// Установка высоты TableView
    private func setupTableViewHeight() {
        let initialScrollViewHeight = self.scrollContentViewHeight.constant
        let initialFeedTableViewHeight = self.feedTableViewHeight.constant
        var feedCount: Int
        
        if self.dataBaseService.myself.feeds == nil {
            feedCount = 0
        } else {
            feedCount = self.dataBaseService.myself.feeds!.count
        }
        
        self.feedTableViewHeight.constant = self.feedTableView.rowHeight * CGFloat(feedCount)
        self.scrollContentViewHeight.constant = initialScrollViewHeight - initialFeedTableViewHeight + self.feedTableViewHeight.constant + 115
    }
    
    /// Добавление сепараторов для определенных View
    private func addSeparators(viewArr: [UIView]) {
        for view in viewArr {
            let separatorView = UIView()
            separatorView.backgroundColor = UIColor.systemGray6
            separatorView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            separatorView.frame = CGRect(x: 10, y: 0, width: 500, height: 1)
            
            view.addSubview(separatorView)
        }
    }
    
    /// Вывод личных данных из хранилища
    private func outputPersonalInfo() {
        if let personalInfo = self.personalInfo {
            
            if let url = URL(string: personalInfo.photo) {
                DispatchQueue.global(qos: .userInitiated).async {
                    let contentsOfURL = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let imageData = contentsOfURL {
                            self.mainPhotoImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            self.nameSurnameLabel.text = personalInfo.name + " " + personalInfo.surname
            self.summaryLabel.text = personalInfo.summary
            self.cityLabel.text = personalInfo.city
            self.degreeLabel.text = personalInfo.degree
            self.workplaceLabel.text = personalInfo.workplace
            self.followersCountLabel.text = String(personalInfo.followers) + " " + "followers"
        }
    }
    
    /// Обновление определенных элементов Label
    private func updateFriendsCount() {
        self.friendCountLabel.text = String(self.friends.count)
        self.photoCountLabel.text = String(photoGalleryService.images.count)
    }
}
