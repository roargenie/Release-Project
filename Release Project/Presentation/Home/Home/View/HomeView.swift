

import UIKit


final class HomeView: BaseView {
    
//    let tableView: UITableView = {
//        let view = UITableView(frame: .zero, style: .plain)
//        view.register(HomeViewFirstTableViewCell.self, forCellReuseIdentifier: HomeViewFirstTableViewCell.reuseIdentifier)
//        view.register(HomeViewSecondTableViewCell.self, forCellReuseIdentifier: HomeViewSecondTableViewCell.reuseIdentifier)
//        view.register(HomeViewThirdTableViewCell.self, forCellReuseIdentifier: HomeViewThirdTableViewCell.reuseIdentifier)
//        view.register(HomeViewFourthTableViewCell.self, forCellReuseIdentifier: HomeViewFourthTableViewCell.reuseIdentifier)
//        view.register(ReusableHeaderView.self, forHeaderFooterViewReuseIdentifier: ReusableHeaderView.identifier)
//        view.backgroundColor = Color.backGroundColor
//        view.separatorStyle = .none
//        view.rowHeight = UITableView.automaticDimension
//        return view
//    }()
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
        $0.register(ItemRecommendCollectionViewCell.self, forCellWithReuseIdentifier: ItemRecommendCollectionViewCell.reuseIdentifier)
        $0.register(MonthOfWeekCollectionViewCell.self, forCellWithReuseIdentifier: MonthOfWeekCollectionViewCell.reuseIdentifier)
        $0.register(CategoryPercentCollectionViewCell.self, forCellWithReuseIdentifier: CategoryPercentCollectionViewCell.reuseIdentifier)
        $0.register(ReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReusableHeaderView.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
//        self.addSubview(tableView)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(self.safeAreaLayoutGuide)
//        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

extension HomeView {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                group.contentInsets = NSDirectionalEdgeInsets(
//                    top: 8,
//                    leading: 8,
//                    bottom: 8,
//                    trailing: 8)
//                group.interItemSpacing = .fixed(8)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(44)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)]
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 8,
                    trailing: 0)
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((self.frame.width - 24) / 2), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(
//                    top: 0,
//                    leading: 0,
//                    bottom: 0,
//                    trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
                group.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 8,
                    bottom: 8,
                    trailing: 8)
                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 20
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(44)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)]
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: 8,
//                    leading: 8,
//                    bottom: 8,
//                    trailing: 8)
                return section
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
//                group.contentInsets = NSDirectionalEdgeInsets(
//                    top: 8,
//                    leading: 8,
//                    bottom: 8,
//                    trailing: 8)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(44)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)]
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 8,
                    bottom: 8,
                    trailing: 8)
                return section
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                group.contentInsets = NSDirectionalEdgeInsets(
//                    top: 8,
//                    leading: 8,
//                    bottom: 8,
//                    trailing: 8)
//                group.interItemSpacing = .fixed(8)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(44)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)]
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: 8,
//                    leading: 8,
//                    bottom: 8,
//                    trailing: 8)
                return section
//                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((self.frame.width - 32) / 3), heightDimension: .fractionalHeight(1.0))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute((self.frame.width - 32) / 3))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                group.interItemSpacing = .fixed(8)
////                group.contentInsets = NSDirectionalEdgeInsets(
////                    top: 8,
////                    leading: 8,
////                    bottom: 8,
////                    trailing: 8)
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .absolute(44)),
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top)]
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: 8,
//                    leading: 8,
//                    bottom: 8,
//                    trailing: 8)
//                return section
            default:
                return nil
            }
        }
        return layout
    }

    
}



