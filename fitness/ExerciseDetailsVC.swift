import UIKit

class ExerciseDetailsVC: UIViewController {

    @IBOutlet weak var exerciseTitleLabel: UILabel!
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var exerciseCommentsLabel: UILabel!
    
    
    @IBOutlet weak var weightLabel: UILabel!
    var exercise: MuscleExercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseTitleLabel.text = exercise.exerciseName
        exerciseImageView.image = exercise.image
        exerciseCommentsLabel.text = exercise.comment
        weightLabel.text = String(exercise.weight)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateExercise), name: NSNotification.Name("currentExerciseEdited"), object: nil)
        
        
    }
    
    @objc func updateExercise(notification: Notification){
    let updatedExercise = notification.userInfo?["updatedExercise"] as? MuscleExercise
        
        exerciseTitleLabel.text = updatedExercise?.exerciseName
        exerciseImageView.image = updatedExercise?.image
        exerciseCommentsLabel.text = updatedExercise?.comment
        weightLabel.text = String(updatedExercise?.weight ?? 0)
        
    }
    
    
    @IBAction func editButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddExerciseVC") as? AddExerciseVC
        if let viewController = vc{
            viewController.isNew = false
            viewController.editedExercise = exercise
            present(viewController, animated: true, completion: nil)
           
        }
        
        
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        
        let confirmationAlert = UIAlertController(title: "Warning", message: "Are you sure you want to delete this exercise?", preferredStyle: UIAlertController.Style.alert)
        
        let confirmationAlertAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.destructive) { [self] alert in
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteExercise"), object: nil, userInfo: ["deletedExercise": self.exercise!])
            
            let alert = UIAlertController(title: "Delete Exercise", message: "Exercise has been deleted successfully", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
        }
        
        confirmationAlert.addAction(confirmationAlertAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        
        confirmationAlert.addAction(cancelAction)
        
        present(confirmationAlert, animated: true, completion: nil)
    }
}
