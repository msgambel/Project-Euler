//  Enumerations.h

#ifndef Project_Euler_Enumerations_h
#define Project_Euler_Enumerations_h

// Enum of the 3 types of Sudoku Groups.
typedef enum {
  SudokuGroupType_Row,
  SudokuGroupType_Column,
  SudokuGroupType_Square,
  SudokuGroupType_Total
}SudokuGroupType;

// Enum for the days of the week.
typedef enum {
  Day_Monday,
  Day_Tuesday,
  Day_Wednesday,
  Day_Thursday,
  Day_Friday,
  Day_Saturday,
  Day_Sunday
}Day;

// Enum for the months of the year.
typedef enum {
  Month_January,
  Month_February,
  Month_March,
  Month_April,
  Month_May,
  Month_June,
  Month_July,
  Month_August,
  Month_September,
  Month_October,
  Month_November,
  Month_December
}Month;

// Enumeration to hold the possible types of a polygonal number.
typedef enum {
  PolygonalNumberType_Triangle,
  PolygonalNumberType_Square,
  PolygonalNumberType_Pentagonal,
  PolygonalNumberType_Hexagonal,
  PolygonalNumberType_Heptagonal,
  PolygonalNumberType_Octagonal,
  PolygonalNumberType_None
}PolygonalNumberType;

// Enumeration to hold the possible suits a card can have.
typedef enum {
  CardSuit_None,
  CardSuit_Spades,
  CardSuit_Hearts,
  CardSuit_Diamonds,
  CardSuit_Clubs
}CardSuit;

// Enumeration to hold the possible ranks a poker hand can have.
typedef enum {
  CardRank_None,
  CardRank_HighCard,
  CardRank_OnePair,
  CardRank_TwoPairs,
  CardRank_ThreeOfAKind,
  CardRank_Straight,
  CardRank_Flush,
  CardRank_FullHouse,
  CardRank_FourOfAKind,
  CardRank_StraightFlush,
  CardRank_RoyalFlush
}CardRank;

// Enumeration to hold the types of operators for reducing a string of equations.
typedef enum {
  OperatorType_Addition,
  OperatorType_Subtraction,
  OperatorType_Multiplication,
  OperatorType_Division
}OperatorType;

#endif
