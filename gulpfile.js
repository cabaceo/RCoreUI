/**
 * The overall Gulp file for the entire project.
 *
 * It includes two parts:
 *
 * - Run and test the code of the UI framework.
 * - (Probably) run and test the R part - still need investigation.
 *
 */

'use strict';

var gulp = require('gulp');
var runSequence = require('run-sequence');
var del = require('del');

var browserSync = require('browser-sync').create();

var sass = require('gulp-sass');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');


//----------------------------------------------------------
// Gulp Paths
//----------------------------------------------------------
gulp.paths = {
    src: 'srcjs',
    distR: 'inst/core-ui'  // "dist" folder for Shiny(R) package
};
var paths = gulp.paths;

//----------------------------------------------------------
// Main Task - UI Framework
//----------------------------------------------------------
gulp.task('default', ['serve']);

gulp.task('serve', ['sass'], function() {

    browserSync.init({
        server: paths.src
    });

    gulp.watch(paths.src + '/scss/**/*.scss', ['sass']);
    gulp.watch(paths.src + '/**/*.html').on('change', browserSync.reload);
    gulp.watch(paths.src + '/js/**/*.js').on('change', browserSync.reload);

});


//----------------------------------------------------------
// UI Framework - SaaS Processing
//----------------------------------------------------------
gulp.task('sass', function () {
    return gulp.src(paths.src + '/scss/style.scss')
        .pipe(sass())
        .pipe(gulp.dest(paths.src + '/css'))
        .pipe(browserSync.stream());
});

//----------------------------------------------------------
// UI Framework - Build to Shiny(R) package
//----------------------------------------------------------
gulp.task('build', ['build:distR']);

gulp.task('build:distR', function(callback) {
    runSequence('clean:dist',
        'copy:css',
        'copy:img',
        'copy:fonts',
        'copy:js',
        callback);
});

gulp.task('clean:dist', function () {
    return del(paths.distR);
});

gulp.task('copy:css', function() {
    gulp.src(paths.src + '/css/**/*')
        .pipe(gulp.dest(paths.distR + '/css'));
});

gulp.task('copy:img', function() {
    return gulp.src(paths.src + '/img/**/*')
        .pipe(gulp.dest(paths.distR + '/img'));
});

gulp.task('copy:fonts', function() {
    return gulp.src(paths.src + '/fonts/**/*')
        .pipe(gulp.dest(paths.distR + '/fonts'));
});

gulp.task('copy:js', function() {
    return gulp.src(paths.src + '/js/**/*')
        .pipe(gulp.dest(paths.distR + '/js'));
});

//----------------------------------------------------------
// Main Task - R package
//----------------------------------------------------------



