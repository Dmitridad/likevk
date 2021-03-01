
import UIKit

// Расширение с настройкой TableView
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: self.feedId, for: indexPath) as! FeedTableViewCell
        let myself = self.dataBaseService.myself
        
        if let feeds = myself.feeds {
            let feed = feeds[indexPath.row]
//            let myPersonalData = self.dataBaseService.getMyPersonalData()
                            
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
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemsCount: Int
        
        if collectionView == self.friendListPreviewCollectionView {
            itemsCount = self.friends.count
        } else {
            itemsCount = self.photoGalleryService.images.count
        }
        
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.friendListPreviewCollectionView {
            let cell = self.friendListPreviewCollectionView.dequeueReusableCell(withReuseIdentifier: self.verticalUserPreviewId, for: indexPath) as! VerticalUserPreviewCollectionViewCell
            
            if !(self.friends.isEmpty) {
                if let url = URL(string: self.friends[indexPath.row].photo) {
                    // подргузка фото друзей
                    DispatchQueue.global(qos: .userInitiated).async {
                        let contentsOfURL = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            if let imageData = contentsOfURL {
                                cell.profilePhotoImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
                
                cell.nameTextLabel.text = self.friends[indexPath.row].name
                cell.surnameTextLabel.text = self.friends[indexPath.row].surname
            }
            
            return cell
        } else {
            let cell = self.photoGalleryPreviewCollectionView.dequeueReusableCell(withReuseIdentifier: self.userPhotoPreviewId, for: indexPath) as! UserPhotoPreviewCollectionViewCell
            cell.imageView.image = self.photoGalleryService.images[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.friendListPreviewCollectionView {
            let hight = collectionView.frame.height - 10
            let width = hight * 0.7

            return CGSize(width: width, height: hight)
        } else {
            let hight = collectionView.frame.height
            let width = hight

            return CGSize(width: width, height: hight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.friendListPreviewCollectionView {
            self.performSegue(withIdentifier: "personalProfileToFriend", sender: indexPath)
        }
    }    
}
