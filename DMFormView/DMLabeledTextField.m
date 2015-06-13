//
//  DMLabeledTextField.m
//  GetSporty
//
//  Created by Dan Merlea on 15/05/15.
//  Copyright (c) 2015 Dan Merlea. All rights reserved.
//

#import "DMLabeledTextField.h"

@interface DMLabeledTextField ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;

@end


@implementation DMLabeledTextField

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    
    self.layer.borderColor = [self.textColor CGColor];
    self.backgroundColor = [UIColor whiteColor];
    
    self.textColor = [UIColor blackColor];
    self.fontName = @"HelveticaNeue";
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = @{@"label":_label, @"textField":_textField};
    NSDictionary *metrics = @{@"padding": self.padding};
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[label][textField]-padding-|"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:viewsDictionary];
    [self addConstraints:constraint_H];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake([self.padding intValue], 0, self.frame.size.width/2 - [self.padding intValue], self.frame.size.height)];
        [self addSubview:_label];
    }
    return _label;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width/2 - [self.padding intValue] * 2, self.frame.size.height)];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyNext;
        [self addSubview:_textField];
    }
    return _textField;
}

- (NSString *)text {
    return self.textField.text;
}

#pragma mark - Properties

- (void)setLabelText:(NSString *)labelText {
    
    CGSize size = [labelText sizeWithAttributes:@{NSFontAttributeName: self.label.font}];
    CGSize adjustedLabelSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    self.label.frame = CGRectMake([self.padding intValue], 0, adjustedLabelSize.width, self.frame.size.height);
    self.textField.frame = CGRectMake([self.padding intValue] + adjustedLabelSize.width, 0, self.frame.size.width - adjustedLabelSize.width - [self.padding intValue] * 2, self.frame.size.height);
    self.label.text = labelText;
}

- (void)setFontName:(NSString *)fontName{
    
    self.label.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold", fontName] size:15];
    self.textField.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Light", fontName] size:15];
    [self setLabelText:_label.text]; //resize views for font
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.label.backgroundColor = backgroundColor;
    self.textField.backgroundColor = backgroundColor;
}

- (void)setTextColor:(UIColor *)textColor {
    self.label.textColor = textColor;
    self.textField.textColor = textColor;
}

- (void)setIsLastField:(BOOL)isLastField {
    if (isLastField) {
        self.textField.returnKeyType = UIReturnKeyDone;
    }
}

- (NSNumber *)padding {
    if (!_padding) {
        _padding = [[NSNumber alloc] initWithInt:20];
    }
    return _padding;
}

- (void)setBorderWeight:(NSNumber *)borderWeight{
    self.layer.borderWidth = [borderWeight intValue];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    self.textField.secureTextEntry = secureTextEntry;
}

#pragma mark - Events


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.textField becomeFirstResponder];
}

- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.textField resignFirstResponder];
}

#pragma mark - Public methods

- (NSDictionary *)keyValue {
    return @{_key: _textField.text};
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(labeledTextFieldShouldReturn:)]) {
        return [self.delegate labeledTextFieldShouldReturn:self];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.delegate respondsToSelector:@selector(labeledTextField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate labeledTextField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

@end
