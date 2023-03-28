//
//  ViewController.swift
//  sesi3-peer
//
//  Created by Dony Prastiya on 14/03/23.
//

import UIKit
import Contentful
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    weak var animalcell : AnimalRightTableViewCell?
    
    var animals: [Animal] = []
    var animalsRight: [Animal] = []
    var animalsFeatured: [Animal] = []
    
    enum NewsSection{
        case featured
        case listRight
        case listDown
    }
    
    let newsSections : [NewsSection] = [.featured, .listRight, .listDown]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "AllAnimalTableViewCell", bundle: nil) , forCellReuseIdentifier: "ALL_ANIMAL")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Step 3: Authenticate
        getAnimal()
        getAnimal2()
        getAnimalFeatured()
    }
    
    func getAnimal() {
        HitAnimal.shared.getAnimals { [weak self] (result) in
            guard let `self` = self else { return }
//            self.refreshControl.endRefreshing()

            switch result {
            case .success(let animals):
                self.animals = animals
                if let index = self.newsSections.firstIndex(of: .listDown){
                    self.tableView.reloadSections(IndexSet([index]), with: .automatic)
                }
                print(self.animals)
            case .failure(let error):
                print("Oh no something went wrong: \(error)")
            }
        }
    }
    
    func getAnimal2() {
        HitAnimal.shared.getAnimals { [weak self] (result) in
            guard let `self` = self else { return }
//            self.refreshControl.endRefreshing()

            switch result {
            case .success(let animals):
                self.animalsRight = animals
                if let index = self.newsSections.firstIndex(of: .listRight){
                    self.tableView.reloadSections(IndexSet([index]), with: .automatic)
                }
                print(self.animalsRight)
            case .failure(let error):
                print("Oh no something went wrong: \(error)")
            }
        }
    }
    
    func getAnimalFeatured() {
        HitAnimalFeatured.shared.getAnimalFeatureds { [weak self] (result) in
            guard let `self` = self else { return }
//            self.refreshControl.endRefreshing()
            
            switch result {
            case .success(let animals):
                self.animalsFeatured = animals
                if let index = self.newsSections.firstIndex(of: .featured){
                    self.tableView.reloadSections(IndexSet([index]), with: .automatic)
                }
                print(self.animalsFeatured)
            case .failure(let error):
                print("Oh no something went wrong: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let newSection = self.newsSections[section]
        switch newSection{
        case .featured:
            return animalsFeatured.count
        case .listRight:
            return 1
        case .listDown:
            return animals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newSection = self.newsSections[indexPath.section]
        switch newSection{
        case .featured:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ALL_ANIMAL", for: indexPath) as! AllAnimalTableViewCell
            let all = animalsFeatured[indexPath.row]
            cell.title.text = all.title
            cell.desc.text = all.desc
            cell.img.kf.setImage(with: URL(string: all.imgUrl ?? ""))
            return cell
        case .listRight:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RIGHT", for: indexPath) as! AnimalRightTableViewCell
            cell.collection.dataSource = self
            cell.collection.delegate = self
            cell.collection.reloadData()
            
            self.animalcell = cell
            
            return cell
        case .listDown:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ALL_ANIMAL", for: indexPath) as! AllAnimalTableViewCell
            let all = animals[indexPath.row]
            cell.title.text = all.title
            cell.desc.text = all.desc
            cell.img.kf.setImage(with: URL(string: all.imgUrl ?? ""))
            return cell
        }
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let newSection = self.newsSections[section]
        switch newSection{
        case .featured:
            let view = UIView(frame: .zero)
            let label = UILabel(frame: .zero)
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.textColor = .black
            label.text = "ANIMAL FEATURED"
            return animalsFeatured.count > 0 ? view : nil
        case .listRight:
            let view = UIView(frame: .zero)
            let label = UILabel(frame: .zero)
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.textColor = .black
            label.text = "ANIMAL LIST"
            return animalsRight.count > 0 ? view : nil
        case .listDown:
            let view = UIView(frame: .zero)
            let label = UILabel(frame: .zero)
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.textColor = .black
            label.text = "ANIMAL LIST"
            return animals.count > 0 ? view : nil
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalsRight.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! AnimalCollectionViewCell
        let animal = animalsRight[indexPath.row]
        cell.titlecoll.text = animal.title
        cell.subtitlecoll.text = animal.subtitle
        cell.imgcoll.kf.setImage(with: URL(string: animal.imgUrl ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 300)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = UIScreen.main.bounds.width
//        return CGSize(width: width, height: 300)
//    }
}


extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let newSection = self.newsSections[section]
        switch newSection{
        case .featured:
            return 40
        case .listRight:
            return 40
        case .listDown:
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}






