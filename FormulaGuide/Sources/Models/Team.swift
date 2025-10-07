import Foundation
import CoreLocation

struct Team: Identifiable, Codable {
    let id = UUID()
    let name: String
    let country: String
    let base: String
    let coordinates: CLLocationCoordinate2D
    let founded: String
    let drivers: [String]
    let car: String
    let achievements: String
    let highlights: String
    let imageName: String
    
    static let sampleTeams: [Team] = [
        Team(
            name: "Mercedes-AMG Petronas Formula One Team",
            country: "🇩🇪",
            base: "Brackley, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 52.0307, longitude: -1.1405),
            founded: "2010 (modern team, though Mercedes' F1 heritage dates back to 1954)",
            drivers: ["Lewis Hamilton", "George Russell"],
            car: "Mercedes W15 (2024 season)",
            achievements: "8 consecutive Constructors' Championships (2014–2021), Hamilton tied Schumacher with 7 Drivers' titles.",
            highlights: "Cutting-edge aerodynamics, hybrid power unit excellence, known for precision and innovation.",
            imageName: "team1"
        ),
        Team(
            name: "Scuderia Ferrari",
            country: "🇮🇹",
            base: "Maranello, Italy",
            coordinates: CLLocationCoordinate2D(latitude: 44.5286, longitude: 10.8642),
            founded: "1929 (F1 since 1950)",
            drivers: ["Charles Leclerc", "Carlos Sainz"],
            car: "Ferrari SF-24",
            achievements: "16 Constructors' and 15 Drivers' Championships — the most successful team in F1 history.",
            highlights: "Synonymous with Formula 1, iconic Rosso Corsa red, unparalleled tifosi passion.",
            imageName: "team2"
        ),
        Team(
            name: "Oracle Red Bull Racing",
            country: "🇦🇹",
            base: "Milton Keynes, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 52.0302, longitude: -0.7594),
            founded: "2005",
            drivers: ["Max Verstappen", "Sergio Pérez"],
            car: "Red Bull RB20",
            achievements: "6 Constructors' and 7 Drivers' Championships (Vettel era 2010–2013, Verstappen era 2021–present).",
            highlights: "Bold marketing identity, aggressive strategy, excellent aerodynamics under Adrian Newey.",
            imageName: "team3"
        ),
        Team(
            name: "McLaren Formula 1 Team",
            country: "🇬🇧",
            base: "Woking, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 51.3391, longitude: -0.5395),
            founded: "1963",
            drivers: ["Lando Norris", "Oscar Piastri"],
            car: "McLaren MCL38",
            achievements: "8 Constructors' and 12 Drivers' titles; legendary drivers include Ayrton Senna, Alain Prost, Mika Häkkinen.",
            highlights: "Known for Papaya orange, history of innovation, and strong comeback potential.",
            imageName: "team4"
        ),
        Team(
            name: "Aston Martin Aramco Formula One Team",
            country: "🇬🇧",
            base: "Silverstone, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 52.0710, longitude: -1.0180),
            founded: "Rebranded as Aston Martin in 2021 (previously Racing Point/Force India)",
            drivers: ["Fernando Alonso", "Lance Stroll"],
            car: "Aston Martin AMR24",
            achievements: "Significant improvement since rebranding; podium finishes with Alonso in 2023–2024.",
            highlights: "British heritage combined with luxury branding, ambition to fight for wins.",
            imageName: "team5"
        ),
        Team(
            name: "BWT Alpine F1 Team",
            country: "🇫🇷",
            base: "Enstone, United Kingdom (chassis) & Viry-Châtillon, France (engine)",
            coordinates: CLLocationCoordinate2D(latitude: 51.9280, longitude: -1.4076),
            founded: "2021 (rebranded from Renault F1 Team)",
            drivers: ["Esteban Ocon", "Pierre Gasly"],
            car: "Alpine A524",
            achievements: "Race victory in Hungary 2021 (Ocon).",
            highlights: "Strong French identity, Alpine blue livery, balancing between factory support and independent spirit.",
            imageName: "team6"
        ),
        Team(
            name: "Williams Racing",
            country: "🇬🇧",
            base: "Grove, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 51.6400, longitude: -1.4153),
            founded: "1977",
            drivers: ["Alexander Albon", "Logan Sargeant"],
            car: "Williams FW46",
            achievements: "9 Constructors' and 7 Drivers' titles; legends like Nigel Mansell, Alain Prost, Damon Hill, Jacques Villeneuve.",
            highlights: "Historic team with glorious past, currently rebuilding under new ownership and leadership.",
            imageName: "team7"
        ),
        Team(
            name: "Stake F1 Team Kick Sauber",
            country: "🇨🇭",
            base: "Hinwil, Switzerland",
            coordinates: CLLocationCoordinate2D(latitude: 47.2980, longitude: 8.8371),
            founded: "1993 (as Sauber, renamed several times)",
            drivers: ["Valtteri Bottas", "Zhou Guanyu"],
            car: "Sauber C44",
            achievements: "Notable for developing young talents (Raikkonen, Massa, Vettel).",
            highlights: "Currently in transition, set to become Audi's works team in 2026.",
            imageName: "team8"
        ),
        Team(
            name: "Visa Cash App RB Formula One Team",
            country: "🇮🇹",
            base: "Faenza, Italy",
            coordinates: CLLocationCoordinate2D(latitude: 44.2880, longitude: 11.8835),
            founded: "2006 (as Toro Rosso, Red Bull's junior team)",
            drivers: ["Daniel Ricciardo", "Yuki Tsunoda"],
            car: "VCARB 01",
            achievements: "Famous Monza 2008 win with Sebastian Vettel, Monza 2020 win with Pierre Gasly.",
            highlights: "Talent incubator for Red Bull Racing, with close technical ties.",
            imageName: "team9"
        ),
        Team(
            name: "Haas F1 Team",
            country: "🇺🇸",
            base: "Kannapolis, North Carolina, USA (operations also in UK and Italy)",
            coordinates: CLLocationCoordinate2D(latitude: 35.5062, longitude: -80.6209),
            founded: "2016",
            drivers: ["Kevin Magnussen", "Nico Hülkenberg"],
            car: "Haas VF-24",
            achievements: "Best Constructors' finish = 5th in 2018.",
            highlights: "The only American F1 team, powered by Ferrari engines, lean structure focusing on efficiency.",
            imageName: "team10"
        ),
        Team(
            name: "Minardi F1 Team",
            country: "🇮🇹",
            base: "Faenza, Italy",
            coordinates: CLLocationCoordinate2D(latitude: 44.2880, longitude: 11.8835),
            founded: "1985",
            drivers: ["Fernando Alonso", "Mark Webber", "Giancarlo Fisichella"],
            car: "Minardi M191",
            achievements: "Known for competing with minimal budgets and nurturing young talent.",
            highlights: "Became Toro Rosso (later AlphaTauri / RB); a fan-favorite underdog.",
            imageName: "team11"
        ),
        Team(
            name: "Ligier F1 Team",
            country: "🇫🇷",
            base: "Magny-Cours, France",
            coordinates: CLLocationCoordinate2D(latitude: 46.8641, longitude: 3.1628),
            founded: "1976",
            drivers: ["Jacques Laffite", "Olivier Panis"],
            car: "Ligier JS5 / JS43",
            achievements: "9 Grand Prix victories between 1976 and 1996.",
            highlights: "Classic blue livery and strong national French identity.",
            imageName: "team12"
        ),
        Team(
            name: "Arrows Grand Prix International",
            country: "🇬🇧",
            base: "Milton Keynes, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 52.0310, longitude: -0.7580),
            founded: "1977",
            drivers: ["Riccardo Patrese", "Damon Hill", "Jos Verstappen"],
            car: "Arrows A18",
            achievements: "382 races, known for persistence despite no wins.",
            highlights: "Famous for fighting spirit and creative technical solutions.",
            imageName: "team13"
        ),
        Team(
            name: "BAR – British American Racing",
            country: "🇬🇧",
            base: "Brackley, United Kingdom",
            coordinates: CLLocationCoordinate2D(latitude: 52.0307, longitude: -1.1405),
            founded: "1999",
            drivers: ["Jacques Villeneuve", "Jenson Button"],
            car: "BAR 006",
            achievements: "Runner-up in the 2004 Constructors’ Championship.",
            highlights: "Known for bold branding (dual liveries) and foundation for the modern Mercedes team.",
            imageName: "team14"
        ),
        Team(
            name: "Toyota F1 Team",
            country: "🇯🇵",
            base: "Cologne, Germany (Toyota Motorsport GmbH HQ)",
            coordinates: CLLocationCoordinate2D(latitude: 50.9393, longitude: 6.9603),
            founded: "2002",
            drivers: ["Jarno Trulli", "Ralf Schumacher", "Timo Glock"],
            car: "Toyota TF109",
            achievements: "Multiple podium finishes, strong engineering reputation, but no race wins.",
            highlights: "Massive budget, technically advanced, and respected for its professionalism.",
            imageName: "team15"
        )
    ]
}
