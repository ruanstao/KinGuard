//
//  JJSTextField.m
//  JJSOA
//
//  Created by Koson on 15-2-11.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSTextField.h"

@interface JJSTextField()
{
    UITextField *_textField;
    BOOL _disabled;
}

@property (nonatomic) BOOL keyboardIsShown;
@property (nonatomic) CGSize keyboardSize;
@property (nonatomic) BOOL hasScrollView;
@property (nonatomic) BOOL invalid;

@property (nonatomic, setter = setToolbarCommand:) BOOL isToolBarCommand;
@property (nonatomic, setter = setDoneCommand:) BOOL isDoneCommand;

@property (nonatomic , strong) UIBarButtonItem *previousBarButton;
@property (nonatomic , strong) UIBarButtonItem *nextBarButton;

@property (nonatomic, strong) NSMutableArray *textFields;

@property (weak) id keyboardWillShowNotificationObserver;
@property (weak) id keyboardWillHideNotificationObserver;

@end

@implementation JJSTextField

@synthesize required;
@synthesize scrollView;
@synthesize toolbar;
@synthesize keyboardIsShown;
@synthesize keyboardSize;
@synthesize invalid;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self){
        [self setup];
    }
    
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setup{
    if ([self respondsToSelector:@selector(setTintColor:)])
        [self setTintColor:kNavItemColor];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.window.frame.size.width, 44);
    // set style
    [toolbar setBarStyle:UIBarStyleDefault];
    
    self.previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(previousButtonIsClicked:)];
    [self.previousBarButton setTintColor:kNavItemColor];
    
    self.nextBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonIsClicked:)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked:)];
    
    NSArray *barButtonItems = @[self.previousBarButton, self.nextBarButton, flexBarButton, doneBarButton];
    
    toolbar.items = barButtonItems;
    
    self.textFields = [[NSMutableArray alloc]init];
    
//    [self markTextFieldsWithTagInView:self.superview];
    
    
    //    [self setBorderStyle:UITextBorderStyleNone];
    //
    //    [self setFont: [UIFont systemFontOfSize:17]];
    //    [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    //    [self setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)markTextFieldsWithTagInView:(UIView*)view{
    int index = 0;
    if ([self.textFields count] == 0){
        for(UIView *subView in view.subviews){
            if ([subView isKindOfClass:[JJSTextField class]]){
                JJSTextField *textField = (JJSTextField*)subView;
                textField.tag = index;
                [self.textFields addObject:textField];
                index++;
            }
        }
    }
}

- (void) doneButtonIsClicked:(id)sender{
    [self setDoneCommand:YES];
    [self resignFirstResponder];
    [self setToolbarCommand:YES];
}

- (void) nextButtonIsClicked:(id)sender{
    NSInteger tagIndex = self.tag;
    JJSTextField *textField =  [self.textFields objectAtIndex:++tagIndex];
    
    while (!textField.isEnabled && tagIndex < [self.textFields count])
        textField = [self.textFields objectAtIndex:++tagIndex];
    
    [self becomeActive:textField];
}

- (void) previousButtonIsClicked:(id)sender{
    NSInteger tagIndex = self.tag;
    
    JJSTextField *textField =  [self.textFields objectAtIndex:--tagIndex];
    
    while (!textField.isEnabled && tagIndex < [self.textFields count])
        textField = [self.textFields objectAtIndex:--tagIndex];
    
    [self becomeActive:textField];
}

- (void)becomeActive:(UITextField*)textField{
    [self setToolbarCommand:YES];
    [self resignFirstResponder];
    [textField becomeFirstResponder];
}

- (void)setBarButtonNeedsDisplayAtTag:(NSInteger)tag{
    BOOL previousBarButtonEnabled = NO;
    BOOL nexBarButtonEnabled = NO;
    
    for (int index = 0; index < [self.textFields count]; index++) {
        
        UITextField *textField = [self.textFields objectAtIndex:index];
        
        if (index < tag)
            previousBarButtonEnabled |= textField.isEnabled;
        else if (index > tag)
            nexBarButtonEnabled |= textField.isEnabled;
    }
    
    self.previousBarButton.enabled = previousBarButtonEnabled;
    self.nextBarButton.enabled = nexBarButtonEnabled;
}

- (void) selectInputView:(UITextField *)textField{
    if (_isDateField){
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        if (![textField.text isEqualToString:@""]){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            if (self.dateFormat) {
                [dateFormatter setDateFormat:self.dateFormat];
            } else {
                [dateFormatter setDateFormat:@"MM/dd/YY"];
            }
            [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [datePicker setDate:[dateFormatter dateFromString:textField.text]];
        }
        [textField setInputView:datePicker];
    }
}

- (void)datePickerValueChanged:(id)sender{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    
    NSDate *selectedDate = datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [
     dateFormatter setDateFormat:@"MM/dd/YY"];
    
    [_textField setText:[dateFormatter stringFromDate:selectedDate]];
    
    [self validate];
}

- (void)scrollToField:(BOOL)animated
{
    CGRect textFieldRect = _textField.frame;
    
    CGRect aRect = self.window.bounds;
    
    aRect.origin.y = -scrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height + self.toolbar.frame.size.height + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0, self.superview.frame.origin.y + _textField.frame.origin.y + _textField.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        if (scrollPoint.y >scrollView.contentOffset.y) {
            [scrollView setContentOffset:scrollPoint animated:animated];
        }
    }
}

- (BOOL) validate{
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.1];
    
    if (required && [self.text isEqualToString:@""]){
        return NO;
    }
    else if (_isEmailField){
        NSString *emailRegEx =
        @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
        @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if (![emailTest evaluateWithObject:self.text]){
            return NO;
        }
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    return YES;
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (!enabled)
        [self setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)setDateFieldWithFormat:(NSString *)dateFormat {
    self.isDateField = YES;
    self.dateFormat = dateFormat;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGFloat margin = 10;
    if (self.leftView) {
        margin = 40;
    }
    
    return CGRectInset(bounds, margin, 5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    CGFloat margin = 10;
    if (self.leftView) {
        margin = 40;
    }
    
    return CGRectInset(bounds, margin, 5);
}

#pragma mark - UIKeyboard notifications

//- (void) keyboardDidShow:(NSNotification *) notification{
//    if (_textField== nil) return;
//    if (keyboardIsShown) return;
//    if (![_textField isKindOfClass:[JJSTextField class]]) return;
//    
//    NSDictionary* info = [notification userInfo];
//    
//    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    keyboardSize = [aValue CGRectValue].size;
//    
//    [self scrollToField];
//    
//    self.keyboardIsShown = YES;
//}

- (void)keyboardWillShow:(NSNotification *) notification
{
    if (_textField== nil) return;
    if (keyboardIsShown) return;
    if (![_textField isKindOfClass:[JJSTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    NSInteger curve = [[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    NSLog(@"%@",info);
    [UIView beginAnimations:@"keyboardAnimation" context:nil];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];
    [self scrollToField:(duration == 0)];
    [UIView commitAnimations];
    self.keyboardIsShown = YES;
}

- (void) keyboardWillHide:(NSNotification *) notification{
    NSDictionary* info = [notification userInfo];
//    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve = [[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:@"keyboardAnimationhide" context:nil];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];
    if (_isDoneCommand)
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
    [self removeMarkTextField];
    [[NSNotificationCenter defaultCenter]removeObserver:self.keyboardWillShowNotificationObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self.keyboardWillHideNotificationObserver];
}

- (void)removeMarkTextField
{
    NSArray * tempArr = [NSArray arrayWithArray:self.textFields];
    [ tempArr enumerateObjectsUsingBlock:^(JJSTextField * textField, NSUInteger idx, BOOL *stop) {
        [textField.textFields removeAllObjects];
    }];
}
#pragma mark - UITextField notifications

- (void)textFieldDidBeginEditing:(NSNotification *) notification{
    UITextField *textField = (UITextField*)[notification object];
    
    _textField = textField;
    
//    [self setKeyboardDidShowNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
//        [self keyboardDidShow:notification];
//    }]];
    [self setKeyboardWillShowNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardWillShow:notification];
    }]];
    [self setKeyboardWillHideNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardWillHide:notification];
    }]];
    
    [self setBarButtonNeedsDisplayAtTag:textField.tag];
    
    if ([self.superview isKindOfClass:[UIScrollView class]] && self.scrollView == nil)
        self.scrollView = (UIScrollView*)self.superview;
    
    [self selectInputView:textField];
    [self setInputAccessoryView:toolbar];
    
    [self setToolbarCommand:NO];
    
    UIView *view = self.superview;
    [self markTextFieldsWithTagInView:view];
    
    
}

- (void)textFieldDidEndEditing:(NSNotification *) notification{
    UITextField *textField = (UITextField*)[notification object];
    
    if (_isDateField && [textField.text isEqualToString:@""] && _isDoneCommand){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        if (self.dateFormat) {
            [dateFormatter setDateFormat:self.dateFormat];
        } else {
            [dateFormatter setDateFormat:@"MM/dd/YY"];
        }
        
        [textField setText:[dateFormatter stringFromDate:[NSDate date]]];
    }
    
    [self validate];
    
    [self setDoneCommand:NO];
    
    _textField = nil;
}

//- (void)layoutSublayersOfLayer:(CALayer *)layer{
//    [super layoutSublayersOfLayer:layer];
//
//    [layer setBorderWidth: 0.8];
//    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
//
//    [layer setCornerRadius:3.0];
//    [layer setShadowOpacity:1.0];
//    [layer setShadowColor:[UIColor redColor].CGColor];
//    [layer setShadowOffset:CGSizeMake(1.0, 1.0)];
//}

//- (void) drawPlaceholderInRect:(CGRect)rect {
//    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0]};
//    [self.placeholder drawInRect:CGRectInset(rect, 5, 5) withAttributes:attributes];
//}

@end
