//
//  PokeDetailsVC.swift
//  PokeDex
//
//  Created by Drix on 10/7/16.
//  Copyright © 2016 Drix. All rights reserved.
//

import UIKit
import AVFoundation

class PokeDetailsVC: UIViewController {
    
    var player = AVAudioPlayer()
    var audioOff = false
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var pokeDetail: UILabel!
    @IBOutlet weak var pokeHeight: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    @IBOutlet weak var pokeDefense: UILabel!
    @IBOutlet weak var pokeAttack: UILabel!
    @IBOutlet weak var evoBasicImage: UIImageView!
    @IBOutlet weak var evoAdvanceImage: UIImageView!
    @IBOutlet weak var pokeEvoLabel: UILabel!
    
    // MARK: Play Prof. Oak track
    func playProfOakTheme() {
        let audioPath = Bundle.main.path(forResource: "details", ofType: "mp3")
        
        do {
            try player = AVAudioPlayer (contentsOf: URL(fileURLWithPath: audioPath!))
            player.play()
        }catch let error as NSError {
            print ("\(error.localizedDescription)")
        }
    }

    
    @IBAction func musicButton(_ sender: AnyObject) {
        if audioOff {
            audioOff = false
            player.play()
        } else {
            audioOff = true
            player.stop()
        }
    }
    
    // MARK: Navigation
    @IBAction func back(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        player.stop()
        performSegue(withIdentifier: "ShowMasterVC", sender: self)
    }
    
    // Mark: models
    private weak var _pokemon: Pokemon!
    
    var pokemon: Pokemon {
        get {
            return _pokemon
        } set {
            _pokemon = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage(named: "\(pokemon.pokeDexId)")
        nameLabel.text = pokemon.name.capitalized
        playProfOakTheme()
    }
}
