import UIKit

protocol FilterListViewControllerDelegate: class {
    func filterListViewController (_ controller: FilterListViewController, didSelectFilter filter: String, index: Int)
}

class FilterListViewController: UITableViewController {
    
    // MARK: Properties
    
    weak var delegate: FilterListViewControllerDelegate? = nil
    var selectedIndex = 0
    
    // Core Image Filter
    let filterList = ["",   // No Effect
                      "CIPhotoEffectChrome",
                      "CIPhotoEffectFade",
                      "CIPhotoEffectInstant",
                      "CIPhotoEffectNoir",
                      "CIPhotoEffectProcess",
                      "CIPhotoEffectTonal",
                      "CIPhotoEffectTransfer",
                      "CISepiaTone",
                      "CIVignette",]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterListCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        var filtername = filterList[indexPath.row]
        
        if filtername.isEmpty {
            filtername = "No Effect"
        }

        filterListCell.textLabel?.text = filtername
        
        // チェックをリセット
        filterListCell.accessoryType = UITableViewCell.AccessoryType.none
        
        // 選択された行にチェックを表示
        if indexPath.row == selectedIndex {
            filterListCell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        return filterListCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let myDelegate = delegate {
            myDelegate.filterListViewController(self, didSelectFilter: filterList[indexPath.row], index: indexPath.row)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
