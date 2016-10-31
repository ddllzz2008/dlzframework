//
//  FamilyPersonDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//
#import "FamilyPerson.h"
#import "FmdbHelper.h"
#import "MTLJSONAdapter.h"

@interface FamilyPersonDAL : NSObject

+(FamilyPersonDAL*)Instance;

-(NSArray*)getFamilyPersons;

@end
