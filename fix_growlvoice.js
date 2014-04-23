/**
 * A quick n' dirty hack to fix a dying GrowlVoice
 *
 * GrowlVoice is now officially dead: https://twitter.com/GrowlVoice/status/455931023868448768
 * However, Google didn't really shut off API access (there wasn't really any to begin with);
 * they slightly mangled a JSON object GrowlVoice was looking for on one of Google Voice's
 * internal pages.
 *
 * The following is a Cycript script that will bring a dead GrowlVoice back
 * to life for the moment (until Google decides to mangle things more).
 *
 * To use:
 *
 *  - Download cycript from cycript.org, and extract somewhere sane
 *  - download this script to the same place as cycript
 *  - Start GrowlVoice (it will complain about malformed JSON)
 *  - Run sudo ./cycript -p GrowlVoice fix_growlvoice.js
 */

@import com.saurik.substrate.MS

var oldm = {},
    NSUTF8StringEncoding = 4,
    MESSAGE = @selector(accountInfoFetcher:finishedWithData:error:),
    START_TOKEN = 'var _gcData = ',
    END_TOKEN = '};';

// It's failing in accountInfoFetcher:finishedWithData:error:, a callback method
// that parses a response from Google's auth page, and pulls in a bunch of info.
//
// Since it's failing there, let's hook it, and massage the data we're getting
// back until GrowlVoice can understand it again.
//
// Using MobileSubstrate, the following line 'swizzles' the method, replacing 
// it with our own wrapper function:
MS.hookMessage(GoogleVoiceLoginInterface, MESSAGE, function (fetcher, data, err) {
  // In particular, we need to find a json object embedded in the page that was
  // just returned into this function (as the second arg, data).
  
  // Convert to NSString from NSData
  var sdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

  // Find the start and end of the JSON object, then split the page into 3
  // sections: before the json object, after, and the object itself. This is 
  // pretty fragile, but exactly what GrowlVoice does, so we might as well be 
  // consistant.
  var startIndex = sdata.indexOf(START_TOKEN) + START_TOKEN.length;
  var endIndex = sdata.indexOf(END_TOKEN, startIndex) + 1;
  var prefix = sdata.slice(0, startIndex);
  var suffix = sdata.slice(endIndex);
  var authJSON = sdata.slice(startIndex, endIndex);
  
  // Now, fix the JSON object.  This method is robust, but dangerous:
  // Google's new JSON encoding format only works when evaluating as a
  // javascript statement -- it's really not even close to valid json.
  // Therefore, we evaluate that line as a javascript statement, then
  // re-encode back to well-formed json.
  eval('var gcData = ' + authJSON);
  var fixedJSON = JSON.stringify(gcData);
  
  // reconstruct the original page, and pass back through to the original method
  var newdata = [(prefix + fixedJSON + suffix) dataUsingEncoding:NSUTF8StringEncoding];
  oldm->call(this, fetcher, newdata, err);
}, oldm);

// trigger the signin process again
[choose(GoogleVoiceLoginInterface)[0] signIn];
