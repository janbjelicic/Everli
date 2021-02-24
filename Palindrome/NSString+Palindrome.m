//
//  NSString+Palindrome.m
//  Palindrome
//
//  Created by Jan Bjelicic on 24/02/2021.
//

#import "NSString+Palindrome.h"

@implementation NSString (Palindrome)

/// Decided to turn uppercase letters into lowercase since people tend to write phrases and sentences with much more
/// lowercase letters so this would be a more optimal solution then doing it the other way around.
- (BOOL)isPalindrome {
    unsigned long textSize = [self length];
    // When checking if a string is a palindrome we are comparing one side of the string to the other.
    // Therefore we don't need to have the index going to the end of the string, but only half of the way.
    for (int i = 0; i < textSize / 2; i++) {
        // Using int so that I get an ascii value of the character.
        int leftSideCharacter = [self characterAtIndex: i];
        int rightSideCharacter = [self characterAtIndex: textSize - i - 1];
        
        // Ascii value for A (capital letter) is 65 and ascii value for Z is 90.
        // By adding 32 we are turning the letters lowercase only if they are uppercase.
        if (leftSideCharacter >= 65 && leftSideCharacter <= 90) {
            leftSideCharacter += 32;
        }
        if (rightSideCharacter >= 65 && rightSideCharacter <= 90) {
            rightSideCharacter += 32;
        }
        if (leftSideCharacter != rightSideCharacter) {
            return false;
        }
    }
    return true;
}

@end
