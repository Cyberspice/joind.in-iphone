//
//  EventGetTalks.m
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventGetTalks.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "TalkDetailModel.h"

@implementation EventGetTalks

- (void)call:(EventDetailModel *)event {
	[self callAPI:@"event" action:@"gettalks" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", event.Id] forKey:@"event_id"]];
}

- (void)gotData:(NSObject *)obj {
	TalkListModel *tlm = [[[TalkListModel alloc] init] autorelease];
	
	NSDictionary *d = (NSDictionary *)obj;
	for (NSDictionary *talk in d) {
		TalkDetailModel *tdm = [[TalkDetailModel alloc] init];
		
		if ([[talk objectForKey:@"talk_title"] isKindOfClass:[NSString class]]) {
			tdm.title = [talk objectForKey:@"talk_title"];
		} else {
			tdm.title = @"";
		}
		
		if ([[talk objectForKey:@"speaker"] isKindOfClass:[NSString class]]) {
			tdm.speaker    = [talk objectForKey:@"speaker"];
		} else {
			tdm.speaker = @"";
		}
		
		if ([[talk objectForKey:@"tid"] isKindOfClass:[NSString class]]) {
			tdm.Id         = [[talk objectForKey:@"tid"] integerValue];
		} else {
			tdm.Id = 0;
		}
		
		if ([[talk objectForKey:@"eid"] isKindOfClass:[NSString class]]) {
			tdm.eventId    = [[talk objectForKey:@"eid"] integerValue];
		} else {
			tdm.eventId = 0;
		}
		
		if ([[talk objectForKey:@"slides_link"] isKindOfClass:[NSString class]]) {
			tdm.slidesLink = [talk objectForKey:@"slides_link"];
		} else {
			tdm.slidesLink = @"";
		}
		
		if ([[talk objectForKey:@"date_given"] isKindOfClass:[NSString class]]) {
			tdm.given      = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"date_given"]   integerValue]];
		} else {
			tdm.given = 0;
		}
		
		if ([[talk objectForKey:@"talk_desc"] isKindOfClass:[NSString class]]) {
			tdm.desc       = [talk objectForKey:@"talk_desc"];
		} else {
			tdm.desc = @"";
		}
		
		if ([[talk objectForKey:@"lang_name"] isKindOfClass:[NSString class]]) {
			tdm.langName   = [talk objectForKey:@"lang_name"];
		} else {
			tdm.langName = @"";
		}
		
		if ([[talk objectForKey:@"lang"] isKindOfClass:[NSString class]]) {
			tdm.lang       = [[talk objectForKey:@"lang"] integerValue];
		} else {
			tdm.lang = 0;
		}
		
		if ([[talk objectForKey:@"rank"] isKindOfClass:[NSString class]]) {
			tdm.rating = [[talk objectForKey:@"rank"] integerValue];
		} else {
			tdm.rating = 0;
		}
		
		if ([[talk objectForKey:@"tcid"] isKindOfClass:[NSString class]]) {
			tdm.type       = [talk objectForKey:@"tcid"];
		} else {
			tdm.type = @"";
		}
		
		if ([[talk objectForKey:@"active"] isKindOfClass:[NSString class]]) {
			tdm.active       = ([[[talk objectForKey:@"active"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else {
			tdm.active = NO;
		}
		
		if ([[talk objectForKey:@"owner_id"] isKindOfClass:[NSString class]]) {
			tdm.speakerId       = [[talk objectForKey:@"owner_id"] integerValue];
		} else {
			tdm.speakerId = 0;
		}
		
		if ([[talk objectForKey:@"private"] isKindOfClass:[NSString class]]) {
			tdm.private       = ([[[talk objectForKey:@"private"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else {
			tdm.private = NO;
		}
		
		if ([[talk objectForKey:@"lang_abbr"] isKindOfClass:[NSString class]]) {
			tdm.langAbbr       = [talk objectForKey:@"lang_abbr"];
		} else {
			tdm.langAbbr = @"";
		}
		
		if ([[talk objectForKey:@"ccount"] isKindOfClass:[NSString class]]) {
			tdm.numComments       = [[talk objectForKey:@"ccount"] integerValue];
		} else {
			tdm.numComments = 0;
		}
		
		if ([[talk objectForKey:@"last_comment_date"] isKindOfClass:[NSString class]]) {
			tdm.lastComment      = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"last_comment_date"]   integerValue]];
		} else {
			tdm.lastComment = 0;
		}
		
		[tlm addTalk:tdm];
		[tdm release];
		
	}
	[self.delegate gotTalksForEvent:tlm];
}

- (void)gotError:(NSObject *)error {
	NSLog(@"error");
}
	
@end

@implementation APICaller (APICaller_EventGetTalks)
+ (EventGetTalks *)EventGetTalks:(id)_delegate {
	static EventGetTalks *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[EventGetTalks alloc] initWithDelegate:_delegate];
	return e;
}
@end
