//
//  SKBlogPost.h
//  BlogReaderScratch
//
//  Created by stephen g on 2/18/14.
//  Copyright (c) 2014 stephen g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKBlogPost : NSObject

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSURL *url;

//designated initalizer
-(id)initWithTitle:(NSString *)title;
+(id)blogPostWithTitle:(NSString *) title;

-(NSURL *)thumbnailURL;

-(NSString *)formattedDate;

@end
