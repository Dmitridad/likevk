import UIKit

class HorizontalUserPreviewTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var surnameNameTextLabel: UILabel!
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var DownloadIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupProfilePhotoImageView()
    }
    
    private func setupProfilePhotoImageView() {
        profilePhotoImageView.layer.cornerRadius = 30
    }
}
