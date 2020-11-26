import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    
    var selectedIndex = 0
    var photoImage: UIImage?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoNaviLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: Actions
    
    @IBAction func onCameraButtonTapped(_ sender: UIBarButtonItem) {
    
        let controller = UIAlertController(title: "", message: "どの方法で写真を読み込みますか？", preferredStyle: UIAlertController.Style.actionSheet)

        controller.addAction(UIAlertAction(title: "写真を撮影する", style: .default, handler: { (action) in self.selectedCamera()} ))
        controller.addAction(UIAlertAction(title: "カメラロールから読み込む", style: .default, handler: { (action) in self.selectedLibrary()} ))

        controller.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))

        if let popoverController = controller.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }

        self.present(controller, animated: true, completion: nil)

    }
    
    @IBAction func onSaveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onEditButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "MoveFilterListView", sender: nil)
    }
    

    // MARK: Methods
    
    func selectedCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(/*UIImagePickerController.SourceType*/.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func selectedLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? "" {
        case "MoveFilterListView":
            if let controller = segue.destination as? FilterListViewController {
                controller.delegate = self
                controller.selectedIndex = selectedIndex
            }
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }
}


// MARK: - UIImagePickerControllerDelegate+UINavigationControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            photoImageView.image = editedImage
            photoImage = editedImage
        }
        
        if photoImageView.image != nil {
            photoNaviLabel.isHidden = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}


// MARK: - FilterListViewControllerDelegate

extension MainViewController: FilterListViewControllerDelegate {
    
    func filterListViewController(_ controller: FilterListViewController, didSelectFilter filter: String, index: Int) {
        selectedIndex = index
    }
}
