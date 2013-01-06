//  QuestionAndAnswer.m

#import "QuestionAndAnswer.h"

@interface QuestionAndAnswer (Private)

- (NSMutableArray *)arrayOfPrimeNumberUpTo:(long long int)aLimit count:(long long int)aCount;

@end

@implementation QuestionAndAnswer

@synthesize date = _date;
@synthesize text = _text;
@synthesize title = _title;
@synthesize answer = _answer;
@synthesize number = _number;
@synthesize delegate = _delegate;
@synthesize isComputing = _isComputing;
@synthesize estimatedComputationTime = _estimatedComputationTime;
@synthesize estimatedBruteForceComputationTime = _estimatedBruteForceComputationTime;

#pragma mark - Init

- (id)init; {
  if((self = [super init])){
    // Always call initialize when the object is created.
    [self initialize];
    
    // Set that we are not computing by default.
    _isComputing = NO;
    
    // Note: We can set the _isComputing flag to NO as it is a propery. This
    //       allows us to cancel the computation if the user deems it is taking
    //       too long. This is all done with NSOperations. If the question is
    //       solved faster than the user can respond, we ignore using this flag.
    //       Otherwise, we will inject it throughout the computation methods so
    //       that it will terminate the computation.
  }
  return self;
}

#pragma mark - Setup

- (void)initialize; {
  // This method will hold all the precomputed values for the given question.
}

#pragma mark - Methods

- (void)computeAnswer; {
  // This method computes the answer with an optimized solution. It is done on
  // a separate thread to not lock up the UI. For more detail, refer to the
  // DetailViewController.m file in the method:
  //
  // - (IBAction)computeButtonPressed:(UIButton *)aButton;
}

- (void)computeAnswerByBruteForce; {
  // This method computes the answer with a brute force solution. It is done on
  // a separate thread to not lock up the UI. For more detail, refer to the
  // DetailViewController.m file in the method:
  //
  // - (IBAction)computeBruteForceButtonPressed:(UIButton *)aButton;
}

- (NSMutableArray *)arrayOfPrimeNumbersOfSize:(long long int)aSize; {
  // By expanding out the Taylor Series of the result of the Prime Number Theorem,
  //
  // TT (n) ~ n / ln(n),
  //
  // We arrive at the fact that the nth prime is about size:
  //
  // n * ln(n) - n * ln(ln(n)) + O(n * ln(ln(ln(n))))
  //
  // Therefore, if we add a fairly large constant factor of 1.1 to the first term,
  // we should be able to get a fairly accurate upper limit of it's size.
  
  // Compute the limit based on the end size of the array (i.e.: The number of
  // primes in the array).
  long long int limit = (long long int)(1.1 * aSize * log(aSize));
  
  // Return the array of prime numbers based on the computed limit, and the size.
  return [self arrayOfPrimeNumberUpTo:limit count:aSize];
}

- (NSMutableArray *)arrayOfPrimeNumbersLessThan:(long long int)aLimit; {
  // Return the array of prime numbers based on the limit. A size of 0 means that
  // the method doesn't care about the number of primes in the array.
  return [self arrayOfPrimeNumberUpTo:aLimit count:0];
}

@end

#pragma mark - Private Methods

@implementation QuestionAndAnswer (Private)

- (NSMutableArray *)arrayOfPrimeNumberUpTo:(long long int)aLimit count:(long long int)aCount; {
  // There may be more efficient data structure arrangements than this (there are!),
  // but this is the algorithm from Wikipedia. http://en.wikipedia.org/wiki/Sieve_of_Atkin
  //
  // For a full detailed mathematical description and proof of this method, visit:
  //
  // http://www.ams.org/journals/mcom/2004-73-246/S0025-5718-03-01501-1/S0025-5718-03-01501-1.pdf
  
  // The array that will hold all the prime numbers.
  NSMutableArray * primesArray = [[NSMutableArray alloc] init];
  
  // The array that will hold if the number at the index is a prime or not.
  BOOL sieve[(aLimit + 1)];
  
  // Initialize results array.
  for(int i = 4; i < (aLimit + 1); i++){
    // Set by default that a number is NOT prime.
    sieve[i] = NO;
  }
  // Precompute the square root of the limit.
  long long int limitSquareRoot = (long long int)sqrt((double)aLimit);
  
  // The sieve works only for integers > 3, so set the trivial values.
  sieve[0] = NO;
  sieve[1] = NO;
  sieve[2] = YES;
  sieve[3] = YES;
  
  // Loop through all possible integer values for x and y up to the square root
  // of the max prime for the sieve. We don't need any larger values for x or y,
  // since the max value for x or y will be the square root of n. In the quadratics,
  // the theorem showed that the quadratics will produce all primes that also
  // satisfy their wheel factorizations, so we can produce the value of n from
  // the quadratic first, and then filter n through the wheel quadratic.
  
  // For all integers for x less than or equal to the square root of the limit,
  for(int x = 1; x <= limitSquareRoot; x++){
    // For all integers for y less than or equal to the square root of the limit,
    for(int y = 1; y <= limitSquareRoot; y++){
      // First quadratic using m = 12 and r in R1 = {r : 1, 5}.
      int n = (4 * x * x) + (y * y);
      
      if(n <= aLimit && (n % 12 == 1 || n % 12 == 5)){
        sieve[n] = !sieve[n];
      }
      // Second quadratic using m = 12 and r in R2 = {r : 7}.
      n = (3 * x * x) + (y * y);
      
      if(n <= aLimit && (n % 12 == 7)){
        sieve[n] = !sieve[n];
      }
      // Third quadratic using m = 12 and r in R3 = {r : 11}.
      n = (3 * x * x) - (y * y);
      
      if(x > y && n <= aLimit && (n % 12 == 11)){
        sieve[n] = !sieve[n];
      }
      // Note: that R1 union R2 union R3 is the set R = {r : 1, 5, 7, 11}, which
      // is all values 0 < r < 12 where r is a relative prime of 12. Thus all
      // primes become candidates.
    }
  }
  // Remove all perfect squares, since the quadratic wheel factorization filter
  // removes only some of them.
  for(int n = 5; n <= limitSquareRoot; n++){
    // If it is a prime number,
    if(sieve[n]){
      // Grab the square of the prime number.
      int x = n * n;
      
      // For all the multiples of the square number,
      for(int i = x; i <= aLimit; i += x){
        // Set that this multiple is not a prime.
        sieve[i] = NO;
      }
    }
  }
  // If the count is greater than 0, we only add the primes up to the count to
  // the primes array.
  if(aCount > 0){
    // Variable to hold the current number of primes added.
    long long int currentCount = 0;
    
    // Add in all the primes to the primes array.
    for(int i = 0; i <= aLimit; i++){
      // If the number is a prime number,
      if(sieve[i]){
        // Increase the current count or primes by 1.
        currentCount++;
        
        // Add the prime number to the array.
        [primesArray addObject:[NSNumber numberWithInt:i]];
        
        // If the current count equals the requested number of primes,
        if(currentCount == aCount){
          // Break out of the loop.
          break;
        }
      }
    }
  }
  // If the count is equal to 0, we add all the found primes to the array.
  else{
    // Add in all the primes to the primes array.
    for(int i = 0; i <= aLimit; i++){
      // If the number is a prime number,
      if(sieve[i]){
        // Add the prime number to the array.
        [primesArray addObject:[NSNumber numberWithInt:i]];
      }
    }
  }
  // Return the primes array.
  return primesArray;
}

@end