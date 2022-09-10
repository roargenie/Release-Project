

import UIKit
import SnapKit
import RealmSwift




final class HomeViewController: BaseViewController {
    
    var mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        
    }
    
}


