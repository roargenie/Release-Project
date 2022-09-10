

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        setNavigationBar()
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    
    func setNavigationBar() { }
    
    
}
