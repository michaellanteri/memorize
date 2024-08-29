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




//Layout
//How is space on-screen apportioned to Views?
//1. Container View "offers" some or all of space to Views inside them
//2. Views choose what size they want to be
//3. Container Views position the Views inside them
//ex. VStack -- divide up space offered to them and then offer it to the Views inside it

//Offers space to "least flexible" subviews first
//ex. images are very inflexible, text are slightly flexible, shapes are very flexible
//If any of the Views in the stack are very flexible, then its stack will be very flexible

//From least to most flexible -
//Offered View takes what it wants, then its size is removed from the space available
//After Views inside the stack choose their sizes, the stack sizes itself to fit them

//Spacer -- uses all spaces avaiable in both directions (most flexible)
//Divider -- uses all space in horizontal direction and minimum in vertical

//Stack's choice of what to offer space to next can be overrided with .layoutPriority(Double)
//Can be any floating point, as default is 0

//Alignment -- .leading for left, .trailing for right

//LazyHStack and LazyVStack -- don't build any views that are not visible
    //Don't take up all space offered if they have flexible views inside
    //Use when a stack is in a ScrollView
//LazyHGrid and LazyVGrid -- similar, but give a columns or rows argument, other direction can grow as more Views are added
//Grid -- allocates space to Views in both directions, often used for "tables" or "spreadsheets"

//ScrollView -- uses all space offered
//ViewThatFits -- Takes list of container views (HStack, VStack) and choose the one that fits the best
    //Use when laying out portrait vs. landscape

//Can make custom implementations with Layout protocol

//ZStack -- sizes itself to fit children, so size is largest thing that needs to fit
    //If even one is very flexible, the whole thing is
//.background modifier -- ex. "Text("Hello").background(Rectangle().foregroundColor(.red))
    //mini-ZStack of two things, where Text determines its size, not rectangle (even though it might be larger)
//.overlay modifier -- the opposite of .background

//Modifiers -- modifiers themselves return a View
    //Some may modify the layout process itself (ex. .padding takes up space, .aspectRatio)

//Views that take up all space available:
    //Most Views
    //Custom Views do this (but should really adapt themselves)
        //ex. CardView needed to scale its font size for the emojis to look good

//GeometryReader { geometry in ...
    //geometry is a GeometryProxy
    //GeometryProxy has a var size that is the amount "offered" by the container
    //Accepts all space offered to it

//Safe areas -- things like the notch
//.edgesIgnoringSafeArea([.top]) draws in "safe area" on top edge

//Debugging tip -
//Can use .background(Color) at the end of a View to see what size its taking up

//@ViewBuilder
//Supports more convinient synxta for lists of Views
//If applied, returns something that conforms to a View
//Interprets contents as a list of Views and combines them into one
//Any func or read-only computed var can use this
//Can also be used when we have a parameter that's "a function/var that returns a View"

//Put . before things because they're enums, like .black, .fit, etc.
