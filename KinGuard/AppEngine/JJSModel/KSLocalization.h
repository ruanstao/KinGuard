//
//  LocalizationSystem.h
//  Battle of Puppets
//
//  Created by Juan Albero Sanchis on 27/02/10.
//  Copyright Aggressive Mediocrity 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KSLocalizedString(key, comment) \
[[KSLocalization sharedLocalization] localizedStringForKey:(key) value:(comment)]

#define LocalizationSetLanguage(language) \
[[KSLocalization sharedLocalization] setLanguage:(language)]

#define LocalizationGetLanguage \
[[KSLocalization sharedLocalization] getLanguage]

#define LocalizationReset \
[[KSLocalization sharedLocalization] resetLocalization]

@interface KSLocalization : NSObject {
	NSString *language;
}

// you really shouldn't care about this functions and use the MACROS
+ (KSLocalization *)sharedLocalization;

- (NSString *)pathForResource:(NSString *)name ofType:(NSString *)ext;

- (NSURL *)URLForResource:(NSString *)name withExtension:(NSString *)ext;

//gets the string localized
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

//sets the language
- (void) setLanguage:(NSString*) language;

//gets the current language
- (NSString*) getLanguage;

//resets this system.
- (void) resetLocalization;

@end
