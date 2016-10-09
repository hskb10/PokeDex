//
//  Pokemon.swift
//  PokeDex
//
//  Created by Drix on 10/7/16.
//  Copyright © 2016 Drix. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokeDexId: Int!
    private var _pokeType: String!
    private var _pokeDetail: String!
    private var _pokeHeight: String!
    private var _pokeWeight: String!
    private var _pokeDefense: String!
    private var _pokeAttack: String!
    private var _pokeEvoLabel: String!
    
    
    var name: String {
        if _name == nil {
            _name = "unkown"
        }
        return _name
    }
    
    var pokeDexId: Int {
        if _pokeDexId == nil {
            _pokeDexId = 0
        }
        return _pokeDexId
    }
    
    var pokeType: String {
        if _pokeType == nil {
            _pokeType = "unclassified"
        }
        return _pokeType
    }
    
    var pokeDetail: String! {
        if _pokeDetail == nil {
            _pokeDetail = "unknown"
        }
        return _pokeDetail
    }
    
    var pokeHeight: String {
        if _pokeHeight == nil {
            _pokeHeight = "unknown"
        }
        return _pokeHeight
    }
    
    var pokeWeight: String {
        if _pokeWeight == nil {
            _pokeWeight = "unknown"
        }
        return _pokeWeight
    }
    
    var pokeDefense: String {
        if _pokeDefense == nil {
            _pokeDefense = "unkown"
        }
        return _pokeDefense
    }
    
    var pokeAttack: String {
        if _pokeAttack == nil {
            _pokeAttack = "unknown"
        }
        return _pokeAttack
    }
    
    var pokeEvoLabel: String {
        if _pokeEvoLabel == nil {
            _pokeEvoLabel = "unkown"
        }
        return _pokeEvoLabel
    }
    
    init(name: String, pokeDexId: Int) {
        self._name = name
        self._pokeDexId = pokeDexId
    }
}
