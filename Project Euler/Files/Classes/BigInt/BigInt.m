//
//  BigInt.m
//
//  Created by Josh Santomieri on 5/17/09.
//
// This is a port of C# code originally written by Chew Keong TAN
// See http://www.codeproject.com/csharp/biginteger.asp for more details.
//
// Objective-C Big Integer Library

#import "BigInt.h"

#define _BI_DEBUG_ 0

static int primesBelow2000[] = {
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97,
  101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199,
  211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293,
  307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397,
  401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499,
  503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599,
  601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691,
  701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797,
  809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887,
  907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997,
  1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097,
  1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193,
  1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297,
  1301, 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399,
  1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499,
  1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597,
  1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669, 1693, 1697, 1699,
  1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789,
  1801, 1811, 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889,
  1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987, 1993, 1997, 1999 };

@implementation BigInt

@synthesize dataLength;

#pragma mark - Init

- (id)init; {
	if((self = [super init])){
		dataLength = 1;
	}
	return self;
}

- (id)initWithInt:(int)value; {
	return [self initWithLong:value];
}

- (id)initWithLong:(long)value; {
	if((self = [super init])){
		bzero(data, sizeof(data));
		
		long long tempVal = (long long)value;
		long long tmp2 = (long long)value;
		
		// copy bytes from long to BigInteger without any assumption of
		// the length of the long datatype
		
		dataLength = 0;
    
		while (tmp2 != 0 && dataLength < MAX_LENGTH) {
			data[dataLength] = (uint)(tmp2 & 0xFFFFFFFF);
			tmp2 >>= 32;
			dataLength++;
		}
		if (tempVal > 0)         // overflow check for +ve value
		{
			if (tmp2 != 0 || (data[MAX_LENGTH - 1] & 0x80000000) != 0)
				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Positive overflow in constructor." userInfo:nil];
		}
		else if (tempVal < 0)    // underflow check for -ve value
		{
			if (tmp2 != -1 || (data[MAX_LENGTH - 1] & 0x80000000) == 0)
				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Negative underflow in constructor." userInfo:nil];
			
		}
		if (dataLength == 0)
			dataLength = 1;
	}
	return self;
}

- (id)initWithULong:(ulong)value; {
	if(self = [super init]) {
		bzero(data, sizeof(data));
		
		ulong tempVal = (ulong)value;
		ulong tmp2 = (ulong)value;
		
#if _BI_DEBUG_
		NSLog(@"initWithULong:value = %qi", value);
#endif
		
		dataLength = 0;
		
    while (tmp2 != 0 && dataLength < MAX_LENGTH) {
			data[dataLength] = (uint)(tmp2 & 0xFFFFFFFF);
			tmp2 >>= 32;
			dataLength++;
		}
		if (tempVal > 0)         // overflow check for +ve value
		{
			if (tmp2 != 0 || (data[MAX_LENGTH - 1] & 0x80000000) != 0)
				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Positive overflow in constructor." userInfo:nil];
		}
    // Since ulong can never be -ve, this case is commented out.
    //		else if (tempVal < 0)    // underflow check for -ve value
    //		{
    //			if (tmp2 != -1 || (data[MAX_LENGTH - 1] & 0x80000000) == 0)
    //				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Negative underflow in constructor." userInfo:nil];
    //		}
    //
		if (dataLength == 0)
			dataLength = 1;
	}
	return self;
}

- (id)initWithBigInt:(BigInt *)value; {
	if(self = [super init]) {
		bzero(data, sizeof(data));
		
		dataLength = value.dataLength;
    
		for (int i = 0; i < dataLength; i++)
			data[i] = [value getDataAtIndex:i];
	}
	return self;
}

- (id)initWithUIntArray:(uint *)value withSize:(int)size; {
	if(self = [super init]) {
		bzero(data, sizeof(data));
		dataLength = size;
		
		if (dataLength > MAX_LENGTH)
			@throw [NSException exceptionWithName:@"ArithmaticException" reason:@"Byte overflow in constructor" userInfo:nil];
		
		for (int i = dataLength - 1, j = 0; i >= 0; i--, j++) {
			data[j] = (uint)(value[i]);
		}
		while (dataLength > 1 && data[dataLength - 1] == 0)
			dataLength--;
	}
	return self;
}

- (id)initWithString:(NSString *)value andRadix:(int)radix; {
	if(self = [super init]) {
		bzero(data, sizeof(data));
		
		BigInt *multiplier = [BigInt createFromLong:1];
		BigInt *result = [BigInt create];
		
		value = [value uppercaseString];
		int limit = 0;
		
		if ([value characterAtIndex:0] == '-')
			limit = 1;
		
		for (int i = [value length] - 1; i >= limit; i--) {
			int posVal = (int)[value characterAtIndex:i];
			
			if (posVal >= '0' && posVal <= '9')
				posVal -= '0';
			else if (posVal >= 'A' && posVal <= 'Z')
				posVal = (posVal - 'A') + 10;
			else
				posVal = 9999999;       // arbitrary large
			
			if (posVal >= radix)
				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Invalid string in constructor." userInfo:nil];
			else {
				if ([value characterAtIndex:0] == '-')
					posVal = -posVal;
				
				BigInt * mult = [multiplier multiply:[BigInt createFromInt:posVal]];
				result = [result add:mult];
				
				if ((i - 1) >= limit)
					multiplier = [multiplier multiply:[BigInt createFromInt:radix]];
			}
		}
		if ([value characterAtIndex:0] == '-')     // negative values
		{
			if (([result getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) == 0)
				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Negative underflow in constructor." userInfo:nil];
		}
		else    // positive values
		{
			if (([result getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)
				@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Positive overflow in constructor." userInfo:nil];
		}
		for (int i = 0; i < result.dataLength; i++)
			[self setData:[result getDataAtIndex:i] atIndex:i];
		
		dataLength = result.dataLength;
	}
	return self;
}

+ (BigInt *)create; {
	return [BigInt createFromLong:0];
}

+ (BigInt *)createFromInt:(int)value; {
	return [[BigInt alloc] initWithLong:(long)value];
}

+ (BigInt *)createFromLong:(long)value; {
	return [[BigInt alloc] initWithLong:value];
}

+ (BigInt *)createFromULong:(ulong)value; {
	return [[BigInt alloc] initWithULong:value];
}

+ (BigInt *)createFromBigInt:(BigInt *)value; {
	return [[BigInt alloc] initWithBigInt:value];
}

+ (BigInt *)createFromString:(NSString *)value andRadix:(int)radix; {
	return [[BigInt alloc] initWithString:value andRadix:radix];
}

#pragma mark - Methods

- (uint *)getData; {
	return data;
}

- (uint)getDataAtIndex:(int)index; {
	return data[index];
}

- (void)setData:(uint)value atIndex:(int)index; {
	data[index] = value;
}

- (BigInt *)add:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"add");
#endif
	
	BigInt * result = [BigInt create];
	result.dataLength = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	ulong carry = 0;
  
	for (int i = 0; i < result.dataLength; i++) {
		ulong sum = (ulong)[self getDataAtIndex:i] + (ulong)[bi2 getDataAtIndex:i] + carry;
		carry = sum >> 32;
		[result setData:(uint)(sum & 0xFFFFFFFF) atIndex:i];
	}
	if (carry != 0 && result.dataLength < MAX_LENGTH) {
		[result setData:(uint)carry atIndex:result.dataLength];
		result.dataLength++;
	}
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	// overflow check
	int lastPos = MAX_LENGTH - 1;
	if (([self getDataAtIndex:lastPos] & 0x80000000) == ([bi2 getDataAtIndex:lastPos] & 0x80000000) &&
      ([result getDataAtIndex:lastPos] & 0x80000000) != ([self getDataAtIndex:lastPos] & 0x80000000)) {
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Overflow" userInfo:nil];
	}
	return result;
}

- (BigInt *)subtract:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"subtract");
#endif
	
	BigInt * result = [[BigInt alloc] init];
	result.dataLength = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	
	long carryIn = 0;
	for (int i = 0; i < result.dataLength; i++) {
		long long diff = (((long long)[self getDataAtIndex:i] - (long long)[bi2 getDataAtIndex:i]) - carryIn);
		[result setData:(uint)(diff & 0xFFFFFFFF) atIndex:i];
		
		if (diff < 0)
			carryIn = 1;
		else
			carryIn = 0;
	}
	// roll over to negative
	if (carryIn != 0) {
		for (int i = result.dataLength; i < MAX_LENGTH; i++) {
			[result setData:0xFFFFFFFF atIndex:i];
		}
		result.dataLength = MAX_LENGTH;
	}
	// fixed in v1.03 to give correct datalength for a - (-b)
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	// overflow check
	int lastPos = MAX_LENGTH - 1;
  
	if (([self getDataAtIndex:lastPos] & 0x80000000) != ([bi2 getDataAtIndex:lastPos] & 0x80000000) &&
      ([result getDataAtIndex:lastPos] & 0x80000000) != ([self getDataAtIndex:lastPos] & 0x80000000)) {
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Overflow" userInfo:nil];
	}
	return result;
}

- (BigInt *)multiply:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"multiply");
#endif
	
	BigInt * result = [BigInt create];
	int lastPos = MAX_LENGTH - 1;
	bool bi1Neg = false, bi2Neg = false;
	BigInt *bi1 = [BigInt createFromBigInt:self];
	
	// take the absolute value of the inputs
	@try {
		if (([bi1 getDataAtIndex:lastPos] & 0x80000000) != 0)     // bi1 negative
		{
			bi1Neg = true; bi1 = [bi1 negate];
		}
		if (([bi2 getDataAtIndex:lastPos] & 0x80000000) != 0)     // bi2 negative
		{
			bi2Neg = true; bi2 = [bi2 negate];
		}
	}
	@catch (NSException *ex) { }
	
	// multiply the absolute values
	@try {
		for (int i = 0; i < bi1.dataLength; i++) {
			if ([bi1 getDataAtIndex:i] == 0) continue;
			
			ulong mcarry = 0;
			for (int j = 0, k = i; j < bi2.dataLength; j++, k++) {
				// k = i + j
				
				ulong bi1_val = (ulong)[bi1 getDataAtIndex:i];
				ulong bi2_val = (ulong)[bi2 getDataAtIndex:j];
				ulong res_val = (ulong)[result getDataAtIndex:k];
				
#if _BI_DEBUG_
				NSLog(@"bi1_val = %qi", bi1_val);
#endif
				ulong val = (bi1_val * bi2_val) + res_val + mcarry;
				//ulong val = ((ulong)([bi1 getDataAtIndex:i] * [bi2 getDataAtIndex:j]) + (ulong)[result getDataAtIndex:k] + mcarry);
				
				[result setData: (uint)(val & 0xFFFFFFFF) atIndex:k];
				mcarry = val >> 32;
#if _BI_DEBUG_
				NSLog(@"mcarry=%qi", mcarry);
#endif
			}
			if (mcarry != 0) {
				[result setData:(uint)mcarry atIndex:(i + bi2.dataLength)];
				
#if _BI_DEBUG_
				NSLog(@"mcarry != 0; mcarry=%qi", mcarry);
#endif
			}
		}
	}
	@catch (NSException *ex) {
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Multiplication overflow." userInfo:nil];
	}
	result.dataLength = self.dataLength + bi2.dataLength;
  
	if (result.dataLength > MAX_LENGTH) {
		result.dataLength = MAX_LENGTH;
	}
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0) {
		result.dataLength--;
	}
	// overflow check (result is -ve)
	if (([result getDataAtIndex:lastPos] & 0x80000000) != 0) {
		if (bi1Neg != bi2Neg && [result getDataAtIndex:lastPos] == 0x80000000)    // different sign
		{
			// handle the special case where multiplication produces
			// a max negative number in 2's complement.
			
			if (result.dataLength == 1) {
				return result;
			}
      else {
				bool isMaxNeg = true;
				for (int i = 0; i < result.dataLength - 1 && isMaxNeg; i++) {
					if ([result getDataAtIndex:i] != 0)
						isMaxNeg = false;
				}
				
				if (isMaxNeg) {
					return result;
				}
			}
		}
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"overflow." userInfo:nil];
	}
	// if input has different signs, then result is -ve
	if (bi1Neg != bi2Neg)
		result = [result negate];
	
	return result;
}

- (BigInt *)negate; {
#if _BI_DEBUG_
	NSLog(@"negagte");
#endif
	
	if (self.dataLength == 1 && [self getDataAtIndex:0] == 0)
		return [BigInt create];
  
	BigInt * result = [BigInt createFromBigInt:self];
	
	// 1's complement
	for (int i = 0; i < MAX_LENGTH; i++)
		[result setData: (uint)(~([self getDataAtIndex:i])) atIndex: i];
	
	// add one to result of 1's complement
	ulong val, carry = 1;
	int index = 0;
	
	while (carry != 0 && index < MAX_LENGTH) {
		val = (long long)([result getDataAtIndex:index]);
		val++;
		
		[result setData:(uint)(val & 0xFFFFFFFF) atIndex: index];
		carry = val >> 32;
		
		index++;
	}
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) == ([result getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000))
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Overflow in negation." userInfo:nil];
	
	result.dataLength = MAX_LENGTH;
	
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	return result;
}

- (BigInt *)divide:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"divide");
#endif
	
	BigInt *quotient = [BigInt createFromLong:0];
	BigInt *remainder = [BigInt createFromLong:0];
	BigInt *bi1 = [BigInt createFromBigInt:self];
	
	int lastPos = MAX_LENGTH - 1;
	bool divisorNeg = false, dividendNeg = false;
	
	if (([bi1 getDataAtIndex:lastPos] & 0x80000000) != 0)     // bi1 negative
	{
		bi1 = [bi1 negate];
		dividendNeg = true;
	}
	if (([bi2 getDataAtIndex:lastPos] & 0x80000000) != 0)     // bi2 negative
	{
		bi2 = [bi2 negate];
		divisorNeg = true;
	}
	if ([bi1 lessThan: bi2]) {
		//return quotient;
	} else {
		if (bi2.dataLength == 1)
			[BigInt singleByteDivide:bi1 bi2:bi2 outQuotient:quotient outRemainder:remainder];
		else
			[BigInt multiByteDivide:bi1 bi2:bi2 outQuotient:quotient outRemainder:remainder];
		
		if (dividendNeg != divisorNeg)
			quotient = [quotient negate];
	}
	return quotient;
}

+ (BigInt *)factorial:(uint)aNumber; {
  if(aNumber <= 1){
    return [BigInt createFromInt:1];
  }
  else if(aNumber > 500){
    NSLog(@"%d is too large to compute the factorial!", aNumber);
    return nil;
  }
  else{
    BigInt * number = [BigInt createFromInt:aNumber];
    return [number multiply:[self factorial:(aNumber - 1)]];
  }
}

+ (BigInt *)n:(uint)aN chooseR:(uint)aR; {
  BigInt * numerator = [BigInt factorial:aN];
  BigInt * denominator1 = [BigInt factorial:aR];
  BigInt * denominator2 = [BigInt factorial:(aN - aR)];
  BigInt * denominator = [denominator1 multiply:denominator2];
  return [numerator divide:denominator];
}

- (BigInt *)not; {
#if _BI_DEBUG_
	NSLog(@"not");
#endif
	
	BigInt * result = [[BigInt alloc] initWithBigInt:self];
	
	for (int i = 0; i < MAX_LENGTH; i++)
		[result setData:(uint)(~([self getDataAtIndex:i])) atIndex:i];
	
	result.dataLength = MAX_LENGTH;
	
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	return result;
}

- (BigInt *)shiftLeft:(int)shiftVal; {
#if _BI_DEBUG_
	NSLog(@"shiftLeft");
#endif
	
	BigInt * result = [[BigInt alloc] initWithBigInt:self];
	/*
   uint tmp[MAX_LENGTH];
   bzero(tmp, sizeof(tmp));
   
   for(int i = 0; i < result.dataLength; i++) {
   tmp[i] = [result getDataAtIndex:i];
   }
	 */
	
	result.dataLength = [BigInt shiftLeft:[result getData] withSizeOf:result.dataLength bits:shiftVal];
	
	/*
   for(int i = 0; i < result.dataLength; i++) {
   [result setData: tmp[i] atIndex: i];
   }
	 */
	return result;
}

- (BigInt *)shiftRight:(int)shiftVal; {
#if _BI_DEBUG_
	NSLog(@"shiftRight");
#endif
	
	BigInt * result = [[BigInt alloc] initWithBigInt:self];
	result.dataLength = [BigInt shiftRight:[result getData] withSizeOf:result.dataLength bits:shiftVal];
	return result;
}

- (BOOL)equals:(BigInt *)bi; {
#if _BI_DEBUG_
	NSLog(@"equals");
#endif
	
	if (self.dataLength != bi.dataLength)
		return false;
	
	for (int i = 0; i < self.dataLength; i++) {
		if ([self getDataAtIndex:i] != [bi getDataAtIndex:i])
			return false;
	}
	return true;
}

- (BOOL)greaterThan:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"greaterThan");
#endif
	
	int pos = MAX_LENGTH - 1;
	
	// bi1 is negative, bi2 is positive
	if (([self getDataAtIndex:pos] & 0x80000000) != 0 && ([bi2 getDataAtIndex:pos] & 0x80000000) == 0)
		return false;
	
	// bi1 is positive, bi2 is negative
	else if (([self getDataAtIndex:pos] & 0x80000000) == 0 && ([bi2 getDataAtIndex:pos] & 0x80000000) != 0)
		return true;
	
	// same sign
	int len = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	for (pos = len - 1; pos >= 0 && [self getDataAtIndex:pos] == [bi2 getDataAtIndex:pos]; pos--) ;
	
	if (pos >= 0) {
		if ([self getDataAtIndex:pos] > [bi2 getDataAtIndex:pos])
			return true;
		return false;
	}
	return false;
}

- (BOOL)lessThan:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"lessThan");
#endif
	
	int pos = MAX_LENGTH - 1;
	
	// bi1 is negative, bi2 is positive
	if (([self getDataAtIndex:pos] & 0x80000000) != 0 && ([bi2 getDataAtIndex:pos] & 0x80000000) == 0)
		return true;
	
	// bi1 is positive, bi2 is negative
	else if (([self getDataAtIndex:pos] & 0x80000000) == 0 && ([bi2 getDataAtIndex:pos] & 0x80000000) != 0)
		return false;
	
	// same sign
	int len = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	for (pos = len - 1; pos >= 0 && [self getDataAtIndex:pos] == [bi2 getDataAtIndex:pos]; pos--) ;
	
	if (pos >= 0) {
		if ([self getDataAtIndex:pos] < [bi2 getDataAtIndex:pos])
			return true;
		return false;
	}
	return false;
}

- (BOOL)lessThanOrEqualTo:(BigInt *)bi2; {
	return ([self lessThan:bi2] || [self equals:bi2]);
}

- (BOOL)greaterThanOrEqualTo:(BigInt *)bi2; {
	return ([self greaterThan:bi2] || [self equals:bi2]);
}

- (uint)numberOfDigitsWithRadix:(uint)aRadix; {
  if(aRadix < 2){
    @throw [NSException exceptionWithName:@"ArgumentException" reason:@"Radix must be >= 2" userInfo:nil];
  }
  uint numberOfDigits = 1;
  
  BigInt * bigIntRadix = [BigInt createFromLong:aRadix];
  BigInt * originalNumber = [BigInt createFromBigInt:self];
  BigInt * quotient = [BigInt create];
	BigInt * remainder = [BigInt create];
  
  while(originalNumber.dataLength > 1 || (originalNumber.dataLength == 1 && [originalNumber getDataAtIndex:0] != 0)){
    [BigInt singleByteDivide:originalNumber bi2:bigIntRadix outQuotient:quotient outRemainder:remainder];
    originalNumber = quotient;
    numberOfDigits++;
  }
  return numberOfDigits;
}

//***********************************************************************
// Returns the absolute value
//***********************************************************************

- (BigInt *)abs; {
#if _BI_DEBUG_
	NSLog(@"abs");
#endif
	
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)
		return ([self negate]);
	else
		return [BigInt createFromBigInt:self];
}

- (BigInt *)sqrt; {
#if _BI_DEBUG_
	NSLog(@"sqrt");
#endif
	uint numBits = (uint)[self bitCount];
	
	if ((numBits & 0x1) != 0)        // odd number of bits
		numBits = (numBits >> 1) + 1;
	else
		numBits = (numBits >> 1);
	
	uint bytePos = numBits >> 5;
	int bitPos = (int)(numBits & 0x1F);
	uint mask = 0;
	BigInt * result = [BigInt create];
  
	if (bitPos == 0)
		mask = 0x80000000;
	else {
		mask = (uint)1 << bitPos;
		bytePos++;
	}
	result.dataLength = (int)bytePos;
	
	for (int i = (int)bytePos - 1; i >= 0; i--) {
		while (mask != 0) {
			// guess
			[result setData:([result getDataAtIndex:i] ^ mask) atIndex:i];
			
			// undo the guess if its square is larger than this
			if ([[result multiply: result] greaterThan: self])
				[result setData:([result getDataAtIndex:i] ^ mask) atIndex:i];
			
			mask >>= 1;
		}
		mask = 0x80000000;
	}
	return result;
}

- (BigInt *)gcd:(BigInt *)bi; {
#if _BI_DEBUG_
	NSLog(@"gcd");
#endif
  
	BigInt * x;
	BigInt * y;
	
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)     // negative
		x = [self negate];
	else
		x = [BigInt createFromBigInt:self];
	
	if (([bi getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)     // negative
		y = [bi negate];
	else
		y = [BigInt createFromBigInt:bi];
	
	BigInt * g = y;
	
	while (x.dataLength > 1 || (x.dataLength == 1 && [x getDataAtIndex:0] != 0)) {
		g = x;
		x = [y mod: x];
		y = g;
	}
	return g;
}

//***********************************************************************
// Returns a string representing the BigInt in sign-and-magnitude
// format in the specified radix.
//
// Example
// -------
// If the value of BigInt is -255 in base 10, then
// [self toStringWithRadix:16] returns "-FF"
//
//***********************************************************************

- (NSString *)toStringWithRadix:(int)radix; {
#if _BI_DEBUG_
	NSLog(@"toStringWithRadix");
#endif
	
	if (radix < 2 || radix > 36)
		@throw [NSException exceptionWithName:@"ArgumentException" reason:@"Radix must be >= 2 and <= 36" userInfo:nil];
	
	NSString * charSet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init];
	BigInt * a = self;
	bool negative = false;
  
	if (([a getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0) {
		negative = true;
		@try {
			a = [a negate];
		}
		@catch (NSException *ex) { }
	}
	BigInt *quotient = [BigInt create];
	BigInt *remainder = [BigInt create];
	BigInt *biRadix = [BigInt createFromLong:radix];
	
	if (a.dataLength == 1 && [a getDataAtIndex:0] == 0)
		[result appendString:@"0"];
	else {
		while (a.dataLength > 1 || (a.dataLength == 1 && [a getDataAtIndex:0] != 0)) {
			[BigInt singleByteDivide:a bi2:biRadix outQuotient:quotient outRemainder:remainder];
			
			if ([remainder getDataAtIndex:0] < 10) {
				[result insertString:[NSString stringWithFormat:@"%d", [remainder getDataAtIndex:0]] atIndex:0];
			} else {
				//NSLog(@"Value = %d", ([remainder getDataAtIndex:0] - 10));
				[result insertString:[NSString stringWithFormat:@"%c", [charSet characterAtIndex:([remainder getDataAtIndex:0] - 10)]] atIndex:0];
			}
			
			a = quotient;
		}
		if (negative)
			[result insertString:@"-" atIndex:0];
	}
	NSString * sOut = [result copy];
	return sOut;
}

+ (int)shiftLeft:(uint *)buffer withSizeOf:(int)bufferSize bits:(int)shiftVal; {
#if _BI_DEBUG_
	NSLog(@"shiftLeft");
  
	for(int i = 0; i < bufferSize; i++)
		NSLog(@"buffer[%d] = %ld", i, buffer[i]);
#endif
	
	int shiftAmount = 32;
	int bufLen = bufferSize;
	
	while (bufLen > 1 && buffer[bufLen - 1] == 0)
		bufLen--;
	
	for (int count = shiftVal; count > 0; ) {
		if (count < shiftAmount)
			shiftAmount = count;
		
		//Console.WriteLine("shiftAmount = {0}", shiftAmount);
		
		ulong carry = 0;
		for (int i = 0; i < bufLen; i++) {
			ulong val = ((ulong)buffer[i]) << shiftAmount;
			val |= carry;
			
			buffer[i] = (uint)(val & 0xFFFFFFFF);
			carry = val >> 32;
		}
		if (carry != 0) {
			if (bufLen + 1 <= bufferSize) {
				buffer[bufLen] = (uint)carry;
				bufLen++;
			}
		}
		count -= shiftAmount;
	}
	return bufLen;
}

+ (int)shiftRight:(uint *)buffer withSizeOf:(int)bufferSize bits:(int)shiftVal; {
#if _BI_DEBUG_
	NSLog(@"shiftRight");
#endif
	
	int shiftAmount = 32;
	int invShift = 0;
	int bufLen = bufferSize;
	
	while (bufLen > 1 && buffer[bufLen - 1] == 0)
		bufLen--;
	
	for (int count = shiftVal; count > 0; ) {
		if (count < shiftAmount) {
			shiftAmount = count;
			invShift = 32 - shiftAmount;
		}
		ulong carry = 0;
		for (int i = bufLen - 1; i >= 0; i--) {
			ulong val = ((ulong)buffer[i]) >> shiftAmount;
			val |= carry;
			
			carry = ((ulong)buffer[i]) << invShift;
			buffer[i] = (uint)(val);
		}
		count -= shiftAmount;
	}
	while (bufLen > 1 && buffer[bufLen - 1] == 0)
		bufLen--;
	
	return bufLen;
}

+ (void)singleByteDivide:(BigInt *)bi1 bi2:(BigInt *)bi2 outQuotient:(BigInt *)outQuotient outRemainder:(BigInt *)outRemainder; {
#if _BI_DEBUG_
	NSLog(@"singleByteDivide");
#endif
	
	uint result[MAX_LENGTH];
	int resultPos = 0;
	
	// copy dividend to reminder
	for (int i = 0; i < MAX_LENGTH; i++)
		[outRemainder setData:[bi1 getDataAtIndex:i] atIndex: i];
	(outRemainder).dataLength = bi1.dataLength;
	
	while ((outRemainder).dataLength > 1 && [outRemainder getDataAtIndex:((outRemainder).dataLength - 1)] == 0)
		(outRemainder).dataLength--;
	
	ulong divisor = (ulong)[bi2 getDataAtIndex:0];
	int pos = (outRemainder).dataLength - 1;
	ulong dividend = (ulong)[outRemainder getDataAtIndex:pos];
	
	//NSLog(@"divisor = %d dividend = %d", divisor, dividend);
	
	if (dividend >= divisor) {
		ulong quotient = dividend / divisor;
		result[resultPos++] = (uint)quotient;
		[outRemainder setData:(uint)(dividend % divisor) atIndex:pos];
	}
	pos--;
	
	while (pos >= 0) {
		dividend = ((ulong)[outRemainder getDataAtIndex:pos + 1] << 32) + (ulong)[outRemainder getDataAtIndex:pos];
		ulong quotient = dividend / divisor;
		result[resultPos++] = (uint)quotient;
		
		[outRemainder setData:0 atIndex:pos + 1];
		[outRemainder setData:(uint)(dividend % divisor) atIndex:pos--];
	}
	(*outQuotient).dataLength = resultPos;
	int j = 0;
	for (int i =(*outQuotient).dataLength - 1; i >= 0; i--, j++)
		[outQuotient setData:result[i] atIndex:j];
	
	for (; j < MAX_LENGTH; j++)
		[outQuotient setData:0 atIndex:j];
	
	while ((outQuotient).dataLength > 1 && [outQuotient getDataAtIndex:(outQuotient).dataLength - 1] == 0)
		(outQuotient).dataLength--;
	
	if ((outQuotient).dataLength == 0)
		(outQuotient).dataLength = 1;
	
	while ((outRemainder).dataLength > 1 && [outRemainder getDataAtIndex:(outRemainder).dataLength - 1] == 0)
		(outRemainder).dataLength--;
}

+ (void)multiByteDivide:(BigInt *)bi1 bi2:(BigInt *)bi2 outQuotient:(BigInt *)outQuotient outRemainder:(BigInt *)outRemainder; {
#if _BI_DEBUG_
	NSLog(@"multiByteDivide");
#endif
	uint result[MAX_LENGTH];
	bzero(result, sizeof(result));
	
	int remainderLen = bi1.dataLength + 1;
	uint remainder[remainderLen];
	bzero(remainder, sizeof(remainder));
	
	uint mask = 0x80000000;
	uint val = [bi2 getDataAtIndex:(bi2.dataLength - 1)];
	int shift = 0, resultPos = 0;
	
	while (mask != 0 && (val & mask) == 0) {
		shift++; mask >>= 1;
	}
	for (int i = 0; i < bi1.dataLength; i++)
		remainder[i] = [bi1 getDataAtIndex:i];
	
#if _BI_DEBUG_
	for(int i = 0; i < remainderLen; i++)
		NSLog(@"before: remainder[%d] = %u", i, remainder[i]);
#endif
	
	[BigInt shiftLeft:(uint *)&remainder withSizeOf:remainderLen bits:shift];
	
#if _BI_DEBUG_
	for(int i = 0; i < remainderLen; i++)
		NSLog(@"after: remainder[%d] = %u", i, remainder[i]);
#endif
	
	bi2 = [bi2 shiftLeft: shift];
	
	int j = remainderLen - bi2.dataLength;
	int pos = remainderLen - 1;
	
	ulong firstDivisorByte = [bi2 getDataAtIndex:(bi2.dataLength - 1)];
	ulong secondDivisorByte = [bi2 getDataAtIndex:(bi2.dataLength - 2)];
	
	int divisorLen = bi2.dataLength + 1;
	uint dividendPart[divisorLen];
	bzero(dividendPart, sizeof(dividendPart));
	
	while (j > 0) {
		ulong dividend = ((ulong)remainder[pos] << 32) + (ulong)remainder[pos - 1];
		
		ulong q_hat = dividend / firstDivisorByte;
		ulong r_hat = dividend % firstDivisorByte;
		
		bool done = false;
		while (!done) {
			done = true;
			
			if (q_hat == 0x10000000 ||
          (q_hat * secondDivisorByte) > ((r_hat << 32) + (ulong)remainder[pos - 2])) {
				q_hat--;
				r_hat += firstDivisorByte;
				
				if (r_hat < 0x10000000)
					done = false;
			}
		}
		for (int h = 0; h < divisorLen; h++) {
#if _BI_DEBUG_
			NSLog(@"dividendPart[%d] = %u", h, remainder[pos - h]);
#endif
			dividendPart[h] = remainder[pos - h];
		}
		
#if _BI_DEBUG_
		NSLog(@"q_hat = %qi", q_hat);
#endif
		
		BigInt * kk = [[BigInt alloc] initWithUIntArray:dividendPart withSize:divisorLen];
		BigInt * ss = [bi2 multiply:[BigInt createFromULong:(ulong)q_hat]];
		
		while ([ss greaterThan: kk]) {
			q_hat--;
			
			/*
       BigInt *tmp = [ss divide: bi2];
       if([tmp getDataAtIndex:0] == 0) {
       tmp = [tmp add:[BigInt createFromInt:1]];
       }
       
       ss = [ss subtract:[bi2 multiply:tmp]];
       */
			ss = [ss subtract:bi2];
		}
		BigInt * yy = [kk subtract:ss];
		
		for (int h = 0; h < divisorLen; h++) {
			remainder[pos - h] = [yy getDataAtIndex:(bi2.dataLength - h)];
		}
#if _BI_DEBUG_
		for(int i = 0; i < remainderLen; i++) {
			NSLog(@"remainder[%d] = %u", i, remainder[i]);
		}
#endif
		result[resultPos++] = (uint)q_hat;
		pos--;
		j--;
	}
	outQuotient.dataLength = resultPos;
	int y = 0;
	
	for (int x = outQuotient.dataLength - 1; x >= 0; x--, y++) {
		[outQuotient setData:result[x] atIndex:y];
	}
	for (; y < MAX_LENGTH; y++) {
		[outQuotient setData:0 atIndex:y];
	}
	while (outQuotient.dataLength > 1 && [outQuotient getDataAtIndex:(outQuotient.dataLength - 1)] == 0) {
		outQuotient.dataLength--;
	}
	if (outQuotient.dataLength == 0) {
		outQuotient.dataLength = 1;
	}
	outRemainder.dataLength = [BigInt shiftRight:remainder withSizeOf:remainderLen bits:shift];
	
	for (y = 0; y < outRemainder.dataLength; y++) {
		[outRemainder setData:remainder[y] atIndex:y];
	}
	for (; y < MAX_LENGTH; y++) {
		[outRemainder setData:0 atIndex:y];
	}
}

//***********************************************************************
// Modulo
//***********************************************************************

- (BigInt *)mod:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"mod");
#endif
	
	BigInt * quotient = [BigInt create];
	BigInt * remainder =	[BigInt createFromBigInt:self];
	BigInt * bi1 = [BigInt createFromBigInt:self];
	
	int lastPos = MAX_LENGTH - 1;
	bool dividendNeg = false;
	
	if (([bi1 getDataAtIndex:lastPos] & 0x80000000) != 0)     // bi1 negative
	{
		bi1 = [bi1 negate];
		dividendNeg = true;
	}
	if (([bi2 getDataAtIndex:lastPos] & 0x80000000) != 0)     // bi2 negative
		bi2 = [bi2 negate];
	
	if ([bi1 lessThan: bi2]) {
		//return remainder;
	}
  else {
		if (bi2.dataLength == 1)
			[BigInt singleByteDivide:bi1 bi2:bi2 outQuotient:quotient outRemainder:remainder];
		else
			[BigInt multiByteDivide:bi1 bi2:bi2 outQuotient:quotient outRemainder:remainder];
		if (dividendNeg)
			remainder = [remainder negate];
	}
	return remainder;
}

//***********************************************************************
// bitwise AND
//***********************************************************************

- (BigInt *)and:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"and");
#endif
	
	BigInt * result = [BigInt createFromLong:0];
	int len = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	
	for (int i = 0; i < len; i++) {
		uint sum = (uint)([self getDataAtIndex:i] & [bi2 getDataAtIndex:i]);
		[result setData:sum atIndex:i];
	}
	result.dataLength = MAX_LENGTH;
	
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	return result;
}

//***********************************************************************
// bitwise OR
//***********************************************************************

- (BigInt *)or:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"or");
#endif
	
	BigInt * result = [BigInt createFromLong:0];
	int len = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	
	for (int i = 0; i < len; i++) {
		uint sum = (uint)([self getDataAtIndex:i] | [bi2 getDataAtIndex:i]);
		[result setData:sum atIndex:i];
	}
	result.dataLength = MAX_LENGTH;
	
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	return result;
}

//***********************************************************************
// bitwise XOR
//***********************************************************************

- (BigInt *)xOr:(BigInt *)bi2; {
#if _BI_DEBUG_
	NSLog(@"xOr");
#endif
	
	BigInt * result = [BigInt createFromLong:0];
	int len = (self.dataLength > bi2.dataLength) ? self.dataLength : bi2.dataLength;
	
	for (int i = 0; i < len; i++) {
		uint sum = (uint)([self getDataAtIndex:i] ^ [bi2 getDataAtIndex:i]);
		[result setData:sum atIndex:i];
	}
	result.dataLength = MAX_LENGTH;
	
	while (result.dataLength > 1 && [result getDataAtIndex:(result.dataLength - 1)] == 0)
		result.dataLength--;
	
	return result;
}

//***********************************************************************
// Returns the position of the most significant bit in the BigInt.
//
// Eg.  The result is 0, if the value of BigInt is 0...0000 0000
//      The result is 1, if the value of BigInt is 0...0000 0001
//      The result is 2, if the value of BigInt is 0...0000 0010
//      The result is 2, if the value of BigInt is 0...0000 0011
//
//***********************************************************************

- (int)bitCount; {
#if _BI_DEBUG_
	NSLog(@"bitCount");
#endif
	
	while (self.dataLength > 1 && [self getDataAtIndex:(self.dataLength - 1)] == 0)
		self.dataLength--;
	
	uint value = [self getDataAtIndex:(self.dataLength - 1)];
	uint mask = 0x80000000;
	int bits = 32;
	
	while (bits > 0 && (value & mask) == 0) {
		bits--;
		mask >>= 1;
	}
	bits += ((self.dataLength - 1) << 5);
	return bits;
}

//***********************************************************************
// Modulo Exponentiation
//***********************************************************************

- (BigInt *)modPow:(BigInt *)exp withMod:(BigInt *)mod; {
#if _BI_DEBUG_
	NSLog(@"modPow");
#endif
	
	if (([exp getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Positive exponents only." userInfo:nil];
	
	BigInt * resultNum = [BigInt createFromLong:1];
	BigInt * tempNum;
	bool thisNegative = false;
	
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)   // negative this
	{
		tempNum = [[self negate] mod: mod];
		thisNegative = true;
	}
	else
		tempNum = [self mod: mod];  // ensures (tempNum * tempNum) < b^(2k)
	
	if (([mod getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)   // negative n
		mod = [mod negate];
	
	// calculate constant = b^(2k) / m
	BigInt * constant = [BigInt create];
	
	int i = mod.dataLength << 1;
	[constant setData:0x00000001 atIndex:i];
	constant.dataLength = i + 1;
	
	constant = [constant divide: mod];
	int totalBits = [exp bitCount];
	int count = 0;
	
	// perform squaring and multiply exponentiation
	for (int pos = 0; pos < exp.dataLength; pos++) {
		uint mask = 0x01;
		//NSLog(@"Pos = %d of %d", pos, exp.dataLength);
		
		for (int index = 0; index < 32; index++) {
			
			//NSLog(@"Pos = %d; Index = %d", pos, index);
			
			if (([exp getDataAtIndex:pos] & mask) != 0)
				resultNum = [BigInt barrettReduction:[resultNum multiply: tempNum] andN:mod andConstant:constant];
			
			mask <<= 1;
			tempNum = [BigInt barrettReduction:[tempNum multiply:tempNum] andN:mod andConstant:constant];
			
			if (tempNum.dataLength == 1 && [tempNum getDataAtIndex:0] == 1) {
				if (thisNegative && ([exp getDataAtIndex:0] & 0x1) != 0)  {   //odd exp
					resultNum = [resultNum negate];
				}
				return resultNum;
			}
			count++;
			if (count == totalBits)
				break;
		}
	}
	if (thisNegative && ([exp getDataAtIndex:0] & 0x1) != 0)    //odd exp
		resultNum = [resultNum negate];
	
	return resultNum;
}

//***********************************************************************
// Fast calculation of modular reduction using Barrett's reduction.
// Requires x < b^(2k), where b is the base.  In this case, base is
// 2^32 (uint).
//
// Reference [4]
//***********************************************************************

+ (BigInt *)barrettReduction:(BigInt *)x andN:(BigInt *)n andConstant:(BigInt *)constant; {
#if _BI_DEBUG_
	NSLog(@"barrettReduction: x:%@ n:%@ c:%@", [x toStringWithRadix:10], [n toStringWithRadix:10], [constant toStringWithRadix:10]);
#endif
  
	int k = n.dataLength;
	int kPlusOne = k + 1;
	int kMinusOne = k - 1;
	BigInt * q1 = [BigInt create];
	
	// q1 = x / b^(k-1)
	for (int i = kMinusOne, j = 0; i < x.dataLength; i++, j++) {
		[q1 setData:[x getDataAtIndex:i] atIndex:j];
	}
	q1.dataLength = x.dataLength - kMinusOne;
  
	if (q1.dataLength <= 0) {
		q1.dataLength = 1;
	}
	BigInt * q2 = [q1 multiply: constant];
	BigInt * q3 = [BigInt create];
	
	// q3 = q2 / b^(k+1)
	for (int i = kPlusOne, j = 0; i < q2.dataLength; i++, j++) {
		[q3 setData:[q2 getDataAtIndex:i] atIndex:j];
	}
	q3.dataLength = q2.dataLength - kPlusOne;
  
	if (q3.dataLength <= 0) {
		q3.dataLength = 1;
	}
	// r1 = x mod b^(k+1)
	// i.e. keep the lowest (k+1) words
	BigInt * r1 = [BigInt create];
	int lengthToCopy = (x.dataLength > kPlusOne) ? kPlusOne : x.dataLength;
  
	for (int i = 0; i < lengthToCopy; i++)
		[r1 setData:[x getDataAtIndex:i] atIndex:i];
	
	r1.dataLength = lengthToCopy;
	
	// r2 = (q3 * n) mod b^(k+1)
	// partial multiplication of q3 and n
	
	BigInt * r2 = [BigInt create];
  
	for (int i = 0; i < q3.dataLength; i++) {
		if ([q3 getDataAtIndex:i] == 0) continue;
		
		ulong mcarry = 0;
		int t = i;
		for (int j = 0; j < n.dataLength && t < kPlusOne; j++, t++) {
			// t = i + j
			ulong val = ((ulong)[q3 getDataAtIndex:i] * (ulong)[n getDataAtIndex:j]) + (ulong)[r2 getDataAtIndex:t] + mcarry;
			
			[r2 setData:(uint)(val & 0xFFFFFFFF) atIndex:t];
			mcarry = (val >> 32);
		}
		if (t < kPlusOne) {
			[r2 setData:(uint)mcarry atIndex:t];
		}
	}
	r2.dataLength = kPlusOne;
  
	while (r2.dataLength > 1 && [r2 getDataAtIndex:(r2.dataLength - 1)] == 0) {
		r2.dataLength--;
	}
	r1 = [r1 subtract:r2];
	
	if (([r1 getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)        // negative
	{
		BigInt *val = [BigInt create];
		[val setData:0x00000001 atIndex:kPlusOne];
		val.dataLength = kPlusOne + 1;
		r1 = [r1 add: val];
	}
	
#if _BI_DEBUG_
	long cnt = 0;
	
	NSLog(@"r1=%@; n=%@", [r1 toStringWithRadix:10], [n toStringWithRadix:10]);
#endif
	
	while ([r1 greaterThanOrEqualTo:n]) {
#if _BI_DEBUG_
		NSLog(@"loop count %ld", ++cnt);
#endif
		r1 = [r1 subtract:n];
		/*BigInt *tmp = [r1 divide:n];
     if([tmp getDataAtIndex:0] == 0)
     tmp = [tmp add:[BigInt createFromInt:1]];
     r1 = [r1 subtract:[n multiply:tmp]];*/
	}
	return r1;
}

//***********************************************************************
// Populates "this" with the specified amount of random bits
//***********************************************************************

- (void)getRandomBits:(int)bits; {
#if _BI_DEBUG_
	NSLog(@"getRandomBits");
#endif
	
	int dwords = bits >> 5;
	int remBits = bits & 0x1F;
	
	if (remBits != 0)
		dwords++;
	
	if (dwords > MAX_LENGTH)
		@throw [NSException exceptionWithName:@"ArithmeticException" reason:@"Number of required bits > maxLength." userInfo:nil];
	
	for (int i = 0; i < dwords; i++) {
		double d1 = ((double)(1 + arc4random())) / (double)10000000000;
		data[i] = (uint)((long long)(d1 * 0x100000000) & 0xFFFFFFFF);
	}
	for (int i = dwords; i < MAX_LENGTH; i++)
		data[i] = 0;
	
	if (remBits != 0) {
		uint mask = (uint)(0x01 << (remBits - 1));
		data[dwords - 1] |= mask;
		
		mask = (uint)(0xFFFFFFFF >> (32 - remBits));
		data[dwords - 1] &= mask;
	}
	else
		data[dwords - 1] |= 0x80000000;
	
	self.dataLength = dwords;
	
	if (dataLength == 0)
		dataLength = 1;
}

//***********************************************************************
// Returns the lowest 4 bytes of the BigInt as an int.
//***********************************************************************

- (int)intValue; {
	return (int)data[0];
}

//***********************************************************************
// Determines whether a number is probably prime, using the Rabin-Miller's
// test.  Before applying the test, the number is tested for divisibility
// by primes < 2000
//
// Returns true if number is probably prime.
//***********************************************************************

- (BOOL)isProbablePrimeWithConfidence:(int)confidence; {
#if _BI_DEBUG_
	NSLog(@"isProbablePrimeWithConfidence");
#endif
	
	BigInt * thisVal;
  
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)        // negative
		thisVal = [self negate];
	else
		thisVal = self;
	
	// test for divisibility by primes < 2000
	for (int p = 0; p < (sizeof(primesBelow2000) / sizeof(int)); p++) {
		BigInt *divisor = [BigInt createFromLong:primesBelow2000[p]];
		
#if _BI_DEBUG_
		NSLog(@"Testing prime[%d]", p);
#endif
		
		if ([divisor greaterThanOrEqualTo: thisVal])
			break;
		
		BigInt *resultNum = [thisVal mod: divisor];
		if ([resultNum intValue] == 0) {
			return false;
		}
	}
	BOOL result = FALSE;
	
	if ([thisVal rabinMillerTestWithConfidence:confidence]) {
		result = true;
	}
  else {
		result = false;
	}
	return result;
}

//***********************************************************************
// Determines whether this BigInteger is probably prime using a
// combination of base 2 strong pseudoprime test and Lucas strong
// pseudoprime test.
//
// The sequence of the primality test is as follows,
//
// 1) Trial divisions are carried out using prime numbers below 2000.
//    if any of the primes divides this BigInteger, then it is not prime.
//
// 2) Perform base 2 strong pseudoprime test.  If this BigInteger is a
//    base 2 strong pseudoprime, proceed on to the next step.
//
// 3) Perform strong Lucas pseudoprime test.
//
// Returns True if this BigInteger is both a base 2 strong pseudoprime
// and a strong Lucas pseudoprime.
//
// For a detailed discussion of this primality test, see [6].
//
//***********************************************************************

- (BOOL)isProbablePrime; {
#if _BI_DEBUG_
	NSLog(@"isProbablePrime");
#endif
	
	BigInt * thisVal;
  
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)        // negative
		thisVal = [self negate];
	else
		thisVal = self;
	
	if (thisVal.dataLength == 1) {
		// test small numbers
		if ([thisVal getDataAtIndex:0] == 0 || [thisVal getDataAtIndex:0] == 1)
			return false;
		else if ([thisVal getDataAtIndex:0] == 2 || [thisVal getDataAtIndex:0] == 3)
			return true;
	}
	if (([thisVal getDataAtIndex:0] & 0x1) == 0)     // even numbers
		return false;
	
	// test for divisibility by primes < 2000
	for (int p = 0; p < (sizeof(primesBelow2000)/sizeof(int)); p++) {
		BigInt * divisor = [BigInt createFromLong:primesBelow2000[p]];
		
		if ([divisor greaterThanOrEqualTo: thisVal])
			break;
		
		BigInt * resultNum = [thisVal  mod: divisor];
    
		if ([resultNum intValue] == 0) {
			//Console.WriteLine("Not prime!  Divisible by {0}\n",
			//                  primesBelow2000[p]);
			return false;
		}
	}
	// Perform BASE 2 Rabin-Miller Test
	
	// calculate values of s and t
	BigInt * p_sub1 = [thisVal subtract:[BigInt createFromLong:1]];
	int s = 0;
	
	for (int index = 0; index < p_sub1.dataLength; index++) {
		uint mask = 0x01;
		
		for (int i = 0; i < 32; i++) {
			if (([p_sub1 getDataAtIndex:index] & mask) != 0) {
				index = p_sub1.dataLength;      // to break the outer loop
				break;
			}
			mask <<= 1;
			s++;
		}
	}
	BigInt * t = [p_sub1 shiftRight:s];
	
	//int bits = [thisVal bitCount];
	BigInt *a = [BigInt createFromLong:2];
	
	// b = a^t mod p
	BigInt * b = [a modPow:t withMod:thisVal];
	bool result = false;
	
	if (b.dataLength == 1 && [b getDataAtIndex:0] == 1)         // a^t mod p = 1
		result = true;
	
	for (int j = 0; result == false && j < s; j++) {
		if ([b equals: p_sub1])         // a^((2^j)*t) mod p = p-1 for some 0 <= j <= s-1
		{
			result = true;
			break;
		}
		
		b = [[b multiply: b] mod: thisVal];
	}
	// if number is strong pseudoprime to base 2, then do a strong lucas test
	if (result)
		result = [BigInt lucasStrongTest:thisVal];
	
	return result;
}

//***********************************************************************
// Generates a positive BigInt that is probably prime.
//***********************************************************************

+ (BigInt *)generatePseudoPrimeWithBits:(int)bits andConfidence:(int)confidence; {
#if _BI_DEBUG_
	NSLog(@"generatePseudoPrimeWithBits");
#endif
	
	BigInt * result = [BigInt create];
	bool done = false;
	
	while (!done) {
		[result getRandomBits: bits];
		[result setData:([result getDataAtIndex:0] | 0x01) atIndex:0];		// make it odd
		
		// prime test
		done = [result isProbablePrimeWithConfidence:confidence];
		
#if _BI_DEBUG_
		NSLog(@"Is Prime: %s (%s)", [[result toStringWithRadix:16] UTF8String], [done ? @"Yes" : @"No" UTF8String]);
#endif
	}
	return result;
}

//***********************************************************************
// Performs the calculation of the kth term in the Lucas Sequence.
// For details of the algorithm, see reference [9].
//
// k must be odd.  i.e LSB == 1
//***********************************************************************

+ (NSMutableArray *)lucasSequence:(BigInt *)P andQ:(BigInt *)Q andk:(BigInt *)k andn:(BigInt *)n andConstant:(BigInt *)constant ands:(int)s; {
	
#if _BI_DEBUG_
	NSLog(@"lucasSequence: P:%@ Q:%@ k:%@ n:%@ constant:%@ s:%d",
        [P toStringWithRadix:10],
        [Q toStringWithRadix:10],
        [k toStringWithRadix:10],
        [n toStringWithRadix:10],
        [constant toStringWithRadix:10],
        s);
#endif
	NSMutableArray * aRet = nil;
	
	BigInt * result[3];
	
	result[0] = [BigInt create];
	result[1] = [BigInt create];
	result[2] = [BigInt create];
	
	if (([k getDataAtIndex:0] & 0x00000001) == 0)
		@throw [NSException exceptionWithName:@"ArgumentException" reason:@"Argument k must be odd." userInfo:nil];
	
	int numbits = [k bitCount];
	uint mask = (uint)0x1 << ((numbits & 0x1F) - 1);
	
	// v = v0, v1 = v1, u1 = u1, Q_k = Q^0
	
	BigInt *v = [[BigInt createFromLong:2] mod: n];
	BigInt *Q_k = [[BigInt createFromLong:1] mod: n];
	BigInt *v1 = [P mod: n];
	BigInt *u1 = [BigInt createFromBigInt:Q_k];
	
	bool flag = true;
	
	for (int i = k.dataLength - 1; i >= 0; i--)     // iterate on the binary expansion of k
	{
		//Console.WriteLine("round");
		while (mask != 0) {
			if (i == 0 && mask == 0x00000001)        // last bit
				break;
			
			if (([k getDataAtIndex:i] & mask) != 0)             // bit is set
			{
				// index doubling with addition
				
				u1 = [[u1 multiply: v1] mod: n];
				
				v = [[[v multiply: v1] subtract: [P multiply: Q_k]] mod: n];
        
				v1 = [BigInt barrettReduction:[v1 multiply:v1] andN:n andConstant:constant];
				//v1 = [n barrettReduction: [v1 multiply: v1] , n, constant);
				
				v1 = [[v1 subtract:[[Q_k multiply:Q] shiftLeft:1]] mod:n];
				//v1 = (v1 - ((Q_k * Q) << 1)) % n;
				
				if (flag)
					flag = false;
				else
					Q_k = [BigInt barrettReduction:[Q_k multiply: Q_k] andN:n andConstant:constant];
				
				Q_k = [[Q_k multiply: Q] mod: n];
			}
			else {
				// index doubling
				u1 = [[[u1 multiply: v] subtract: Q_k] mod: n];
				
				v1 = [[[v multiply: v1] subtract: [P multiply: Q_k]] mod: n];
				v = [BigInt barrettReduction:[v multiply: v] andN: n andConstant: constant];
				v = [[v subtract: [Q_k shiftLeft: 1]] mod: n];
				
				if (flag) {
					Q_k = [Q mod: n];
					flag = false;
				}
				else
					Q_k = [BigInt barrettReduction:[Q_k multiply: Q_k] andN: n andConstant: constant];
			}
			mask >>= 1;
		}
		mask = 0x80000000;
	}
	
	// at this point u1 = u(n+1) and v = v(n)
	// since the last bit always 1, we need to transform u1 to u(2n+1) and v to v(2n+1)
	
	u1 = [[[u1 multiply: v] subtract: Q_k] mod: n];
	v = [[[v multiply: v1] subtract: [P multiply: Q_k]] mod: n];
	
	if (flag)
		flag = false;
	else
		Q_k = [BigInt barrettReduction:[Q_k multiply: Q_k] andN: n andConstant: constant];
	
	Q_k = [[Q_k multiply: Q] mod:n];
	
	for (int i = 0; i < s; i++) {
		// index doubling
		u1 = [[u1 multiply: v] mod: n];
		v = [[[v multiply: v] subtract:[Q_k shiftLeft: 1]] mod: n];
		
		if (flag) {
			Q_k = [Q mod: n];
			flag = false;
		}
		else
			Q_k = [BigInt barrettReduction:[Q_k multiply: Q_k] andN: n andConstant: constant];
	}
	result[0] = u1;
	result[1] = v;
	result[2] = Q_k;
	
	aRet = [[NSMutableArray alloc] init];
	[aRet addObject:result[0]];
	[aRet addObject:result[1]];
	[aRet addObject:result[2]];
  
	return aRet;
}

//***********************************************************************
// Implementation of the Lucas Strong Pseudo Prime test.
//
// Let n be an odd number with gcd(n,D) = 1, and n - J(D, n) = 2^s * d
// with d odd and s >= 0.
//
// If Ud mod n = 0 or V2^r*d mod n = 0 for some 0 <= r < s, then n
// is a strong Lucas pseudoprime with parameters (P, Q).  We select
// P and Q based on Selfridge.
//
// Returns True if number is a strong Lucus pseudo prime.
// Otherwise, returns False indicating that number is composite.
//***********************************************************************

+ (BOOL)lucasStrongTest:(BigInt *)thisVal; {
#if _BI_DEBUG_
	NSLog(@"lucasStrongTest");
#endif
	
	// Do the test (selects D based on Selfridge)
	// Let D be the first element of the sequence
	// 5, -7, 9, -11, 13, ... for which J(D,n) = -1
	// Let P = 1, Q = (1-D) / 4
	
	if (([thisVal getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)        // negative
		thisVal = [thisVal negate];
	
	if (thisVal.dataLength == 1) {
		// test small numbers
		if ([thisVal getDataAtIndex:0] == 0 || [thisVal getDataAtIndex:0] == 1)
			return false;
		else if ([thisVal getDataAtIndex:0] == 2 || [thisVal getDataAtIndex:0] == 3)
			return true;
	}
	if (([thisVal getDataAtIndex:0] & 0x1) == 0)     // even numbers
		return false;
	
	long D = 5, sign = -1, dCount = 0;
	bool done = false;
	
	while (!done) {
		int Jresult = [BigInt jacobi:[BigInt createFromLong:D] andB:thisVal];
		
		if (Jresult == -1)
			done = true;    // J(D, this) = 1
		else {
			if (Jresult == 0 && [[BigInt createFromLong:(long)abs(D)] lessThan: thisVal])       // divisor found
				return false;
			
			if (dCount == 20) {
				// check for square
				BigInt *root = [thisVal sqrt];
				if ([[root multiply: root] equals: thisVal])
					return false;
			}
			//Console.WriteLine(D);
			D = ((long)abs(D) + 2) * sign;
			sign = -sign;
		}
		dCount++;
	}
	long Q = (1 - D) >> 2;
	BigInt * p_add1 = [thisVal add:[BigInt createFromLong: 1]];
	int s = 0;
	
	for (int index = 0; index < p_add1.dataLength; index++) {
		uint mask = 0x01;
		
		for (int i = 0; i < 32; i++) {
			if (([p_add1 getDataAtIndex:index] & mask) != 0) {
				index = p_add1.dataLength;      // to break the outer loop
				break;
			}
			mask <<= 1;
			s++;
		}
	}
	BigInt * t = [p_add1 shiftRight: s];
	
	// calculate constant = b^(2k) / m
	// for Barrett Reduction
	BigInt * constant = [BigInt create];
	
	int nLen = thisVal.dataLength << 1;
	[constant setData:0x00000001 atIndex:nLen];
	constant.dataLength = nLen + 1;
	constant = [constant divide: thisVal];
	
	NSMutableArray *aLucus = [BigInt lucasSequence:[BigInt createFromLong:1] andQ:[BigInt createFromLong:Q] andk:t andn:thisVal andConstant:constant ands:0];
	BigInt * lucas[3];
  
  for(int j = 0; j < 3; j++){
    lucas[j] = nil;
  }
	for(int j = 0; j < [aLucus count] && j < 3; j++)
		lucas[j] = [aLucus objectAtIndex:j];
	
	bool isPrime = false;
	
	if ((lucas[0].dataLength == 1 && [lucas[0] getDataAtIndex:0] == 0) ||
      (lucas[1].dataLength == 1 && [lucas[1] getDataAtIndex:0] == 0)) {
		// u(t) = 0 or V(t) = 0
		isPrime = true;
	}
	for (int i = 1; i < s; i++) {
		if (!isPrime) {
			// doubling of index
			lucas[1] = [BigInt barrettReduction: [lucas[1] multiply: lucas[1]] andN: thisVal andConstant: constant];
			lucas[1] = [[lucas[1] subtract: [lucas[2] shiftLeft: 1]] mod: thisVal];
			
			//lucas[1] = ((lucas[1] * lucas[1]) - (lucas[2] << 1)) % thisVal;
			
			if ((lucas[1].dataLength == 1 && [lucas[1] getDataAtIndex:0] == 0))
				isPrime = true;
		}
    
		lucas[2] = [BigInt barrettReduction:[lucas[2] multiply: lucas[2]] andN: thisVal andConstant: constant];     //Q^k
	}
	if (isPrime)     // additional checks for composite numbers
	{
		// If n is prime and gcd(n, Q) == 1, then
		// Q^((n+1)/2) = Q * Q^((n-1)/2) is congruent to (Q * J(Q, n)) mod n
		
		BigInt *g = [thisVal gcd:[BigInt createFromLong:Q]];
		if (g.dataLength == 1 && [g getDataAtIndex:0] == 1)         // gcd(this, Q) == 1
		{
			if (([lucas[2] getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)
				lucas[2] = [lucas[2] add: thisVal];
			
			BigInt *temp = [[[BigInt createFromLong: Q] multiply: [BigInt createFromLong: [BigInt jacobi:[BigInt createFromLong:Q] andB:thisVal]]] mod: thisVal];
			if (([temp getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)
				temp = [temp add:thisVal];
			
			if (![lucas[2] equals: temp])
				isPrime = false;
		}
	}
	return isPrime;
}

//***********************************************************************
// Computes the Jacobi Symbol for a and b.
// Algorithm adapted from [3] and [4] with some optimizations
//***********************************************************************

+ (int)jacobi:(BigInt *)a andB:(BigInt *)b; {
#if _BI_DEBUG_
	NSLog(@"jacobi");
#endif
	
	// Jacobi defined only for odd integers
	if (([b getDataAtIndex:0] & 0x1) == 0)
		@throw [NSException exceptionWithName:@"ArgumentException" reason:@"Jacobi defined only for odd integers." userInfo:nil];
	
	if ([a greaterThanOrEqualTo: b]) a = [a mod: b];
	if (a.dataLength == 1 && [a getDataAtIndex:0] == 0) return 0;  // a == 0
	if (a.dataLength == 1 && [a getDataAtIndex:0] == 1) return 1;  // a == 1
	
	if ([a lessThan:[BigInt createFromLong: 0]]) {
		if ((([[b subtract:[BigInt createFromLong:1]] getDataAtIndex:0]) & 0x2) == 0)       //if( (((b-1) >> 1).data[0] & 0x1) == 0)
			return [BigInt jacobi:[a negate] andB: b];
		else
			return -[BigInt jacobi:[a negate] andB:b];
	}
	int e = 0;
	for (int index = 0; index < a.dataLength; index++) {
		uint mask = 0x01;
		
		for (int i = 0; i < 32; i++) {
			if (([a getDataAtIndex:index] & mask) != 0) {
				index = a.dataLength;      // to break the outer loop
				break;
			}
			mask <<= 1;
			e++;
		}
	}
	BigInt * a1 = [a shiftRight: e];
	
	int s = 1;
	if ((e & 0x1) != 0 && (([b getDataAtIndex:0] & 0x7) == 3 || ([b getDataAtIndex:0] & 0x7) == 5))
		s = -1;
	
	if (([b getDataAtIndex:0] & 0x3) == 3 && ([a1 getDataAtIndex:0] & 0x3) == 3)
		s = -s;
	
	if (a1.dataLength == 1 && [a1 getDataAtIndex:0] == 1)
		return s;
	else
		return (s * [BigInt jacobi:[b mod: a1] andB: a1]);
}

//***********************************************************************
// Probabilistic prime test based on Rabin-Miller's
//
// for any p > 0 with p - 1 = 2^s * t
//
// p is probably prime (strong pseudoprime) if for any a < p,
// 1) a^t mod p = 1 or
// 2) a^((2^j)*t) mod p = p-1 for some 0 <= j <= s-1
//
// Otherwise, p is composite.
//
// Returns
// -------
// True if "this" is a strong pseudoprime to randomly chosen
// bases.  The number of chosen bases is given by the "confidence"
// parameter.
//
// False if "this" is definitely NOT prime.
//
//***********************************************************************

- (BOOL)rabinMillerTestWithConfidence:(int)confidence; {
#if _BI_DEBUG_
	NSLog(@"rabinMillerTestWithConfidence");
#endif
	
	BigInt * thisVal;
  
	if (([self getDataAtIndex:(MAX_LENGTH - 1)] & 0x80000000) != 0)        // negative
		thisVal = [self negate];
	else
		thisVal = self;
	
	if (thisVal.dataLength == 1) {
		// test small numbers
		if ([thisVal getDataAtIndex:0] == 0 || [thisVal getDataAtIndex:0] == 1) {
			return false;
		}
    else if ([thisVal getDataAtIndex:0] == 2 || [thisVal getDataAtIndex:0] == 3) {
			return true;
		}
	}
	if (([thisVal getDataAtIndex:0] & 0x1) == 0) {    // even numbers
		return false;
	}
	// calculate values of s and t
	BigInt * p_sub1 = [thisVal subtract: [BigInt createFromLong: 1]];
	int s = 0;
	
	for (int index = 0; index < p_sub1.dataLength; index++) {
		uint mask = 0x01;
		
		for (int i = 0; i < 32; i++) {
			if (([p_sub1 getDataAtIndex:index] & mask) != 0) {
				index = p_sub1.dataLength;      // to break the outer loop
				break;
			}
			mask <<= 1;
			s++;
		}
	}
	BigInt * t = [p_sub1 shiftRight: s];
	int bits = [thisVal bitCount];
	BigInt * a = [BigInt create];
	
	for (int round = 0; round < confidence; round++) {
		bool done = false;
		
		while (!done)		// generate a < n
		{
			int testBits = 0;
			
			// make sure "a" has at least 2 bits
			while (testBits < 2) {
				double d1 = (((double)(1 + arc4random())) / (double)10000000000);
				
				testBits = (int)(((ulong)(d1 * bits)) & 0xFFFF);
				//testBits = (int)(((1 + arc4random()) * bits) & MAX_LENGTH);
			}
			[a getRandomBits:testBits];
			//a.genRandomBits(testBits, rand);
			
			int byteLen = a.dataLength;
			
			// make sure "a" is not 0
			if (byteLen > 1 || (byteLen == 1 && [a getDataAtIndex:0] != 1))
				done = true;
			
#if _BI_DEBUG_
			NSLog(@"Rabin Miller Test: TestBits: %d; ByteLen: %d", testBits, byteLen);
#endif
		}
		// check whether a factor exists (fix for version 1.03)
		BigInt * gcdTest = [a gcd:thisVal];
    
		if (gcdTest.dataLength == 1 && [gcdTest getDataAtIndex:0] != 1) {
			return false;
		}
		BigInt * b = [a modPow:t withMod:thisVal];
		bool result = false;
		
		if (b.dataLength == 1 && [b getDataAtIndex:0] == 1)         // a^t mod p = 1
			result = true;
		
		for (int j = 0; result == false && j < s; j++) {
			if ([b equals: p_sub1])         // a^((2^j)*t) mod p = p-1 for some 0 <= j <= s-1
			{
				result = true;
				break;
			}
			
			b = [[b multiply: b] mod: thisVal];
		}
		if (result == false) {
			return false;
		}
	}
	return true;
}

@end