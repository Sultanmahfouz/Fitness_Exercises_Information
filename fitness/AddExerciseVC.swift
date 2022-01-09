import UIKit

class AddExerciseVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var exerciseTitleLabel: UITextField!
    @IBOutlet weak var exerciseWeight: UITextField!
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    var isNew: Bool = true
    var editedExercise: MuscleExercise?
    var muscleType: String?
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var exerciseCommentsLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseWeight.keyboardType = .decimalPad
        exerciseImageView.image = UIImage(named: "back_muscle")
        if !isNew{
            mainButton.setTitle("Edit Exercise", for: .normal)
            headerTitleLabel.text = "Edit Exercise"
            exerciseImageView.image = editedExercise?.image
        }
        
        if let editExercise = editedExercise{
            exerciseTitleLabel.text = editExercise.exerciseName
            exerciseCommentsLabel.text = editExercise.comment
            exerciseWeight.text = String(editExercise.weight)
        }
        self.exerciseWeight.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return exerciseWeight.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func changeImageFunctionButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func addExerciseFunc(_ sender: Any) {
        let randomId = NSUUID().uuidString
        if isNew{
            let exercise = MuscleExercise(id: randomId,
                muscleName: muscleType!, exerciseName: exerciseTitleLabel.text ?? "", weight: Double(exerciseWeight.text ?? "0") ?? 0, comment: exerciseCommentsLabel.text, image: exerciseImageView.image)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newExerciseAdded"), object: nil, userInfo: ["addedExercise": exercise])
            
            let alert = UIAlertController(title: "New Exercise", message: "New Exercise has been added successfully ✅", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
       
        }else{
            
            let editingExercise = MuscleExercise(id: editedExercise?.id ?? "", muscleName: editedExercise!.muscleName, exerciseName: exerciseTitleLabel.text ?? "", weight: Double(exerciseWeight.text ?? "0") ?? 0, comment: exerciseCommentsLabel.text ,image: exerciseImageView.image)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "currentExerciseEdited"), object: nil, userInfo: ["updatedExercise": editingExercise])
            
            
            let alert = UIAlertController(title: "Update Exercise", message: "Exercise has been updated successfully ✅", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { UIAlertAction in
                self.dismiss(animated: true, completion: nil)
                
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    
}


extension AddExerciseVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true, completion: nil)
        exerciseImageView.image = image
    }
}
