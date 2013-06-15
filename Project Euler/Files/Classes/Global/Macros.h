//  Macros.h

#ifndef Project_Euler_Macros_h
#define Project_Euler_Macros_h

// Make's sure a number is within a given range, and sets it to the closest
// endpoint if it is not.
#define CLAMP(X, A, B) ((X < A) ? A : ((X > B) ? B : X))

// Define's for the common types of polygonal numbers.
#define TriangleNumber(n) (n * (n + 1) / 2)
#define SquareNumber(n) (n * n)
#define PentagonalNumber(n) (n * ((3 * n) - 1) / 2)
#define HexagonalNumber(n) (n * ((2 * n) - 1))
#define HeptagonalNumber(n) (n * ((5 * n) - 3) / 2)
#define OctagonalNumber(n) (n * ((3 * n) - 2))

#endif