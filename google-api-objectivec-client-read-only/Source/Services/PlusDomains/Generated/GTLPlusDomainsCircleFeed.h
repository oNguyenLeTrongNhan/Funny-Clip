/* Copyright (c) 2013 Google Inc.
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
//  GTLPlusDomainsCircleFeed.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google+ Domains API (plusDomains/v1)
// Description:
//   The Google+ API enables developers to build on top of the Google+ platform.
// Documentation:
//   https://developers.google.com/+/domains/
// Classes:
//   GTLPlusDomainsCircleFeed (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLPlusDomainsCircle;

// ----------------------------------------------------------------------------
//
//   GTLPlusDomainsCircleFeed
//

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLPlusDomainsCircleFeed : GTLCollectionObject

// ETag of this response for caching purposes.
@property (copy) NSString *ETag;

// The circles in this page of results.
@property (retain) NSArray *items;  // of GTLPlusDomainsCircle

// Identifies this resource as a collection of circles. Value:
// "plus#circleFeed".
@property (copy) NSString *kind;

// Link to the next page of circles.
@property (copy) NSString *nextLink;

// The continuation token, which is used to page through large result sets.
// Provide this value in a subsequent request to return the next page of
// results.
@property (copy) NSString *nextPageToken;

// Link to this page of circles.
@property (copy) NSString *selfLink;

// The title of this list of resources.
@property (copy) NSString *title;

// The total number of circles. The number of circles in this response may be
// smaller due to paging.
@property (retain) NSNumber *totalItems;  // intValue

@end
