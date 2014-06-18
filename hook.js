
//Import execFile, to run our bash script

var execOptions = {
     maxBuffer: 1024 * 1024 * 8 * 8 // 1mb
}

var exec = require('child_process').exec;

var githubhook = require('./server.js');
var github = githubhook({
  port:9003
});

github.listen();

github.on('*', function (event, repo, ref, data) {
  if(ref==='refs/heads/master'
  && repo==='qarth'
  && event==='push'){
    console.log('BUILD TRIGGERED');
    child = exec('sh deploy.sh',
      function (error, stdout, stderr) {
        console.log('stdout: ' + stdout);
        console.log('stderr: ' + stderr);
        if (error !== null) {
          console.log('exec error: ' + error);
        }
    });
  }
});

console.log('Hook Started');
