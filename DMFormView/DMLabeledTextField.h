//
//  DMLabeledTextField.h
//  GetSporty
//
//  Created by Dan Merlea on 15/05/15.
//  Copyright (c) 2015 Dan Merlea. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DMLabeledTextFieldDelegate;


IB_DESIGNABLE
@interface DMLabeledTextField : UIView <UITextFieldDelegate>

@property (strong, nonatomic) IBInspectable NSString *key;          // optimized for url with key => value
@property (strong, nonatomic) IBInspectable NSString *labelText;

@property (strong, nonatomic) NSString *text;

@property (strong, nonatomic) NSString *fontName;                   // default Helvetica
@property (strong, nonatomic) UIColor *textColor;                   // default black
@property (strong, nonatomic) NSNumber *padding;                    // default is 20
@property (strong, nonatomic) NSNumber *borderWeight;               // default none
@property (strong, nonatomic) UIColor *borderColor;                 // default text color
@property (nonatomic) BOOL isLastField;                             // change the return button from next to done
@property (nonatomic) BOOL secureTextEntry;                         // password field, default no

@property (weak, nonatomic) id<DMLabeledTextFieldDelegate> delegate;


- (NSDictionary *)keyValue;

@end


@protocol DMLabeledTextFieldDelegate <NSObject>

- (BOOL)labeledTextFieldShouldReturn:(DMLabeledTextField *)labeledTextField;

@optional
- (BOOL)labeledTextField:(DMLabeledTextField *)labeledTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


@end