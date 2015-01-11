//
//  Event.h
//  ParseStarterProject
//
//  Created by Marcelo Faria Santos on 30/12/14.
//
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *mes;
@property (nonatomic, retain) NSString *location;
@property (nonatomic) BOOL free;
@property (nonatomic) int valor;
@end
