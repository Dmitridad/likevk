
import UIKit

class FriendViewController: UIViewController {
    
    var dataBaseService = DataBaseService.commonService
    var photoGalleryService = PhotoGalleryService.commonGallery
    var user: User?
    var personalInfo: Friend?

    let verticalUserPreviewId: String = "VerticalUserPreviewCollectionViewCell"
    let userPhotoIdPreview: String = "UserPhotoPreviewCollectionViewCell"
    let feedId: String = "FeedTableViewCell"
    
    @IBOutlet weak var mainPhotoImageView: UIImageView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var addToFriendsButton: UIButton!
    @IBOutlet weak var userInfoContentView: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeImageView: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var workplaceImageView: UIImageView!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var photosContentView: UIView!
    @IBOutlet weak var photoCountLabel: UILabel!
    @IBOutlet weak var photoGalleryPreviewCollectionView: UICollectionView!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var scrollContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoGalleryPreviewCollectionView.delegate = self
        self.photoGalleryPreviewCollectionView.dataSource = self
        self.photoGalleryPreviewCollectionView.register(UINib(nibName: self.userPhotoIdPreview, bundle: nil), forCellWithReuseIdentifier: self.userPhotoIdPreview)
        
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        self.feedTableView.register(UINib(nibName: self.feedId, bundle: nil), forCellReuseIdentifier: self.feedId)
        
        self.mainPhotoImageView.layer.cornerRadius = 45
        
        self.messageButton.layer.cornerRadius = 10
        self.addToFriendsButton.layer.cornerRadius = 10
        
        self.setupTableViewHeight()
        self.addSeparators(viewArr: [self.userInfoContentView,  self.photosContentView])
        self.outputFriendInfo()
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
        
        self.feedTableViewHeight.constant = feedTableView.rowHeight * CGFloat(feedCount)
        self.scrollContentViewHeight.constant = initialScrollViewHeight - initialFeedTableViewHeight + self.feedTableViewHeight.constant
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
    
    /// Вывод личных данных друга из хранилища
    private func outputFriendInfo() {
                
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
        }
        
        self.photoCountLabel.text = String(photoGalleryService.images.count)
    }
}
