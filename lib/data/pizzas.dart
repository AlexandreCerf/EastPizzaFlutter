import 'package:easypizza/models/pizza.dart';

final List<Pizza> pizzas = [
    Pizza(name:"Margherita",price: 8.50,ingredients: ["Sauce tomate", "Mozzarella", "Basilic frais", "Huile d'olive", "Sel"], category: Category.rossa ),
    Pizza(name:"Quattro Stagioni",price: 9.00,ingredients: ["Sauce tomate", "Mozzarella", "Champignons", "Artichauts", "Jambon cuit", "Olives noires"],category: Category.rossa),
    Pizza(name:"Quattro Formaggi",price: 10.00,ingredients: ["Mozzarella", "Gorgonzola", "Parmigiano Reggiano", "Ricotta (ou Provolone)", "Sauce tomate (parfois)"],category: Category.rossa),
    Pizza(name:"Regina",price: 11.00,ingredients: ["Sauce tomate", "Mozzarella", "Jambon cuit", "Champignons", "Origan", "Huile d'olive"],category: Category.rossa),
    Pizza(name:"Diavola",price: 9.50,ingredients: ["Sauce tomate", "Mozzarella", "Salami piquant (ou chorizo)", "Piments (optionnel)", "Huile pimentée"],category: Category.rossa),
    Pizza(name:"Capricciosa",price: 12.00,ingredients: ["Sauce tomate", "Mozzarella", "Jambon cuit", "Champignons", "Artichauts", "Olives noires", "Œuf (optionnel)"],category: Category.rossa),
    Pizza(name:"Marinara",price: 11.50,ingredients: ["Sauce tomate", "Ail", "Origan", "Huile d'olive", "Basilic (optionnel)"],category: Category.veggie),
    Pizza(name:"Ortolana",price: 10.50,ingredients: ["Sauce tomate", "Mozzarella", "Aubergines", "Courgettes", "Poivrons", "Oignons"],category: Category.veggie),
    Pizza(name:"Bianca",price: 13.00,ingredients: ["Mozzarella", "Ricotta", "Parmigiano Reggiano", "Huile d'olive", "Romarin (ou autres herbes selon les variations)"],category: Category.bianca),
    Pizza(name: "Parma",price:  9.75,ingredients: ["Sauce tomate (parfois)", "Mozzarella", "Jambon de Parme", "Roquette", "Copeaux de Parmigiano Reggiano", "Huile d'olive"],category: Category.rossa)
];
