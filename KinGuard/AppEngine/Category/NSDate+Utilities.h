//
//  NSDate+Utilities.h
//  JJSOA
//
//  Created by Koson on 15-2-11.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR      3600
#define D_DAY       86400
#define D_WEEK      604800
#define D_YEAR      31556926

@interface NSDate (Utilities)

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *)dateByAddingDays: (NSInteger) dDays;
- (NSDate *)dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *)dateByAddingHours: (NSInteger) dHours;
- (NSDate *)dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *)dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *)dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateWithDay:(NSInteger)day;

- (NSDate *)firstDateOfTheMonth;
- (NSDate *)endDateOfTheMonth;
- (NSDate *)nextMonth;

// Retrieving intervals
- (NSInteger)minutesAfterDate: (NSDate *) aDate;
- (NSInteger)minutesBeforeDate: (NSDate *) aDate;
- (NSInteger)hoursAfterDate: (NSDate *) aDate;
- (NSInteger)hoursBeforeDate: (NSDate *) aDate;
- (NSInteger)daysAfterDate: (NSDate *) aDate;
- (NSInteger)daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)shortTimeFormatString;
+ (NSString *)dateWithMidTimeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
