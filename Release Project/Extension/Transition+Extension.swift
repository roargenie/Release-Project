

import UIKit


extension UIViewController {
    
    @frozen enum TransitionStyle {
        case presentFull
        case present
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
        
        switch transitionStyle {
        case .presentFull:
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: true)
        case .present:
            self.present(viewController, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}


