//
//  ViewController.swift
//  SampleAPICall
//
//  Created by Caroline Cruz on 4/16/19.
//  Copyright © 2019 Caroline Cruz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
//    var pokemonArray = [Pokemons]()
    let apiClient = APIClient()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
        loadPokemons()

    }
    
    
    
    func loadPokemons() {
        searchBar.rx.text.asObservable()
            .map { ($0)?.lowercased() ?? "" }
            .map { PokemonRequest(name: $0)}
            .flatMap { request -> Observable<[PokemonModel]> in
                return self.apiClient.send(apiRequest: request)
            }
            .bind(to: tableView.rx.items(cellIdentifier: "tvCell")) {
                index,pokemon,cell in
                cell.textLabel?.text = pokemon.results
            }.disposed(by: disposeBag)
    }
/*    func loadPokemons() {
       //implementing URLSession(NetworkCall)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {return}
         URLSession(configuration:URLSessionConfiguration.default).dataTask(with: url) { (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {return}
            //implement json decoding and parsing
            do{
                //decode retrived data with JSONDecoder and assign type of PokemonModel object
                let pokemons = try JSONDecoder().decode(PokemonModel.self, from: data)
                //Get back to the main queue
                DispatchQueue.main.async {
                    print(pokemons)
                    self.pokemonArray = pokemons.results
                    self.tableView.reloadData()
                }
            } catch let jsonError{
                print(jsonError)
            }
            //End implementing URLSession
        }.resume()

    }



}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(pokemonArray.count)
        return pokemonArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poke = pokemonArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath)
        cell.textLabel?.text = poke.name!
        cell.detailTextLabel?.text = String(describing:poke.url!)
        return cell
    }

*/
    
}

