

import UIKit


final class ThirdHomeDetailViewController: BaseViewController {
    
    var mainView = ThirdHomeDetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 150
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        
    }
    
    
}


extension ThirdHomeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdHomeDetailTableViewCell.reuseIdentifier, for: indexPath) as? ThirdHomeDetailTableViewCell else { return UITableViewCell() }
        
        
        return cell
    }
    
}
