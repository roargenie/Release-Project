

import UIKit


class BasePopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        setNavigationBar()
        view.backgroundColor = UIColor(red: 0.09957252358, green: 0.09957252358, blue: 0.09957252358, alpha: 0.8)
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    
    func setNavigationBar() { }
    
    func showAlertMessage(title: String, button: String, handler: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default, handler: handler)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
