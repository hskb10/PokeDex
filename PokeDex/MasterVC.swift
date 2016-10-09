//
//  MasterVC.swift
//  PokeDex
//
//  Created by Drix on 10/7/16.
//  Copyright © 2016 Drix. All rights reserved.
//

import UIKit
import AVFoundation

class MasterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var player = AVAudioPlayer()
    var audioOff = false
    
    @IBAction func playMusic(_ sender: AnyObject) {
        if audioOff {
            player.play()
            audioOff = false
        } else {
            player.stop()
            audioOff = true
        }
        
    }
    
    @IBOutlet weak var pokeSearch: UISearchBar!
    @IBOutlet weak var pokeCollection: UICollectionView!
    var pokeFilter = [Pokemon]()
    var pokemons = [Pokemon]()
    var insearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeCollection.delegate = self
        pokeCollection.dataSource = self
        pokeSearch.delegate = self
        pokeSearch.returnKeyType = UIReturnKeyType.done
        
        parsePokemon()
        playOpeningTheme()
    }
    
    //MARK: Search delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            insearchMode = false
            pokeCollection.reloadData()
            view.endEditing(true)
        } else {
            insearchMode = true
            let lower = searchBar.text!.lowercased()
            pokeFilter = pokemons.filter({$0.name.range(of: lower) != nil })
            pokeCollection.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // MARK: Play Pokemon theme music
    func playOpeningTheme() {
        let audioPath = Bundle.main.path(forResource: "pokeaudio", ofType: "mp3")
        
        do {
            try player = AVAudioPlayer (contentsOf: URL(fileURLWithPath: audioPath!))
            player.play()
        }catch let error as NSError {
            print ("\(error.localizedDescription)")
        }
    }
    
    // MARK: Parse pokemon names from pokemon.csv
    func parsePokemon() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let pokeName = row["identifier"]
                
                let pokemon = Pokemon(name: pokeName!, pokeDexId: pokeId!)
                pokemons.append(pokemon)
                
                
            }
        } catch let error as NSError {
            print ("\(error.localizedDescription)")
        }
    }
    
    // MARK: Collection View Data Source
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if insearchMode {
            return pokeFilter.count
        } else {
           return pokemons.count 
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            if insearchMode {
                pokemon = pokeFilter[indexPath.row]
                cell.updateCell(pokemon: pokemon)
            } else {
                pokemon = pokemons[indexPath.row]
                cell.updateCell(pokemon: pokemon)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pokemon: Pokemon!
        if insearchMode {
            pokemon = pokeFilter[indexPath.row]
            performSegue(withIdentifier: "ShowPokeDetailsVC", sender: pokemon)
        } else {
            pokemon = pokemons[indexPath.row]
            performSegue(withIdentifier: "ShowPokeDetailsVC", sender: pokemon)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    // MARK: Hide keyboard 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PokeDetailsVC {
            player.stop()
            
            if let pokemon = sender as? Pokemon {
                destinationVC.pokemon = pokemon
            }
        }
    }

}
