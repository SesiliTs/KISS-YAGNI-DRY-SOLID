//1. მოდით ჩვენს ხომალდს მივხედოთ SOLID Principle-ბის დაცვით.
//შევქმნათ Class-ი PirateShip⛴️🏴‍☠️, with properties: როგორციაა name, cannonsCount, crew👫 და cargo🍗🍖🥃🍺.
//Methods: firingCannons, adding/removing crew, adding/removing cargo.

protocol Cannons {
    
    func fireCannon(count: Int)
    
}


class PirateShip: Cannons {
    
    let name: String
    var cannonsCount: Int
    var cargoManager: CargoManaging
    var crewManager: CrewManaging
    
    func fireCannon(count: Int) {
        cannonsCount -= 1
        print("\(count) cannons were fired and they reached the destination, enemy is destroyed")
    }
    
    init(name: String, cannonsCount: Int, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.name = name
        self.cannonsCount = cannonsCount
        self.cargoManager = cargoManager
        self.crewManager = crewManager
    }
    
}

//დავიცვათ Single Responsibility ამისათვის - cargo management და adding/removing crew ფუნქციონალი უნდა განვაცალკევოთ.
//შესაბამისად მოდი შევქმნათ 2 Manager class-ი (CargoManager, CrewManager), სადაც გავიტანთ crew-ს და cargo-ს და შესაბამის methods გავიტანთ ამ კლასებში.

class CargoManager: CargoManaging {
    
    var cargo: [String]
    
    func addCargo(newCargo: String) {
        cargo.append(newCargo)
    }
    func removeCargo(cargoToRemove: String) {
        cargo = cargo.filter{ $0 != cargoToRemove }
    }
    func listCargo() {
        print(cargo)
    }
    
    init(cargo: [String]) {
        self.cargo = cargo
    }
}

class CrewManager: CrewManaging {
    
    var crew: [String]
    
    func addCrew(crewMember: String) {
        crew.append(crewMember)
    }
    func removeCrew(crewMember: String) {
        crew = crew.filter{ $0 != crewMember }
    }
    func listCrew() {
        print(crew)
    }
    
    init(crew: [String]) {
        self.crew = crew
    }
}

//ამის შემდეგ ჩვენს PirateShip-ში გვრჩება properties: name, cannonsCount და 2 მენეჯერი რომელიც ცალ-ცალკე გააკონტროლებს ჩვენი გემის ფუნქციონალს. Methods გვექნება addCargo, removeCargo, listCargo, addCrew, removeCrew, listCrew, cannonCount, fireCannon(count:) და ამ Method-ებში ჩვენი მენეჯერების შესაბამისი მეთოდები გამოვიყენოთ.
//დავიცვათ Open/Closed პრინციპი. ჩვენი მენეჯერები არ უნდა იყოს წვდომადი გარედან და მათი ფუნქციონალის გამოყენება მხოლოდ გემის წევრებს უნდა შეეძლოთ.

//დავიცვათ Liskov Substituion, შევქმნათ PirateShip-ის შვილობილი კლასები Frigate და Galleon. დაამატეთ ფუნქციონალი და ცვლადები თქვენი სურვილის მიხედვით, მაგრამ როცა PirateShip-ს Frigate-ით ან Galleon-ით ამოვცვლით ქცევა არ უნდა შეგვეცვალოს.
//

class Frigate: PirateShip {
    
    func shootCannon() {
        cannonsCount -= 1
    }
}

class Galleon: PirateShip {
    
    func loadCannonStock() {
        cannonsCount += 1
    }
}

//
//დავიცვათ Interface Segregation. ყველა გემს არ აქვს საშუალება რომ იქონიონ cannon-ები და აწარმოონ ბრძოლა. ამიტომ შევქმნათ protocol Cannons შესაბამისი მეთოდები და დავაიმპლემენტიროთ PirateShip-ში.



//დავიცვათ Dependency Inversion პრინციპი, ამიტომ ჩვენს manager კლასებს გავუკეთოთ პროტოკოლები CargoManaging და CrewManaging სადაც მეთოდებს ავღწერთ რომლებიც აქამდე კლასებში გვქონდა, ხოლო PirateShip-ში CargoManager-ს და CrewManager-ს ჩავანაცვლებთ ამ Protocol-ის ტიპის ცვლადებით, ამითი ჩვენს PirateShips აღარ ეცოდინება სპეციფიური დეტალები თუ როგორ ხდება cargo-ს და crew-ის მენეჯმენტი  მას მხოლოდ აბსტრაქტულად ეცოდინება ის რომ ეს შესაძლებელია. ასევე ამ პრინციპის დაცვით ჩვენ საშუალება გვექნება ნებისმიერ დროს შევცვალოთ Crew და Cargo Management-ის მართვის სისტემა, უბრალოდ ჩავაწვდით ახალ კლასს სხვა იმპლემენტაციით რომელიც ამ პროტოკოლს აიმპლემენტირებს, ამის საშვალებით ჩვენ ნებისმიერ დროს შეგვეძლება PirateShip-ში მარტივი ცვლილებების შეტანა, ისე რომ თვითონ კლასში ცვლილებების გაკეთება არ მოგვიწევს.

protocol CargoManaging {
    
    var cargo: [String] { get set }
    
    func addCargo(newCargo: String)
    func removeCargo(cargoToRemove: String)
    func listCargo()
    
}

protocol CrewManaging {
    
    var crew: [String] { get set }
    
    func addCrew(crewMember: String)
    func removeCrew(crewMember: String)
    func listCrew()
}

//2.TreasureMap KISS პრინციპის დაცვით.
//
//TreasureMap კლასი გვექნება ძალიან მარტივი ორი ფროფერთით: x და y ექნება. ერთი მეთოდი hintToTreasure, რომელიც მიიღებს x და y-ს და თუ ვიპოვეთ ჩვენი საგანძური დაგვიწერს ამას, თუ არასწორად მივუთითებთ კოორდინატებს მაშინ უნდა მოგვცეს hint-ი თუ საით უნდა წავიდეთ რომ მივაგნოთ საგანძურს.

class TreasureMap {
    
    var x: Double
    var y: Double
    
    func hintToTreasure(x: Double, y: Double) {
        
        if x > self.x {
            print("X coordinate should be lower")
        } else if x < self.x {
            print("X coordinate should be higher")
        }
        
        if y > self.y {
            print("Y coordinate should be lower")
        } else if y < self.y {
            print("Y coordinate should be higher")
        }
        
        if x == self.x && y == self.y {
            print("You found the treasure")
        }
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}


//3.SeaAdventure YAGNI პრინციპის დაცვით, პირატების მოგზაურობა თავგადასავლის გარეშე ვის გაუგია
//
//შევქმნათ მარტივი SeaAdventure class-ი, ერთი String adventureType ფროფერთით და ერთი მეთოდით encounter რომელიც დაგვიბეჭდავს თუ რა adventure-ს წააწყდა ჩვენი ხომალდი. დავიცვათ YAGNI და არ დავამატოთ გავრცობილი ფუნქციონალი რომელიც სხვადასხვა adventure-ს შეიძლება მოიცავდეს, რომელიც ჯერ ჯერობით არ გვჭირდება.

class SeaAdventure {
    
    var adventureType: String
    func encounter() {
        print(adventureType)
    }
    
    init(adventureType: String) {
        self.adventureType = adventureType
    }
    
}

//4. PirateCode DRY პრინციპის დაცვით.
//
//შევქმნათ მარტივი კლასი PirateCode, რომელსაც ექნება ორი მეთოდი parley და mutiny, ამ მეთოდებში უნდა დავიწყოთ განხილვა მოლაპარაკებებზე წავალთ თუ ვიბრძოლებთ ეს კოდი რომ ორივე მეთოდში არ გაგვიმეორდეს დავიცვათ DRY პრინციპი და შევქმნათ ერთი private ფუნქცია discussTerms(term: String), რომელიც შეგვატყობინებს იმას რომ მოლაპარაკებები დაწყებულია, ხოლო parley და mutiny მოლაპარაკების შედეგს დაგვიბეჭდავენ.

private func discussTerms(term: String) {
    print("discussion has started, opponent suggested following term: \(term)")
}

class PirateCode {
    
    func parley() {
        print("agreed to suggested terms")
    }
    func mutiny() {
        print("term was not acceptable, declaring war")
    }
    
}

//5. დროა საგანძურის საძებნელად გავეშვათ. (Treasure hunting😄💰)
//შევქმნათ ჩვენი ხომალდი დავარქვათ სახელი, ეკიპაჟი დავამატოთ, საომრად გავამზადოთ, ავტვირთოთ cargo.

var cargoManager = CargoManager(cargo: [])
var crewManager = CrewManager(crew: [])

var artemis = PirateShip(name: "Artemis", cannonsCount: 75, cargoManager: cargoManager, crewManager: crewManager)
artemis.crewManager.addCrew(crewMember: "Jamie Fraiser")
artemis.crewManager.addCrew(crewMember: "Claire Fraiser")

artemis.cargoManager.addCargo(newCargo: "Golden skeleton")


//შევქმნათ ჩვენი საგანძულის კარტა და გადავაწდოთ კოორდინატები.

var treasureMap = TreasureMap(x: 46.007, y: 49.005)

//შევქმნათ პირატის კოდექსი რომელიც მოგზაურობისას დაგვეხმარება.

discussTerms(term: "Ahoy, you're on our territories, you must leave immediately")

//შევქმნათ SeaAdventure რომელსაც ჩვენი ეკიპაჟი შეიძლება გადააწყდეს, ამ შემთხვევაში ეს იქნება FlyingDutchman-თან გადაყრა.

var seaAdventure = SeaAdventure(adventureType: "came across FlyingDutchman")


//პირველ რიგში დავიწყოთ ჩვენი საგანძურის ძებნით შევქმნათ ორი ცვლადი საწყისი კოორდინატები საიდანაც ჩვენი გემი აიღებს გეზს, და treasureMap-ის hintToTreasure მეთოდის გამოყენებით ვეცადოთ ვიპოვოთ ჩვენი საგანძური.

var coordX = 35.027
var coordY = 49.009

treasureMap.hintToTreasure(x: coordX, y: coordY)

coordX = 46.007
coordY = 49.005

treasureMap.hintToTreasure(x: coordX, y: coordY)


//საგანძურის პოვნის შემდეგ გადააწყდება adventure-ს, დავბეჭდოთ რა adventure-ა, PirateCode-ს გამოყენებით გადავწყვიტოთ რას იზამს ჩვენი კაპიტანი, ეცდება აარიდოს თავი თავგადასავალს თუ მიხვდება რომ აზრი არ აქვს მოლაპარაკებებს და შეუტევს? არჩევის შემდეგ რის განხილვას მოახდენს თავის ეკიპაჟთან ერთად? როგორ გაიქცეს თუ როგორ შეუტიოს ეფექტურად? გამოიყენებს ის ყველა არსებულ cannon-ს ხომალდზე თუ არა?

let pirateCode = PirateCode()

seaAdventure.encounter()
pirateCode.mutiny()
artemis.fireCannon(count: 25)



//ამ რთულ გადაწყვეტილების მიღების შემდეგ ჩვენ უკვე ვეღარასდროს ვერ გავიგებთ თუ როგორ დამთავრდა ჩვენი კაპიტნის და მისი ეკიპაჟის ამბავი.😄
