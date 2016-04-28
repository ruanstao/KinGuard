//
//  LocalizationSystem.m
//  Battle of Puppets
//
//  Created by Juan Albero Sanchis on 27/02/10.
//  Copyright Aggressive Mediocrity 2010. All rights reserved.
//

#import "KSLocalization.h"

@implementation KSLocalization

//Singleton instance
static KSLocalization *_sharedLocalization = nil;

//Current application bungle to get the languages.
static NSBundle *bundle = nil;

+ (KSLocalization *)sharedLocalization
{
	@synchronized([KSLocalization class])
	{
		if (!_sharedLocalization){
			_sharedLocalization = [[self alloc] init];
		}
		//return _sharedLocalization;
	}
	// to avoid compiler warning
	return _sharedLocalization;
}

+ (id)alloc
{
	@synchronized([KSLocalization class])
	{
		NSAssert(_sharedLocalization == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedLocalization = [super alloc];
		return _sharedLocalization;
	}
	// to avoid compiler warning
	return nil;
}

- (id)init
{
    if ((self = [super init])) 
    {
		//empty.
		bundle = [NSBundle mainBundle];
	}
    return self;
}

- (NSString *)pathForResource:(NSString *)name ofType:(NSString *)ext {
    NSString *path = [bundle pathForResource:name ofType:ext];
    if (path == nil)
        path = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    return path;
}

- (NSURL *)URLForResource:(NSString *)name withExtension:(NSString *)ext {
    NSURL *path = [bundle URLForResource:name withExtension:ext];
    if (path == nil)
        path = [[NSBundle mainBundle] URLForResource:name withExtension:ext];
    return path;
}

// Gets the current localized string as in NSLocalizedString.
//
// example calls:
// AMLocalizedString(@"Text to localize",@"Alternative text, in case hte other is not find");
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
//    NSLog(@"Bundle Path:%@", [bundle bundlePath]);
//    NSLog(@"Value:%@", [bundle localizedStringForKey:key value:comment table:nil]);
	return [bundle localizedStringForKey:key value:comment table:@"Localized"];
}


// Sets the desired language of the ones you have.
// example calls:
// LocalizationSetLanguage(@"Italian");
// LocalizationSetLanguage(@"German");
// LocalizationSetLanguage(@"Spanish");
// 
// If this function is not called it will use the default OS language.
// If the language does not exists y returns the default OS language.
- (void) setLanguage:(NSString*)l{
//	NSLog(@"preferredLang: %@", l);
	[[NSUserDefaults standardUserDefaults] setObject:l forKey:@"Language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
	NSString *path = [[NSBundle mainBundle] pathForResource:l ofType:@"lproj"];
    
//    NSLog(@"Path: %@", path);

	if (path == nil)
		//in case the language does not exists
		[self resetLocalization];
	else		bundle = [NSBundle bundleWithPath:path];
}

// Just gets the current setted up language.
// returns "es","fr",...
//
// example call:
// NSString * currentL = LocalizationGetLanguage;
- (NSString*) getLanguage{

    //return [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"];

    
    //Update By Koson
    //2014/02/14
    
//	NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
//
//	NSString *preferredLang = [languages objectAtIndex:0];
//
//    return preferredLang;
    
    NSString *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"];
    
	return languages;
}

// Resets the localization system, so it uses the OS default language.
//
// example call:
// LocalizationReset;
- (void) resetLocalization
{
	bundle = [NSBundle mainBundle];
}


@end
