import UIKit

class MuscleExercisesVC: UIViewController {
    
    
    // needs to be filtered depending on the muscle type
    var exercises = [
        
        // Back
        MuscleExercise(id: "188811111", muscleName: "Back", exerciseName: "Lat Machine", weight: 20, comment: "An exercise for me", image: UIImage(named: "back_latMachine")),
        MuscleExercise(id: "1886756453111", muscleName: "Back", exerciseName: "Lower Back", weight: 30, comment: "An exercise for me", image: UIImage(named: "back_lowerBack")),
        MuscleExercise(id: "565745", muscleName: "Back", exerciseName: "Low Row", weight: 40, comment: "An exercise for me", image: UIImage(named: "back_lowRow")),
        MuscleExercise(id: "565745", muscleName: "Back", exerciseName: "Pulley", weight: 50, comment: "An exercise for me", image: UIImage(named: "back_pulley")),
        MuscleExercise(id: "56545", muscleName: "Back", exerciseName: "Upper Back", weight: 70, comment: "An exercise for me", image: UIImage(named: "back_upperBack")),
        
        
        // Chest
        MuscleExercise(id: "6785746", muscleName: "Chest", exerciseName: "Fly", weight: 20, comment: "An exercise for me", image: UIImage(named: "chest_fly")),
        MuscleExercise(id: "437557555", muscleName: "Chest", exerciseName: "Free Press", weight: 30, comment: "An exercise for me", image: UIImage(named: "chest_freePress")),
        MuscleExercise(id: "43256787", muscleName: "Chest", exerciseName: "Pectoral", weight: 40, comment: "An exercise for me", image: UIImage(named: "chest_pectoral")),
        MuscleExercise(id: "43256787", muscleName: "Chest", exerciseName: "Press", weight: 50, comment: "An exercise for me", image: UIImage(named: "chest_press")),
        
        
        // Shoulder
        MuscleExercise(id: "654753625", muscleName: "Shoulder", exerciseName: "Delts", weight: 30, comment: "An exercise for me", image: UIImage(named: "shoulder_delts")),
        
        MuscleExercise(id: "1886541", muscleName: "Shoulder", exerciseName: "Press", weight: 60, comment: "An exercise for me", image: UIImage(named: "shoulder_press")),
        
        MuscleExercise(id: "2135467654", muscleName: "Shoulder", exerciseName: "Reverse Fly", weight: 50, comment: "An exercise for me", image: UIImage(named: "shoulder_reverseFly")),
        
        
        // Legs
        MuscleExercise(id: "6525", muscleName: "Legs", exerciseName: "Abductor", weight: 30, comment: "An exercise for me", image: UIImage(named: "legs_abductor")),
        MuscleExercise(id: "186541", muscleName: "Legs", exerciseName: "Leg Extention", weight: 60, comment: "An exercise for me", image: UIImage(named: "legs_legExtention")),
        MuscleExercise(id: "456765422", muscleName: "Legs", exerciseName: "Leg Press", weight: 50, comment: "An exercise for me", image: UIImage(named: "legs_legPress")),
        MuscleExercise(id: "455555422", muscleName: "Legs", exerciseName: "Squad", weight: 34, comment: "An exercise for me", image: UIImage(named: "legs_squad")),
        MuscleExercise(id: "456777422", muscleName: "Legs", exerciseName: "Prone Leg Curl", weight: 50, comment: "An exercise for me", image: UIImage(named: "legs_proneLegCurl")),
        
        
    ]


    var muscleLabel: String!
    
    @IBOutlet weak var muscleTitleLabel: UILabel!
    @IBOutlet weak var addNewExerciseButton: UIButton!
    
    @IBOutlet weak var muscleExercisesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(newExerciseAdd), name: NSNotification.Name("newExerciseAdded"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateExercise), name: NSNotification.Name("currentExerciseEdited"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteExercise), name: NSNotification.Name("deleteExercise"), object: nil)

        muscleExercisesTableView.dataSource = self
        muscleTitleLabel.text = muscleLabel
        muscleExercisesTableView.delegate = self
        
        addNewExerciseButton.layer.cornerRadius = 10
        
//        currentExercises = exercises.filter{ exercise in
//            return exercise.muscleName == muscleLabel
//        }
    }
    
    @objc func deleteExercise(notification: Notification){
        
        let exercise = notification.userInfo?["deletedExercise"] as? MuscleExercise
        
        if let deletedExercise = exercise {
            
            if let row = self.exercises.firstIndex(where: {$0.id == deletedExercise.id}) {
                
                exercises.remove(at: row)
                muscleExercisesTableView.reloadData()
            }
        }
        
    }
    
    @objc func newExerciseAdd(notification: Notification){
        let exercise = notification.userInfo?["addedExercise"] as? MuscleExercise
        
        if let newExercise = exercise {
            exercises.append(newExercise)
            muscleExercisesTableView.reloadData()
            
        }
    }
    
    @objc func updateExercise(notification: Notification){
        let updatedExercise = notification.userInfo?["updatedExercise"] as? MuscleExercise
        
        
        if let newUpdateExercise = updatedExercise{
            
            // TBD
            
//            var indexUpdatedExercise =
//
//
//            exercises[
//                exercises.filter{
//                    exercise in return exercise.id == newUpdateExercise.id
//                }.first
//            ] = newUpdateExercise

            if let row = self.exercises.firstIndex(where: {$0.id == newUpdateExercise.id}) {
                print(row)
                   exercises[row] = newUpdateExercise
                muscleExercisesTableView.reloadData()
            }
//            print(exercises.count)

            
            
        }
    }
    

    @IBAction func addNewExerciseFunction(_ sender: Any) {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddExerciseVC") as? AddExerciseVC
        
                if let viewController = vc{
                    viewController.muscleType = muscleLabel
                    present(viewController, animated: true, completion: nil)
                }
    }

    
    

}

extension MuscleExercisesVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.filter{ exercise in
                        return exercise.muscleName == muscleLabel
        }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleExerciseCell") as! MuscleExerciseCell
        
        cell.muscleExerciseTitleLabel.text =  exercises.filter{ exercise in
                        return exercise.muscleName == muscleLabel
                    }[indexPath.row].exerciseName
        
        cell.muscleExerciseImageView.image = exercises.filter{ exercise in
            return exercise.muscleName == muscleLabel
        }[indexPath.row].image
        
        cell.muscleExerciseImageView.layer.cornerRadius = 12
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenExercise = exercises.filter{ exercise in
            return exercise.muscleName == muscleLabel
        }[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailsVC") as? ExerciseDetailsVC

        if let viewController = vc{
            viewController.exercise = chosenExercise
            
            navigationController?.pushViewController(viewController, animated: true)

        }
    }
    
}
