//
//  PokeCell.swift
//  PokeDex
//
//  Created by Drix on 10/7/16.
//  Copyright © 2016 Drix. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 8.0
    }
    
    func updateCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        pokeImage.image = UIImage(named: "\(pokemon.pokeDexId)")
        pokeName.text = pokemon.name.capitalized
    }
}
