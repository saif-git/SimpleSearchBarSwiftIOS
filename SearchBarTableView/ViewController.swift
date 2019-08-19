//
//  ViewController.swift
//  SearchBarTableView
//
//  Created by user on 18/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate{

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var animalArray = [Animal]()
    var currentAnimal = [Animal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpAnimal()
        setUpSearch()
        alterLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func setUpSearch(){
        searchBar.delegate = self
    }
    private func SetUpAnimal() {
        animalArray.append(Animal(name: "catzen", category: .cat))
        
        animalArray.append(Animal(name: "chien", category: .dog))
        
         animalArray.append(Animal(name: "loup", category: .dog))
         animalArray.append(Animal(name: "lion", category: .cat))
         animalArray.append(Animal(name: "tiger", category: .cat))
         animalArray.append(Animal(name: "renard", category: .dog))
        
        currentAnimal = animalArray
        table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else{
            return UITableViewCell()
        }
        cell.nameLa.text = currentAnimal[indexPath.row].name
        cell.categoryLa.text = currentAnimal[indexPath.row].category.rawValue
        //cell.sizeThatFits(CGSize(width: 200, height: 50))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {currentAnimal = animalArray;
            table.reloadData()
            return}
        
        currentAnimal = animalArray.filter({animal->Bool in
            

            switch searchBar.selectedScopeButtonIndex{
            case 0 :
                if searchText.isEmpty {return true}
                return                  animal.name.lowercased().contains(searchText.lowercased())
            case 1 :
                if searchText.isEmpty {return animal.category == .dog}
                return                  animal.name.lowercased().contains(searchText.lowercased()) && animal.category == .dog
            case 2 :
                if searchText.isEmpty {return animal.category == .cat}
                return                  animal.name.lowercased().contains(searchText.lowercased()) && animal.category == .cat
                
            default: return false

            }
        })
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            
            currentAnimal = animalArray
        case 1:
            currentAnimal = animalArray.filter({animal -> Bool in
                animal.category == AnimalType.cat
            })
        case 2:
            currentAnimal = animalArray.filter({animal -> Bool in
                animal.category == AnimalType.dog
            })
        default:
            print("show again")
            break
        }
        table.reloadData()
    }
    
    func alterLayout(){
        table.tableHeaderView = UIView()
        table.estimatedRowHeight = 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}

class Animal {
    let name : String!
    let category : AnimalType
    
    @IBOutlet weak var table: UITableView!
    init(name : String , category : AnimalType) {
        self.name = name
        self.category = category
    }
}

enum AnimalType : String {
    
    case cat = "Cat"
    case dog = "Dog"
}

