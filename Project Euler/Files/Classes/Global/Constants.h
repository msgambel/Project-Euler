//  Constants.h

#ifndef Project_Euler_Constants_h
#define Project_Euler_Constants_h

#import "Structures.h"

// Note: Enumerations.h is imported via Structures.h.

// Return a PrimePower structure populated with 0's.
static const PrimePower PrimePowerZero = {0, 0};

// Return a MovingProduct4 structure populated with 0's.
static const MovingProduct4 MovingProduct4Zero = {0, 0, {0, 0, 0, 0}};

// Return a MovingProduct5 structure populated with 0's.
static const MovingProduct5 MovingProduct5Zero = {0, 0, {0, 0, 0, 0, 0}};

// Return a MovingProduct4 structure populated with 1's.
static const MovingProduct4 MovingProduct4One = {1, 1, {1, 1, 1, 1}};

// Return a MovingProduct5 structure populated with 1's.
static const MovingProduct5 MovingProduct5One = {1, 1, {1, 1, 1, 1, 1}};

// Return a PolygonalNumber structure populated with 0's.
static const PolygonalNumber PolygonalNumberZero = {0, 0};

#endif