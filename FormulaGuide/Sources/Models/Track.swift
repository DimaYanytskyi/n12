import Foundation
import CoreLocation

struct Track: Identifiable, Codable {
    let id = UUID()
    let name: String
    let country: String
    let opened: String
    let length: String
    let coordinates: CLLocationCoordinate2D
    let highlights: String
    let history: String
    let atmosphere: String
    let imageName: String
    
    static let sampleTracks: [Track] = [
        Track(
            name: "Silverstone Circuit",
            country: "United Kingdom",
            opened: "1948",
            length: "5.891 km",
            coordinates: CLLocationCoordinate2D(latitude: 52.0733, longitude: -1.0141),
            highlights: "Famous for high-speed corners like Maggots–Becketts, long straights, and technical sections.",
            history: "Hosted the very first Formula 1 World Championship race in 1950. Considered the home of British motorsport.",
            atmosphere: "Packed with loyal British fans, especially McLaren and Mercedes supporters.",
            imageName: "track1"
        ),
        Track(
            name: "Monza Circuit",
            country: "Italy",
            opened: "1922",
            length: "5.793 km",
            coordinates: CLLocationCoordinate2D(latitude: 45.6156, longitude: 9.2811),
            highlights: "Long straights, Ascari and Rettifilo chicanes, legendary Parabolica.",
            history: "One of the oldest circuits in F1, known as the \"Temple of Speed.\"",
            atmosphere: "Ferrari tifosi turn the Italian GP into a festival of passion.",
            imageName: "track2"
        ),
        Track(
            name: "Circuit de Spa-Francorchamps",
            country: "Belgium",
            opened: "1921 (modern layout 1979)",
            length: "7.004 km",
            coordinates: CLLocationCoordinate2D(latitude: 50.4372, longitude: 5.9714),
            highlights: "Eau Rouge–Raidillon complex, long straights, and dramatic elevation changes.",
            history: "Host of the Belgian GP, also famous for the 24 Hours of Spa endurance race.",
            atmosphere: "Mountain weather creates unpredictable and dramatic races.",
            imageName: "track3"
        ),
        Track(
            name: "Suzuka Circuit",
            country: "Japan",
            opened: "1962",
            length: "5.807 km",
            coordinates: CLLocationCoordinate2D(latitude: 34.8431, longitude: 136.5410),
            highlights: "Only figure-eight track in F1, iconic corners like 130R, Degner, and Casio Triangle.",
            history: "Known for epic title battles in the late 80s and 90s.",
            atmosphere: "Japanese fans are among the most creative and passionate in the sport.",
            imageName: "track4"
        ),
        Track(
            name: "Circuit de Monaco",
            country: "Monaco",
            opened: "1929",
            length: "3.337 km",
            coordinates: CLLocationCoordinate2D(latitude: 43.7347, longitude: 7.4206),
            highlights: "Ultra-narrow city streets, Fairmont Hairpin, and the tunnel section.",
            history: "The most prestigious F1 race; victory here is considered the crown jewel of the sport.",
            atmosphere: "A glamorous mix of yachts, luxury, and racing tradition.",
            imageName: "track5"
        ),
        Track(
            name: "Nürburgring Nordschleife",
            country: "Germany",
            opened: "1927",
            length: "20.832 km",
            coordinates: CLLocationCoordinate2D(latitude: 50.3356, longitude: 6.9475),
            highlights: "154 corners, 300 m elevation change, through forests and hills.",
            history: "Nicknamed \"The Green Hell\" by Jackie Stewart. Used for endurance racing and car testing.",
            atmosphere: "Legendary among motorsport fans, especially for the 24h Nürburgring.",
            imageName: "track6"
        ),
        Track(
            name: "Interlagos (Autódromo José Carlos Pace)",
            country: "Brazil",
            opened: "1940",
            length: "4.309 km",
            coordinates: CLLocationCoordinate2D(latitude: -23.7010, longitude: -46.6970),
            highlights: "Short lap, undulating surface, and the iconic Senna S corner.",
            history: "Famous for dramatic season finales in F1.",
            atmosphere: "Brazilian fans create a loud, colorful, carnival-like environment.",
            imageName: "track7"
        ),
        Track(
            name: "Circuit of the Americas (COTA)",
            country: "USA",
            opened: "2012",
            length: "5.513 km",
            coordinates: CLLocationCoordinate2D(latitude: 30.1328, longitude: -97.6411),
            highlights: "20 corners, 40 m elevation at Turn 1, inspired by iconic track sections.",
            history: "The first modern, purpose-built F1 track in the USA.",
            atmosphere: "Combines racing with big American entertainment shows.",
            imageName: "track8"
        ),
        Track(
            name: "Bahrain International Circuit",
            country: "Bahrain",
            opened: "2004",
            length: "5.412 km",
            coordinates: CLLocationCoordinate2D(latitude: 26.0325, longitude: 50.5106),
            highlights: "Night races under floodlights, desert environment, sand challenges.",
            history: "First ever Formula 1 Grand Prix in the Middle East.",
            atmosphere: "A unique mix of desert scenery and dramatic night racing.",
            imageName: "track9"
        ),
        Track(
            name: "Circuit de Barcelona-Catalunya",
            country: "Spain",
            opened: "1991",
            length: "4.675 km",
            coordinates: CLLocationCoordinate2D(latitude: 41.5692, longitude: 2.2578),
            highlights: "Long main straight, technical middle sector, key testing venue for teams.",
            history: "A permanent fixture in the F1 calendar since 1991.",
            atmosphere: "Local fans strongly support Fernando Alonso and Carlos Sainz.",
            imageName: "track10"
        ),
        Track(
            name: "Shanghai International Circuit",
            country: "China",
            opened: "2004",
            length: "5.451 km",
            coordinates: CLLocationCoordinate2D(latitude: 31.3389, longitude: 121.2197),
            highlights: "Unique snail-shaped Turn 1–2, long back straight leading into heavy braking zone.",
            history: "Hosted the first Chinese GP in 2004; scene of many strategic races.",
            atmosphere: "Modern venue with vast grandstands and enthusiastic local support.",
            imageName: "track11"
        ),
        Track(
            name: "Imola (Autodromo Enzo e Dino Ferrari)",
            country: "Italy",
            opened: "1953",
            length: "4.909 km",
            coordinates: CLLocationCoordinate2D(latitude: 44.3439, longitude: 11.7167),
            highlights: "Technical chicanes like Variante Alta, flowing rhythm, punishes mistakes.",
            history: "Historic San Marino GP venue; returned to F1 calendar in the 2020s.",
            atmosphere: "Passionate Italian fans and old-school circuit character.",
            imageName: "track12"
        ),
        Track(
            name: "Marina Bay Street Circuit",
            country: "Singapore",
            opened: "2008",
            length: "4.940 km",
            coordinates: CLLocationCoordinate2D(latitude: 1.2914, longitude: 103.8644),
            highlights: "Night race, bumpy street surface, many 90-degree corners, high safety car chance.",
            history: "First ever F1 night race, known for endurance and strategy.",
            atmosphere: "Glittering skyline backdrop and festival feel in the city.",
            imageName: "track13"
        ),
        Track(
            name: "Red Bull Ring",
            country: "Austria",
            opened: "1969 (modern 2011)",
            length: "4.318 km",
            coordinates: CLLocationCoordinate2D(latitude: 47.2197, longitude: 14.7647),
            highlights: "Short lap, big elevation, heavy braking zones and overtaking opportunities.",
            history: "Formerly Österreichring/A1-Ring; revived as Red Bull Ring in 2011.",
            atmosphere: "Beautiful Styrian hills with orange-clad Verstappen fans.",
            imageName: "track14"
        ),
        Track(
            name: "Circuit Gilles Villeneuve",
            country: "Canada",
            opened: "1978",
            length: "4.361 km",
            coordinates: CLLocationCoordinate2D(latitude: 45.5006, longitude: -73.5228),
            highlights: "Long straights, heavy braking chicanes, iconic Wall of Champions.",
            history: "Named after Canadian legend Gilles Villeneuve; hosts the Canadian GP.",
            atmosphere: "Party vibe in Montreal with passionate North American crowd.",
            imageName: "track15"
        )
    ]
}

extension CLLocationCoordinate2D: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    private enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
}
