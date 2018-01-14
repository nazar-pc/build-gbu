# Build: Gulp+Browserify+Uglify
Opinionated set of Gulp tasks that:
* build stuff with browserify
* put the result in `dist` directory
* compress the result with Uglify and also place it in `dist` directory

## How to install
```
npm install --save-dev build-gbu
```

## How to use
```javascript
// gulpfile.js
require('build-gbu')(
	'index.js',             // Source file Browserify will work with
	'project_name',         // Corresponds to Browserify option with the same name
	'project-name.browser', // Base name for output file in `dist` directory
	'ignore-dependency',    // [optional] Dependencies to ignore by Browserify (its `ignore()` method)
	require('gulp')         // [optional] Your gulp instance in case you want to integrate this with your own tasks
)
```

This will provide following gulp tasks:
* build: clean, browserify, minify
* browserify: clean
* clean
* minify: browserify

## Contribution
Feel free to create issues and send pull requests (for big changes create an issue first and link it from the PR), they are highly appreciated!

## License
Free Public License 1.0.0 / Zero Clause BSD License

https://opensource.org/licenses/FPL-1.0.0

https://tldrlegal.com/license/bsd-0-clause-license
