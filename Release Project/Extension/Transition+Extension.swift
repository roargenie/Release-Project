

import UIKit


extension UIViewController {
    
    enum TransitionStyle {
        case presentFull
        case present
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
        
        switch transitionStyle {
        case .presentFull:
            let nav = UINavigationController(rootViewController: viewController)
            viewController.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        case .present:
            self.present(viewController, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}


