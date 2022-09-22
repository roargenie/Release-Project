

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        setNavigationBar()
        view.backgroundColor = .white
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    
    func setNavigationBar() { }
    
    
}
