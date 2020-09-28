//
//  Allergen.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import SwiftUI
import Foundation

struct Allergen: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var type: AllergenTypes
    var isSelected: Bool
}

enum AllergenTypes: CaseIterable {
    case dairy, eggs, fish, treenuts, peanuts, wheat, soy, shellfish
    
    var description: String {
        switch self {
        case .dairy:
            return NSLocalizedString("Dairy", comment: "food allergen")
        case .eggs:
            return NSLocalizedString("Eggs", comment: "food allergen")
        case .fish:
            return NSLocalizedString("Fish", comment: "food allergen")
        case .treenuts:
            return NSLocalizedString("Treenuts", comment: "food allergen")
        case .peanuts:
            return NSLocalizedString("Peanuts", comment: "food allergen")
        case .wheat:
            return NSLocalizedString("Wheat", comment: "food allergen")
        case .soy:
            return NSLocalizedString("Soy", comment: "food allergen")
        case .shellfish:
            return NSLocalizedString("Shellfish", comment: "food allergen")
        }
    }
    
    var symbol: String {
        switch self {
        case .dairy:
            return "D"
        case .eggs:
            return "E"
        case .fish:
            return "F"
        case .treenuts:
            return "T"
        case .peanuts:
            return "P"
        case .wheat:
            return "W"
        case .soy:
            return "So"
        case .shellfish:
            return "Sh"
        }
    }
    
    var color: Color {
        switch self {
        case .dairy:
            return Color.blue
        case .eggs:
            return Color.yellow
        case .fish:
            return Color.green
        case .treenuts:
            return Color.init(red: 186/255, green: 126/255, blue: 61/255, opacity: 1.0) // Brown
        case .peanuts:
            return Color.red
        case .wheat:
            return Color.init(red: 178/255, green: 113/255, blue: 199/255, opacity: 1.0) // Purple
        case .soy:
            return Color.pink
        case .shellfish:
            return Color.orange
        }
    }
    
    var items: [String] {
        switch self {
        case .dairy:
            return [NSLocalizedString("Milk", comment: "dairy allergen"),
                    NSLocalizedString("Dairy", comment: "dairy allergen"),
                    NSLocalizedString("Butter", comment: "dairy allergen"),
                    NSLocalizedString("Casein", comment: "dairy allergen"),
                    NSLocalizedString("Caseinates", comment: "dairy allergen"),
                    NSLocalizedString("Cheese", comment: "dairy allergen"),
                    NSLocalizedString("Cream", comment: "dairy allergen"),
                    NSLocalizedString("Curds", comment: "dairy allergen"),
                    NSLocalizedString("Custard", comment: "dairy allergen"),
                    NSLocalizedString("Galactose", comment: "dairy allergen"),
                    NSLocalizedString("Ghee", comment: "dairy allergen"),
                    NSLocalizedString("Hydrolysate", comment: "dairy allergen"),
                    /* casein hydrolysate, milk protein hydrolysate, protein hydrolysate, whey hydrolysate, whey protein hydrolysate Ice cream, ice milk, sherbet */
                    NSLocalizedString("Lactalbumin", comment: "dairy allergen"),
                    NSLocalizedString("Lactalbumin phosphate", comment: "dairy allergen"),
                    NSLocalizedString("Lactate solids", comment: "dairy allergen"),
                    NSLocalizedString("Lactyc yeast", comment: "dairy allergen"),
                    NSLocalizedString("Lactitol monohydrate", comment: "dairy allergen"),
                    NSLocalizedString("Lactoglobulin", comment: "dairy allergen"),
                    NSLocalizedString("Lactose", comment: "dairy allergen"),
                    NSLocalizedString("Lactulose", comment: "dairy allergen"),
                    NSLocalizedString("Nisin preparation", comment: "dairy allergen"),
                    NSLocalizedString("Nougat", comment: "dairy allergen"),
                    NSLocalizedString("Rennet casein", comment: "dairy allergen"),
                    NSLocalizedString("Quark", comment: "dairy allergen"),
                    NSLocalizedString("Recaldent", comment: "dairy allergen"),
                    NSLocalizedString("Rennet", comment: "dairy allergen"),
                    NSLocalizedString("Sour cream", comment: "dairy allergen"),
                    NSLocalizedString("Whey", comment: "dairy allergen")
            ]
        case .eggs:
            return [NSLocalizedString("Albumin", comment: "egg allergen"),
                    NSLocalizedString("Egg", comment: "egg allergen"),
                    NSLocalizedString("Apovitellin", comment: "egg allergen"),
                    NSLocalizedString("Eggnog", comment: "egg allergen"),
                    NSLocalizedString("Globulin", comment: "egg allergen"),
                    NSLocalizedString("Livetin", comment: "egg allergen"),
                    NSLocalizedString("Lysozyme", comment: "egg allergen"),
                    NSLocalizedString("Mayonnaise", comment: "egg allergen"),
                    NSLocalizedString("Meringue", comment: "egg allergen"),
                    NSLocalizedString("Ovalbumin", comment: "egg allergen"),
                    NSLocalizedString("Ovoglobulin", comment: "egg allergen"),
                    NSLocalizedString("Ovomucin", comment: "egg allergen"),
                    NSLocalizedString("Ovomucoid", comment: "egg allergen"),
                    NSLocalizedString("Ovotransferrin", comment: "egg allergen"),
                    NSLocalizedString("Ovovitelia", comment: "egg allergen"),
                    NSLocalizedString("Ovovitellin", comment: "egg allergen"),
                    NSLocalizedString("Silici albuminate", comment: "egg allergen"),
                    NSLocalizedString("Simplesse", comment: "egg allergen"),
                    NSLocalizedString("Surimi", comment: "egg allergen"),
                    NSLocalizedString("Trailblazer", comment: "egg allergen"),
                    NSLocalizedString("Vitellin", comment: "egg allergen"),
            ]
        case .fish:
            return [NSLocalizedString("Anchovies", comment: "fish allergen"),
                    NSLocalizedString("Bass", comment: "fish allergen"),
                    NSLocalizedString("Catfish", comment: "fish allergen"),
                    NSLocalizedString("Cod", comment: "fish allergen"),
                    NSLocalizedString("Flounder", comment: "fish allergen"),
                    NSLocalizedString("Grouper", comment: "fish allergen"),
                    NSLocalizedString("Haddock", comment: "fish allergen"),
                    NSLocalizedString("Hake", comment: "fish allergen"),
                    NSLocalizedString("Halibut", comment: "fish allergen"),
                    NSLocalizedString("Herring", comment: "fish allergen"),
                    NSLocalizedString("Mahi mahi", comment: "fish allergen"),
                    NSLocalizedString("Perch", comment: "fish allergen"),
                    NSLocalizedString("Pike", comment: "fish allergen"),
                    NSLocalizedString("Pollock", comment: "fish allergen"),
                    NSLocalizedString("Salmon", comment: "fish allergen"),
                    NSLocalizedString("Scrod", comment: "fish allergen"),
                    NSLocalizedString("Sole", comment: "fish allergen"),
                    NSLocalizedString("Snapper", comment: "fish allergen"),
                    NSLocalizedString("Swordfish", comment: "fish allergen"),
                    NSLocalizedString("Tilapia", comment: "fish allergen"),
                    NSLocalizedString("Trout", comment: "fish allergen"),
                    NSLocalizedString("Tuna", comment: "fish allergen")
            ]
        case .treenuts:
            return [NSLocalizedString("Almond", comment: "tree nut allergen"),
                    NSLocalizedString("Beechnut", comment: "tree nut allergen"),
                    NSLocalizedString("Brazil nut", comment: "tree nut allergen"),
                    NSLocalizedString("Butternut", comment: "tree nut allergen"),
                    NSLocalizedString("Cashew", comment: "tree nut allergen"),
                    NSLocalizedString("Chestnut", comment: "tree nut allergen"),
                    NSLocalizedString("Chinquapin", comment: "tree nut allergen"),
                    NSLocalizedString("Coconut", comment: "tree nut allergen"),
                    NSLocalizedString("Filbert", comment: "tree nut allergen"),
                    NSLocalizedString("Gingko nut", comment: "tree nut allergen"),
                    NSLocalizedString("Hazelnut", comment: "tree nut allergen"),
                    NSLocalizedString("Hickory nut", comment: "tree nut allergen"),
                    NSLocalizedString("Lichee nut", comment: "tree nut allergen"),
                    NSLocalizedString("Macadamia nut", comment: "tree nut allergen"),
                    NSLocalizedString("Bush nut", comment: "tree nut allergen"),
                    NSLocalizedString("Nangai nut", comment: "tree nut allergen"),
                    NSLocalizedString("Pecan", comment: "tree nut allergen"),
                    NSLocalizedString("Pine nut", comment: "tree nut allergen"),
                    NSLocalizedString("Pinon nut", comment: "tree nut allergen"),
                    NSLocalizedString("Pistachio", comment: "tree nut allergen"),
                    NSLocalizedString("Pili nut", comment: "tree nut allergen"),
                    NSLocalizedString("Sheanut", comment: "tree nut allergen"),
                    NSLocalizedString("Walnut", comment: "tree nut allergen")
            ]
        case .peanuts:
            return [NSLocalizedString("Arachic oil", comment: "peanut allergen"),
                    NSLocalizedString("Penaut", comment: "peanut allergen"),
                    NSLocalizedString("Peanuts", comment: "peanut allergen"),
                    NSLocalizedString("Arachis", comment: "peanut allergen"),
                    NSLocalizedString("Arachis hypogae", comment: "peanut allergen"),
                    NSLocalizedString("Artificial nuts", comment: "peanut allergen"),
                    NSLocalizedString("Beer nuts", comment: "peanut allergen"),
                    NSLocalizedString("Boiled peanut", comment: "peanut allergen"),
                    NSLocalizedString("Penaut oil", comment: "peanut allergen"), //sometimes people can still have ths, so need more research
                    NSLocalizedString("Earth nuts", comment: "peanut allergen"),
                    NSLocalizedString("Goober peas", comment: "peanut allergen"),
                    NSLocalizedString("Goobers", comment: "peanut allergen"),
                    NSLocalizedString("Ground nuts", comment: "peanut allergen"),
                    NSLocalizedString("Hydrolyzed peanut protein", comment: "peanut allergen"),
                    NSLocalizedString("Hypogaeic acid", comment: "peanut allergen"),
                    NSLocalizedString("Mandelonas", comment: "peanut allergen"),
                    NSLocalizedString("Mixed nuts", comment: "peanut allergen"),
                    NSLocalizedString("Monkey nuts", comment: "peanut allergen"),
                    NSLocalizedString("Nu nuts", comment: "peanut allergen"),
                    NSLocalizedString("Nutmeat", comment: "peanut allergen"),
            ]
        case .wheat:
            return [NSLocalizedString("All purpose flour", comment: "wheat allergen"),
                    NSLocalizedString("Wheat", comment: "wheat allergen"),
                    NSLocalizedString("Bread", comment: "wheat allergen"),
                    NSLocalizedString("Bulgur", comment: "wheat allergen"),
                    NSLocalizedString("Cereal extract", comment: "wheat allergen"),
                    NSLocalizedString("Cracker meal", comment: "wheat allergen"),
                    NSLocalizedString("Einkorn", comment: "wheat allergen"),
                    NSLocalizedString("Emmer", comment: "wheat allergen"),
                    NSLocalizedString("Farina", comment: "wheat allergen"),
                    NSLocalizedString("Flour", comment: "wheat allergen"),
                    /* atta, club, common, durum,
                    einkorn, emmer, farina, graham, kamut,
                    maida, semolina, spelt, triticale, triticum, all purpose, bread, bromated,
                    cake, enriched, high gluten, high
                    protein, instant pastry, phosphated,
                    plain, soft wheat, steel ground, stone
                    ground, self-rising, unbleached, white,
                    whole wheat*/
                    NSLocalizedString("Fu", comment: "wheat allergen"),
                    NSLocalizedString("Gluten", comment: "wheat allergen"),
                    NSLocalizedString("Kamut", comment: "wheat allergen"), //khorasan wheat
                    NSLocalizedString("Malt", comment: "wheat allergen"),
                    NSLocalizedString("Malt extract", comment: "wheat allergen"),
                    NSLocalizedString("Matzo", comment: "wheat allergen"), //matzoh, matzah, or matza
                    NSLocalizedString("Seitan", comment: "wheat allergen"),
                    NSLocalizedString("Semolina", comment: "wheat allergen"),
                    NSLocalizedString("Spelt", comment: "wheat allergen"),
                    NSLocalizedString("Tabbouleh", comment: "wheat allergen"),
                    NSLocalizedString("Triticale", comment: "wheat allergen"),
                    NSLocalizedString("Triticum", comment: "wheat allergen"),
                    NSLocalizedString("Whole wheat", comment: "wheat allergen"),
                    NSLocalizedString("wheatgrass", comment: "wheat allergen"),
            ]
        case .soy:
            return [NSLocalizedString("Edamame", comment: "soybean allergen"),
                    NSLocalizedString("Soybeans", comment: "soybean allergen"),
                    NSLocalizedString("Soybean", comment: "soybean allergen"),
                    NSLocalizedString("Soy", comment: "soybean allergen"),
                    NSLocalizedString("Kinako Flour", comment: "soybean allergen"),
                    NSLocalizedString("Kyodofu", comment: "soybean allergen"),
                    NSLocalizedString("Lecithin", comment: "soybean allergen"),
                    NSLocalizedString("Miso", comment: "soybean allergen"),
                    NSLocalizedString("Monoglyceride", comment: "soybean allergen"),
                    NSLocalizedString("Diglyceride", comment: "soybean allergen"),
                    NSLocalizedString("Natto", comment: "soybean allergen"),
                    NSLocalizedString("Okara", comment: "soybean allergen"),
                    NSLocalizedString("Shoyu", comment: "soybean allergen"),
                    NSLocalizedString("Soya", comment: "soybean allergen"),
                    NSLocalizedString("Tamari", comment: "soybean allergen"),
                    NSLocalizedString("Tempeh", comment: "soybean allergen"),
                    NSLocalizedString("TSF", comment: "soybean allergen"), //textured soy flour
                    NSLocalizedString("TSP", comment: "soybean allergen"), //textured vegetable protein
                    NSLocalizedString("Tofu", comment: "soybean allergen"),
                    NSLocalizedString("Yakidofu", comment: "soybean allergen"),
                    NSLocalizedString("Yuba", comment: "soybean allergen")
            ]
        case .shellfish:
            return [NSLocalizedString("Shellfish", comment: "shellfish allergen"),
                    NSLocalizedString("Crab", comment: "shellfish allergen"),
                    NSLocalizedString("Shrimp", comment: "shellfish allergen"),
                    NSLocalizedString("Krill", comment: "shellfish allergen"),
                    NSLocalizedString("Lobster", comment: "shellfish allergen"),
            ]
        }
    }
}
