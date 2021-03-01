
import UIKit

// Расширение с настройкой TableView
extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: self.feedId, for: indexPath) as! FeedTableViewCell
        let myself = self.dataBaseService.myself
        if let feeds = myself.feeds {
            let feed = feeds[indexPath.row]
            
            if let personalInfo = self.personalInfo {
                
                if let url = URL(string: personalInfo.photo) {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let contentsOfURL = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            if let imageData = contentsOfURL {
                                cell.profilePhotoImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
                
                cell.nameSurnameLabel.text = personalInfo.name + " " + personalInfo.name
            }
            
            cell.publicationDateLabel.text = getFormattedDate(date: feed.publicationDate!)
            cell.summaryTextLabel.text = feed.text
            cell.mainImageView.image = feed.image
            cell.likeButton.setTitle(feed.likeCount?.description, for: .normal)
        }
        
        return cell
    }
    
    private func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        timeFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date) + " at " + timeFormatter.string(from: date)
    }
}

// Расширение с настройкой CollectionView
extension FriendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoGalleryService.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.photoGalleryPreviewCollectionView.dequeueReusableCell(withReuseIdentifier: self.userPhotoIdPreview, for: indexPath) as! UserPhotoPreviewCollectionViewCell
        cell.imageView.image = self.photoGalleryService.images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hight = collectionView.frame.height
        let width = hight
        
        return CGSize(width: width, height: hight)
    }
}
