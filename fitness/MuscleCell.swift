import UIKit

class MuscleCell: UITableViewCell {

    @IBOutlet weak var muscleTitleLabel: UILabel!
    
    @IBOutlet weak var muscleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
