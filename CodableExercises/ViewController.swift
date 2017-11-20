//
//  ViewController.swift
//  CodableExercises
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let jsonFiles = ["songs", "cities", "scheme", "news", "pokemoncards", "girlshows"]
    var cellInfoArr = [SubCellInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("here")
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
        self.tabBarController?.title = jsonFiles[(self.tabBarController?.selectedIndex)!].capitalized
    }
    
    func loadData() {
        //print(Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil))
        
        
        guard let jsonFileIndex = self.tabBarController?.selectedIndex else { return }
        guard jsonFileIndex < jsonFiles.count else { return }
        //Create a String path that is the filepath to the saved .json file
        if let path = Bundle.main.path(forResource: jsonFiles[jsonFileIndex], ofType: "json") {
            //Convert the String into a URL
            let myURL = URL(fileURLWithPath: path)
            //Get the Data at the URL
            //Getting the data could fail, so we must mark it with try.
            //try? means that if getting theData fails, we should return nil.
            if let data = try? Data(contentsOf: myURL) {
                //parse the data here
                switch jsonFiles[jsonFileIndex] {
                case "songs": self.cellInfoArr = Song.getSongs(from: data)
                case "cities": self.cellInfoArr = City.getCities(from: data)
                case "scheme": self.cellInfoArr = Color.getColors(from: data)
                case "news": self.cellInfoArr = Article.getArticles(from: data)
                case "pokemoncards": self.cellInfoArr = PokemonCard.getPokemonCards(from: data)
                case "girlshows": self.cellInfoArr = GirlShow.getGirlShows(from: data)
                default: print("no switch case")
                }
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//Table View
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(cellInfoArr.count)
        return cellInfoArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellInfoToUse = cellInfoArr[indexPath.row]
        
        cell.textLabel?.text = cellInfoToUse.textLabelText
        cell.detailTextLabel?.text = cellInfoToUse.detailTextLabelText
//        print(cell.imageView?.isHidden)
//        print(cellInfoToUse.imagePath)
        if let imagePath = cellInfoToUse.imagePath {
            //print(imagePath)
            if let imageURL = URL(string: imagePath) {
                //print(imageURL)
                DispatchQueue.global().sync {
                    //print("ok")
                    if let imageData = try? Data.init(contentsOf: imageURL) {
                        //print(imageData)
                        DispatchQueue.main.async {
                            if let ip = tableView.indexPath(for: cell) {
                                if indexPath == ip {
                                    cell.imageView?.image = UIImage(data: imageData)
                                }
                            }
                        }
                    } else {
                        print("couldnt get the shits")
                    }
                }
            }
        }
//        cell.imageView?.image = UIImage(contentsOfFile: cellInfoToUse.imagePath ?? "")
//        print(cell.imageView)
        return cell
    }
}




