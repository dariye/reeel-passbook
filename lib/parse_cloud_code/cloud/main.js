Parse.Cloud.beforeSave('Screening', function(req, res) {
  var address = req.object.get('screeningLocation');
  
  Parse.Cloud.httpRequest({
      method: 'POST',
      url: 'https://maps.googleapis.com/maps/api/geocode/json',
      params: { address: address, key: 'AIzaSyC4hsgl2OnvSxn4SuPM5ZGBjFPglCmBaog' }
    }).then(function(httpResponse){
      var response = httpResponse.data;
      if(response.status == 'OK'){
        var latlng = response.results[0].geometry.location;
        req.object.set('latlng', latlng);
        req.object.set('locationImage', 'https://maps.googleapis.com/maps/api/staticmap?' + 'center=' + latlng.lat + ',' + latlng.lng + '&zoom=' + 15 + '&size=' + '355x178' + '&scale=2' + '&maptype=' +'roadmap' +'&markers=' + 'color:red%7Clabel:B%7C' + latlng.lat + ',' + latlng.lng);
        
        res.success();
      }
    },function(httpResponse){
        console.error('Request failed with code ' + httpResponse.status);
      }
    );
});

/**
 * afterSave hook for 'Screening' object
 * @type method
 * @description runs after a screening object is created and accomplishes the following:
 * - create a screening on pass client
 *    -> must store screening image as a file for the pass 'background' image for retina and non-retina displays
 */
var passClient = 'http://api.reeelapp.com';
var screeningEndpoint = passClient + '/screenings';

Parse.Cloud.afterSave('Screening', function(request, response) {
  var screening = request.object;
  Parse.Cloud.httpRequest({
    url: screeningEndpoint,
    params: {
      object_id: screening.id
    },
    headers: { 
      'Content-Type': 'application/json;charset=utf-8'
    }
  }).then(function(httpResponse) {
    console.log(httpResponse.text);
    console.log(httpResponse.data);
    alert('1');
    screenings = httpResponse.data['screenings'];
    console.log(screenings.length);
    // Check if screening exists
    if(screenings.length < 1) {
      console.log('2');
      Parse.Cloud.httpRequest({
        method: 'POST',
        url: screeningEndpoint,
        headers: { 
          'Content-Type': 'application/json;charset=utf-8',
              
        },
        body: {
          screening: {
            title: screening.get('screeningTitle'),
            location: screening.get('screeningLocation'),
            time_date: screening.get('screeningDate'),
            term_n_conditions: screening.get('screeningTerms'),
            parseid: screening.id,
            location_name: screening.get('screeningLocation')
          }
        }
      }).then(function(httpResponse) {
        alert(httpResponse);
      }, function(httpResponse) {
        console.log('2');
        console.log('Request failed with response code ' + httpResponse.status);
      });
    }
  }, function(httpResponse) {
    console.log('1');
    console.log('Request failed with response code ' + httpResponse.status);
  });
});


/**
 * afterSave hook for 'guestList' object
 * @type method
 * @description after a guestList object is created, the following hook runs to accomplish the following:
 * - create user with guest email if doesn't exist
 * - create a pass for the user on pass client
 * - retrieve pass 
 * - sent pass to user via email or passkit
 */

/**
 * updateStaticMaps cron job that updates static maps configurations, propagating any changes
 * @type method
 */

// Parse.Cloud.job('updateStaticMaps', function(request, status){
//   var query = new Parse.Query('Screening');
//   Parse.Cloud.useMasterKey();

//   query.each(function(screening){
//     var latlng = screening.latlng;
//     screening.set('locationImage', 'https://maps.googleapis.com/maps/api/staticmap?' + 'center=' + latlng.lat + ',' + latlng.lng + '&zoom=' + 12 + '&size=' + '355x178' + '&scale=2' + '&maptype=' +'roadmap' +'&markers=' + 'color:red%7Clabel:B%7C' + latlng.lat + ',' + latlng.lng);
//     return screening.save();
//   }).then(function(){
//     status.success('Static Maps updated successfully');
//   }, function(error){

//     status.error('Error updating static maps');
//   });
// });

