//
//  Notes.swift
//  Memorize
//
//  Created by Michael Lanteri on 8/7/24.
//

//Separating model and UI --
//Model - logic and data
//UI - visualization of the model
//SwiftUI takes care of UI is rebuilt when a model change affects the UI

//Connecting model to UI --
//Rarely, entire model is @State (minimal separation)
//(Main way) Model accessible to UI via a gatekeeper "View Model" class (full separation)
//View Model class, but still directly accessible (partial separation)

//Intent - choose card vs.
//Action - tap

//structs --
//Value type
//Variables copied when passed or assigned
//Copy on write -- values are only copied when written on, so not inefficient (ex. copying a million item array)
//Functional programming -- don't want to encapsulate data (like a class), encapsulate functionality
//No inheritence
//"Free" init initializes ALL vars - so often don't need one
//Mutability is explicit (let vs. var)

//protocols --
//Similar to struct or class but w/o implementation or storage
//To claim to conform to ("behave like a...") protocol, need to implement all the things in that protocol

//protocol uses --
//Protocols are types
//Specifies the behavior of a struct, class, or enum
//Turns "don't cares" into "somewhat cares" (where Element: Equatable)
//"Constains and gains" - makes you implement things, but then get a lot of tools

//Functions are types --
//ex. func doSomething(what: (Int, Int) -> Bool)
//Closures are in-line functions (ex. @ViewBuilders)

//Protocols--
//Doesn't care how you implement the requirements, just need them
//If you have them, it gives you access to a lot
//Ex. if requirement is a function random() -> Double, doesn't matter how you implement random, just need to have it

//enum
//For methods, do switch on "self" to test what it is
//To iterate through all cases of an enum, if it conforms to CaseIterable, call "for _ in Type.allCases"

//optionals
//Use "if let" to check if not nil
//Optional defaulting: use ?? like in "let y = x ?? "foo""
