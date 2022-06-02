const { watch } = require('gulp');
var exec = require('child_process').exec;

function Test(cb)
{
	exec('wsl busted ./', function(err,stdout, stderr) {
		console.log(stdout);
		console.log(stderr);
		cb();
	});
}

exports.default = function() {
	watch('./**/*.lua', Test)
}