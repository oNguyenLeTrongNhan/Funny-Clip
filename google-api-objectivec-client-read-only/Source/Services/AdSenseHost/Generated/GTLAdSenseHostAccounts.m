/* Copyright (c) 2012 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLAdSenseHostAccounts.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   AdSense Host API (adsensehost/v4.1)
// Description:
//   Gives AdSense Hosts access to report generation, ad code generation, and
//   publisher management capabilities.
// Documentation:
//   https://developers.google.com/adsense/host/
// Classes:
//   GTLAdSenseHostAccounts (0 custom class methods, 3 custom properties)

#import "GTLAdSenseHostAccounts.h"

#import "GTLAdSenseHostAccount.h"

// ----------------------------------------------------------------------------
//
//   GTLAdSenseHostAccounts
//

@implementation GTLAdSenseHostAccounts
@dynamic ETag, items, kind;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"etag"
                                forKey:@"ETag"];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLAdSenseHostAccount class]
                                forKey:@"items"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"adsensehost#accounts"];
}

@end
