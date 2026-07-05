import '../models/tourist_route.dart';
import '../models/place_item.dart';

const touristRoutes = <TouristRoute>[
  TouristRoute(
    id: 'cerro_ancon',
    name: 'Ruta Cerro Ancón',
    description: 'Naturaleza, historia, miradores y una de las mejores vistas de la ciudad.',
    latitude: 8.9574,
    longitude: -79.5496,
    estimatedMinutes: 120,
    tags: ['naturaleza', 'historia', 'fotos', 'familia'],
  ),
  TouristRoute(
    id: 'cinta_costera',
    name: 'Ruta Cinta Costera',
    description: 'Caminar, comer, ver la bahía y conectar con Casco Antiguo.',
    latitude: 8.9744,
    longitude: -79.5226,
    estimatedMinutes: 90,
    tags: ['urbano', 'gastronomía', 'pareja', 'running'],
  ),
  TouristRoute(
    id: 'casco_viejo',
    name: 'Ruta Casco Antiguo',
    description: 'Historia, rooftops, cafés, plazas y arquitectura colonial.',
    latitude: 8.9524,
    longitude: -79.5353,
    estimatedMinutes: 150,
    tags: ['historia', 'cultura', 'gastronomía', 'noche'],
  ),
];

const mockPlaces = <PlaceItem>[
  PlaceItem(
    id: 'mercado_mariscos',
    name: 'Mercado de Mariscos',
    category: 'restaurante',
    description: 'Buena parada antes o después de Cinta Costera/Casco para ceviche y mariscos.',
    latitude: 8.9538,
    longitude: -79.5402,
    rating: 4.3,
    priceLevel: r'$$',
    sponsored: true,
  ),
  PlaceItem(
    id: 'mi_pueblito',
    name: 'Mi Pueblito',
    category: 'atractivo',
    description: 'Punto cultural cercano al Cerro Ancón.',
    latitude: 8.9592,
    longitude: -79.5485,
    rating: 4.2,
    priceLevel: r'$',
  ),
  PlaceItem(
    id: 'cafe_casco',
    name: 'Café Casco',
    category: 'café',
    description: 'Parada recomendada para descansar durante la ruta del Casco Antiguo.',
    latitude: 8.9518,
    longitude: -79.5350,
    rating: 4.5,
    priceLevel: r'$$',
  ),
  PlaceItem(
    id: 'hotel_casco',
    name: 'Hotel Boutique Casco',
    category: 'hotel',
    description: 'Opción de hospedaje para turistas que quieren caminar el Casco.',
    latitude: 8.9506,
    longitude: -79.5361,
    rating: 4.6,
    priceLevel: r'$$$',
  ),
];
