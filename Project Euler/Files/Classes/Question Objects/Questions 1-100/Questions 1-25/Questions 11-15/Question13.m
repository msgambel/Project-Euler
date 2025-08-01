//  Question13.m

#import "Question13.h"
#import "BigInt.h"

@interface Question13 (Private)

- (NSString *)arrayOfNumbers;

@end

@implementation Question13

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"22 March 2002";
  self.hint = @"When adding a bunch of single digit numbers, if you don't care about the units digit in the result, what number could you divide the sum by to eliminate the units digit?";
  self.link = @"https://docs.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql";
  self.text = [NSString stringWithFormat:@"Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.\n\n%@", [self arrayOfNumbers]];
  self.isFun = YES;
  self.title = @"Large sum";
  self.answer = @"5537376230";
  self.number = @"13";
  self.rating = @"4";
  self.summary = @"Sum some large numbers. That's it.";
  self.category = @"Combinations";
  self.isUseful = NO;
  self.keywords = @"sum,big,int,large,first,digits,10,ten,150,one,hundred,and,fifty,numbers,list,work,out";
  self.loadsFile = NO;
  self.memorable = NO;
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Meh";
  self.usesBigInt = YES;
  self.isIntuitive = YES;
  self.recommended = YES;
  self.commentCount = @"20";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"13/01/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"Elementary";
  self.solvableByHand = NO;
  self.canBeSimplified = NO;
  self.completedOnDate = @"13/01/13";
  self.worthRevisiting = NO;
  self.solutionLineCount = @"13";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = NO;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"2.86e-03";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"3.28e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply parse the above string into an array, and add all the digits
  // up exactly like long addition. We divide by 10 after each loop, as we do NOT
  // care about the units digit, until we get to the first 10 digits of the
  // number. From there, it is a few more simple additions to get the final result.
  
  // Variable to hold the list of numbers in a string.
  NSString * stringOfNumbers = [self arrayOfNumbers];
  
  // Variable array to hold each individual number in the list as a string.
  NSArray * parsedArray = [stringOfNumbers componentsSeparatedByString:@"\n"];
  
  // Variable to hold the index and length of the current "digit".
  NSRange subStringRange;
  
  // Set the sum to 0 before we start iterating over all the numbers.
  long long int sum = 0;
  
  // For all the numbers from the starting index to the end index,
  for(int index = 49; index >= 8; index--){
    // For all the numbers (as strings) in the array,
    for(NSString * stringNumber in parsedArray){
      // Compute the new current range.
      subStringRange = NSMakeRange(index, 1);
      
      // Grab the value of the current "digit" and add it to the sum.
      sum += [[stringNumber substringWithRange:subStringRange] intValue];
    }
    // Divide the sum by 10. This removes the units digit
    sum /= 10;
  }
  // For all the strings in the parsed strings array.
  for(NSString * stringNumber in parsedArray){
    // Compute the new current range.
    subStringRange = NSMakeRange(0, 8);
    // Grab the value of the current "digit".
    sum += [[stringNumber substringWithRange:subStringRange] longLongValue];
  }
  // Set the answer string to the sum.
  self.answer = [NSString stringWithFormat:@"%llu", sum];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

- (void)computeAnswerByBruteForce; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the BigInt class to add up all the numbers. Simple.
  
  // Variable to hold the list of numbers in a string.
  NSString * stringOfNumbers = [self arrayOfNumbers];
  
  // Array to hold each individual number in the list as a string.
  NSArray * parsedArray = [stringOfNumbers componentsSeparatedByString:@"\n"];
  
  // Here, we just use a BigInt data model to handle the multiplication. Then we
  // return the result as a string, and use a helper method to add up the digits.
  
  // Variable to hold the result number of the addition. Start at the default
  // value of 0.
  BigInt * resultNumber = [BigInt createFromInt:0];
  
  // Temporary variable to hold the result of the addition.
  BigInt * temporaryNumber = nil;
  
  // For all the numbers (as strings) in the array,
  for(NSString * stringNumber in parsedArray){
    // Store the addition of the string and the result number in a temporary variable.
    temporaryNumber = [resultNumber add:[BigInt createFromString:stringNumber andRadix:10]];
    
    // Set the result number to be the result of the above addition.
    resultNumber = temporaryNumber;
  }
  // Grab the first 10 "digit" of the resulting sum.
  NSString * sumResult = [resultNumber toStringWithRadix:10];
  
  // Set the answer string to the sum result.
  self.answer = [sumResult substringWithRange:NSMakeRange(0, 10)];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question13 (Private)

- (NSString *)arrayOfNumbers; {
  return @"37107287533902102798797998220837590246510135740250\n46376937677490009712648124896970078050417018260538\n74324986199524741059474233309513058123726617309629\n91942213363574161572522430563301811072406154908250\n23067588207539346171171980310421047513778063246676\n89261670696623633820136378418383684178734361726757\n28112879812849979408065481931592621691275889832738\n44274228917432520321923589422876796487670272189318\n47451445736001306439091167216856844588711603153276\n70386486105843025439939619828917593665686757934951\n62176457141856560629502157223196586755079324193331\n64906352462741904929101432445813822663347944758178\n92575867718337217661963751590579239728245598838407\n58203565325359399008402633568948830189458628227828\n80181199384826282014278194139940567587151170094390\n35398664372827112653829987240784473053190104293586\n86515506006295864861532075273371959191420517255829\n71693888707715466499115593487603532921714970056938\n54370070576826684624621495650076471787294438377604\n53282654108756828443191190634694037855217779295145\n36123272525000296071075082563815656710885258350721\n45876576172410976447339110607218265236877223636045\n17423706905851860660448207621209813287860733969412\n81142660418086830619328460811191061556940512689692\n51934325451728388641918047049293215058642563049483\n62467221648435076201727918039944693004732956340691\n15732444386908125794514089057706229429197107928209\n55037687525678773091862540744969844508330393682126\n18336384825330154686196124348767681297534375946515\n80386287592878490201521685554828717201219257766954\n78182833757993103614740356856449095527097864797581\n16726320100436897842553539920931837441497806860984\n48403098129077791799088218795327364475675590848030\n87086987551392711854517078544161852424320693150332\n59959406895756536782107074926966537676326235447210\n69793950679652694742597709739166693763042633987085\n41052684708299085211399427365734116182760315001271\n65378607361501080857009149939512557028198746004375\n35829035317434717326932123578154982629742552737307\n94953759765105305946966067683156574377167401875275\n88902802571733229619176668713819931811048770190271\n25267680276078003013678680992525463401061632866526\n36270218540497705585629946580636237993140746255962\n24074486908231174977792365466257246923322810917141\n91430288197103288597806669760892938638285025333403\n34413065578016127815921815005561868836468420090470\n23053081172816430487623791969842487255036638784583\n11487696932154902810424020138335124462181441773470\n63783299490636259666498587618221225225512486764533\n67720186971698544312419572409913959008952310058822\n95548255300263520781532296796249481641953868218774\n76085327132285723110424803456124867697064507995236\n37774242535411291684276865538926205024910326572967\n23701913275725675285653248258265463092207058596522\n29798860272258331913126375147341994889534765745501\n18495701454879288984856827726077713721403798879715\n38298203783031473527721580348144513491373226651381\n34829543829199918180278916522431027392251122869539\n40957953066405232632538044100059654939159879593635\n29746152185502371307642255121183693803580388584903\n41698116222072977186158236678424689157993532961922\n62467957194401269043877107275048102390895523597457\n23189706772547915061505504953922979530901129967519\n86188088225875314529584099251203829009407770775672\n11306739708304724483816533873502340845647058077308\n82959174767140363198008187129011875491310547126581\n97623331044818386269515456334926366572897563400500\n42846280183517070527831839425882145521227251250327\n55121603546981200581762165212827652751691296897789\n32238195734329339946437501907836945765883352399886\n75506164965184775180738168837861091527357929701337\n62177842752192623401942399639168044983993173312731\n32924185707147349566916674687634660915035914677504\n99518671430235219628894890102423325116913619626622\n73267460800591547471830798392868535206946944540724\n76841822524674417161514036427982273348055556214818\n97142617910342598647204516893989422179826088076852\n87783646182799346313767754307809363333018982642090\n10848802521674670883215120185883543223812876952786\n71329612474782464538636993009049310363619763878039\n62184073572399794223406235393808339651327408011116\n66627891981488087797941876876144230030984490851411\n60661826293682836764744779239180335110989069790714\n85786944089552990653640447425576083659976645795096\n66024396409905389607120198219976047599490197230297\n64913982680032973156037120041377903785566085089252\n16730939319872750275468906903707539413042652315011\n94809377245048795150954100921645863754710598436791\n78639167021187492431995700641917969777599028300699\n15368713711936614952811305876380278410754449733078\n40789923115535562561142322423255033685442488917353\n44889911501440648020369068063960672322193204149535\n41503128880339536053299340368006977710650566631954\n81234880673210146739058568557934581403627822703280\n82616570773948327592232845941706525094512325230608\n22918802058777319719839450180888072429661980811197\n77158542502016545090413245809786882778948721859617\n72107838435069186155435662884062257473692284509516\n20849603980134001723930671666823555245252804609722\n53503534226472524250874054075591789781264330331690";
}

@end