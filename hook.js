// Listen on port 9001
//var gith = require('gith').create( 9003 );
var hookshot = require('hookshot');
// Import execFile, to run our bash script

var execOptions = {
     //maxBuffer: 1024 * 1024 // 1mb
}

var execFile = require('child_process').execFile;

// gith({
//     repo: 'thecaddy/qarth'
// }).on( 'all', function( payload ) {
//     console.log('Executing Payload:', payload);
//     if( payload.branch === 'master' )
//     {
//             // Exec a shell script
//             execFile('deploy.sh', execOptions, function(error, stdout, stderr) {
//                     // Log success in some manner
//                     console.log( 'EXEC COMPLETE' );
//             });
//     }
// });

hookshot('refs/heads/master', function(info) {
  console.log('made it', info);
}).listen(9003);

console.log('Hook Started');
