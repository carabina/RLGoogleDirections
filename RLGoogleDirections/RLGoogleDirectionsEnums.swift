//
//  RLGoogleDirectionsEnums.swift
//  RLGoogleDirections
//
//  Created by Romain on 01/03/2015.
//  Copyright (c) 2015 RLT. All rights reserved.
//

import Foundation

/// Possible error codes in the Google Directions API
enum RLGoogleDirectionsError: Int {
	/// Indicates the response contains a valid result
	case OK = 0
	/// Indicates at least one of the locations specified in the request's origin, destination, or waypoints could not be geocoded
	case NotFound
	/// Indicates no route could be found between the origin and destination
	case ZeroResults
	/// Indicates that too many waypointss were provided in the request (the maximum allowed waypoints is 8, plus the origin, and destination)
	case MaxWaypointsExceeded
	/// Indicates that the provided request was invalid. Common causes of this status include an invalid parameter or parameter value
	case InvalidRequest
	/// Indicates the service has received too many requests from this application within the allowed time period
	case OverQueryLimit
	/// Indicates that the service denied use of the directions service by this application
	case RequestDenied
	/// Indicates a directions request could not be processed due to a server error (may succeed with an other attempt)
	case UnknownError
	/// Indicates the inability to generate a valid request URL
	case BadAPIURL
	/// Indicates the inability to parse JSON data returned from the API
	case BadJSONFormatting
	/// Indicates the response status code was unexpectedly missing from the JSON data
	case MissingStatusCode
	
	var description: String {
		switch self {
		case .OK:
			return "OK"
		case .NotFound:
			return "At least one of the locations specified in the request's origin, destination, or waypoints could not be geocoded"
		case .ZeroResults:
			return "No route could be found between the origin and destination"
		case .MaxWaypointsExceeded:
			return "Too many waypointss were provided in the request"
		case .InvalidRequest:
			return "The provided request was invalid"
		case .OverQueryLimit:
			return "The service has received too many requests from this application within the allowed time period"
		case .RequestDenied:
			return "The service denied use of the directions service by this application"
		case .UnknownError:
			return "The directions request could not be processed due to a server error"
		case .BadAPIURL:
			return "Unable to build a suitable URL for API request"
		case .BadJSONFormatting:
			return "Unable to parse JSON data returned from the API"
		case .MissingStatusCode:
			return "Response status code unexpectedly missing from the response payload"
		default:
			return "An unexpected and unknown error occurred"
		}
	}
	
	/**
	Returns an `RLGoogleDirectionsError` object corresponding to the status code returned by the API for a specific response.
	
	:param: status The status code returned by the API
	:returns: The corresponding `RLGoogleDirectionsError` instance
	*/
	static func errorFromStatus(status: String) -> RLGoogleDirectionsError {
		switch (status) {
		case "OK":
			return .OK
		case "NOT_FOUND":
			return .NotFound
		case "ZERO_RESULTS":
			return .ZeroResults
		case "MAX_WAYPOINTS_EXCEEDED":
			return .MaxWaypointsExceeded
		case "INVALID_REQUEST":
			return .InvalidRequest
		case "OVER_QUERY_LIMIT":
			return .OverQueryLimit
		case "REQUEST_DENIED":
			return .RequestDenied
		case "UNKNOWN_ERROR":
			return .UnknownError
		default:
			return .UnknownError
		}
	}
	
	/// Returns `true` if this status code indicates an error during the API request process, or `false` otherwise
	var failed: Bool { return (self != .OK) }
}

/// The mode of transport used when calculating directions
enum RLGoogleDirectionsMode {
	/// Caclulate directions by car/automobile
	case Driving
	/// Calculate directions by walk
	case Walking
	/// Calculate directions by bicycle
	case Bicycling
	/// Calculate directions with public transports
	case Transit
	
	/**
	Returns an `RLGoogleDirectionsMode` object corresponding to the status code returned by the API for a specific response.
	
	:param: label The label returned by the API
	:returns: The corresponding `RLGoogleDirectionsMode` instance, or `nil` if no appropriate mode is found
	*/
	static func modeFromLabel(label: String) -> RLGoogleDirectionsMode? {
		switch label {
		case "DRIVING":
			return .Driving
		case "WALKING":
			return .Walking
		case "BICYCLING":
			return .Bicycling
		case "TRANSIT":
			return .Transit
		default:
			return nil
		}
	}
}

extension RLGoogleDirectionsMode: Printable {
	var description: String {
		switch self {
		case .Driving:
			return "driving"
		case .Walking:
			return "walking"
		case .Bicycling:
			return "bicycling"
		case .Transit:
			return "transit"
		}
	}
}

/// Features that should be avoided when calculating routes
enum RLGoogleDirectionsFeature {
	/// The calculated route should avoid toll roads/bridges
	case Tolls
	/// The calculated route should avoid highways
	case Highways
	/// The calculated route should avoid ferries
	case Ferries
}

extension RLGoogleDirectionsFeature: Printable {
	var description: String {
		switch self {
		case .Tolls:
			return "tolls"
		case .Highways:
			return "highways"
		case .Ferries:
			return "ferries"
		}
	}
}

/// The unit system to use when displaying results (by default, the texts are rendered using the unit system of the origin's country or region)
enum RLGoogleDirectionsUnit {
	/// Use the metric system (textual distances are returned using kilometers and meters)
	case Metric
	/// Use the imperial (English) system (textual distances are returned using kilometers and meters)
	case Imperial
}

extension RLGoogleDirectionsUnit: Printable {
	var description: String {
		switch self {
		case .Metric:
			return "metric"
		case .Imperial:
			return "imperial"
		}
	}
}

/// Preferred modes of transit (only valid for transit directions)
enum RLGoogleDirectionsTransitMode {
	/// The calculated route should prefer travel by bus
	case Bus
	/// The calculated route should prefer travel by subway
	case Subway
	/// The calculated route should prefer travel by train
	case Train
	/// The calculated route should prefer travel by tram and light rail
	case Tram
	/// The calculated route should prefer travel by train, tram, light rail, and subway (equivalent to `Train` + `Tram`+ `Subway`)
	case Rail
}

extension RLGoogleDirectionsTransitMode: Printable {
	var description: String {
		switch self {
		case .Bus:
			return "bus"
		case .Subway:
			return "subway"
		case .Train:
			return "train"
		case .Tram:
			return "tram"
		case .Rail:
			return "rail"
		}
	}
}

/// Preferences for transit routes only ; using this parameter, the options returned can be biased, rather than accepting the default best route chosen by the API
enum RLGoogleDirectionsTransitRoutingPreference {
	/// Indicates that the calculated route should prefer limited amounts of walking
	case LessWalking
	/// Indicates that the calculated route should prefer a limited number of transfers
	case FewerTransfers
}

extension RLGoogleDirectionsTransitRoutingPreference: Printable {
	var description: String {
		switch self {
		case .LessWalking:
			return "less_walking"
		case .FewerTransfers:
			return "fewer_transfers"
		}
	}
}

/// Type of vehicles that run on transit lines
enum RLGoogleDirectionsVehicleType {
	/// Rail
	case Rail
	/// Light rail transit
	case MetroRail
	/// Underground light rail
	case Subway
	/// Above ground light rail
	case Tram
	/// Monorail
	case Monorail
	/// Heavy rail
	case HeavyRail
	/// Commuter rail
	case CommuterTrain
	/// High speed train
	case HighSpeedTrain
	/// Bus
	case Bus
	/// Intercity bus
	case IntercityBus
	/// Trolleybys
	case Trolleybus
	/// Share taxi is a kind of bus with the ability to drop off and pick up passengers anywhere on its route
	case ShareTaxi
	/// Ferry
	case Ferry
	/// A vehicle that operates on a cable, usually on the ground (aerial cable cars may be of the type `GondolaLift`)
	case CableCar
	/// An aerial cable car
	case GondolaLift
	/// A vehicle that is pulled up a steep incline by a cable ; a funicular typically consists of two cars, with each car acting as a counterweight for the other
	case Funicular
	/// All other vehicles will return this type
	case Other
	
	/**
	Returns an `RLGoogleDirectionsVehicleType` object corresponding to the vehicle type returned by the API for a specific line.
	
	:param: value The vehicle type code returned by the API
	:returns: The corresponding `RLGoogleDirectionsVehicleType` instance
	*/
	static func vehicleTypeFromValue(value: String) -> RLGoogleDirectionsVehicleType {
		switch value {
		case "RAIL":
			return .Rail
		case "METRO_RAIL":
			return .MetroRail
		case "SUBWAY":
			return .Subway
		case "TRAM":
			return .Tram
		case "MONORAIL":
			return .Monorail
		case "HEAVY_RAIL":
			return .HeavyRail
		case "COMMUTER_TRAIN":
			return .CommuterTrain
		case "HIGH_SPEED_TRAIN":
			return .HighSpeedTrain
		case "BUS":
			return .Bus
		case "INTERCITY_BUS":
			return .IntercityBus
		case "TROLLEYBUS":
			return .Trolleybus
		case "SHARE_TAXI":
			return .ShareTaxi
		case "FERRY":
			return .Ferry
		case "CABLE_CAR":
			return .CableCar
		case "GONDOLA_LIFT":
			return .GondolaLift
		case "FUNICULAR":
			return .Funicular
		case "OTHER":
			return .Other
		default:
			return .Other
		}
	}
}
