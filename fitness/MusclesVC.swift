import UIKit

class MusclesVC: UIViewController {
    
    var muscles = [
        
        Muscle(name: "Chest", image: UIImage(named: "chest_muscle")),
        Muscle(name: "Back", image: UIImage(named: "back_muscle")),
        Muscle(name: "Shoulder", image: UIImage(named: "shoulder_muscle")),
        Muscle(name: "Legs", image: UIImage(named: "legs_muscle")),
        Muscle(name: "Bieceps", image: UIImage(named: "bieceps_muscle")),
        Muscle(name: "Triceps", image: UIImage(named: "triceps_muscle")),
        Muscle(name: "Stomach", image: UIImage(named: "stomach_muscle")),
        Muscle(name: "Side", image: UIImage(named: "side_muscle"))
    ]

    @IBOutlet weak var musclesTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        musclesTableView.dataSource = self
        musclesTableView.delegate = self
    }
}

extension MusclesVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muscles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleCell") as! MuscleCell
        
        cell.muscleTitleLabel.text = muscles[indexPath.row].name
        
        if muscles[indexPath.row].image != nil{
            cell.muscleImageView.image = muscles[indexPath.row].image
        }else{
            cell.muscleImageView.image = UIImage(named: "bieceps_muscle")
        }
        cell.muscleImageView.layer.cornerRadius = 10
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let muscleExercise = muscles[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "MuscleExercisesVC") as? MuscleExercisesVC
        
        if let viewController = vc{
           
            viewController.muscleLabel = muscleExercise.name
        
            navigationController?.pushViewController(viewController, animated: true)
       
        }
    }
    
    
}
