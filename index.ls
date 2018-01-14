/**
 * @package build-gbu
 * @author  Nazar Mokrynskyi <nazar@mokrynskyi.com>
 * @license 0BSD
 */
browserify	= require('browserify')
del			= require('del')
gulp		= require('gulp')
gutil		= require('gulp-util')
rename		= require('gulp-rename')
tap			= require('gulp-tap')
uglify-es	= require('uglify-es')
uglify		= require('gulp-uglify/composer')(uglify-es, console)
DESTINATION	= 'dist'

module.exports	= build

/**
 * @param {string}					source				Source file Browserify will work with
 * @param {string}					standalone			Corresponds to Browserify option with the same name
 * @param {string}					output_file_name	Base name for output file in `dist` directory
 * @param {(string|!Array<string>)}	ignore				Dependencies to ignore by Browserify (its `ignore()` method)
 * @param {!Object}					gulp_instance		Your gulp instance in case you want to integrate this with your own tasks
 */
!function build (source, standalone, output_file_name, ignore = [], gulp_instance = gulp)
	gulp_instance
		.task('build', ['clean', 'browserify', 'minify'])
		.task('browserify', ['clean'], ->
			gulp.src(source, {read: false})
				.pipe(tap(
					(file) !->
						file.contents	=
							browserify(
								entries		: file.path
								standalone	: standalone
							)
								.ignore(ignore)
								.bundle()
				))
				.pipe(rename(
					basename	: output_file_name
				))
				.pipe(gulp.dest(DESTINATION))
		)
		.task('clean', ->
			del(DESTINATION)
		)
		.task('minify', ['browserify'], ->
			gulp.src("#DESTINATION/*.js")
				.pipe(uglify())
				.on('error', (err) !-> gutil.log(gutil.colors.red('[Error]'), err.toString()))
				.pipe(rename(
					suffix: '.min'
				))
				.pipe(gulp.dest(DESTINATION))
		)
