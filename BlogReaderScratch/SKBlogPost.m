//
//  SKBlogPost.m
//  BlogReaderScratch
//
//  Created by stephen g on 2/18/14.
//  Copyright (c) 2014 stephen g. All rights reserved.
//

#import "SKBlogPost.h"

@implementation SKBlogPost

-(id)initWithTitle:(NSString *)title{
    self = [super init];
    if(self){
        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }
    return self;
}

+(id)blogPostWithTitle:(id)title{
    return [[self alloc] initWithTitle:title];
}

-(NSURL *)thumbnailURL{
    return [NSURL URLWithString: self.thumbnail];
}

-(NSString *)formattedDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    [dateFormatter setDateFormat:@"EE MMM, dd"];
    return [dateFormatter stringFromDate:tempDate];
}

@end
