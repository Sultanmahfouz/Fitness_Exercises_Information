import UIKit

class MuscleExerciseCell: UITableViewCell {

    @IBOutlet weak var muscleExerciseImageView: UIImageView!
    
    @IBOutlet weak var muscleExerciseTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
