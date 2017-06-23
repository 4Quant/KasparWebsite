import gulp, { dest, src } from 'gulp';

import autoprefixer from 'gulp-autoprefixer';
import babelify from 'babelify';
import browserify from 'browserify';
import buffer from 'vinyl-buffer';
import cleancss from 'gulp-clean-css';
import gutil from 'gulp-util';
import rename from 'gulp-rename';
import runSequence from 'run-sequence';
import sass from 'gulp-sass';
import source from 'vinyl-source-stream';
import sourcemaps from 'gulp-sourcemaps';
import uglify from 'gulp-uglify';

const config = {
  js: {
    src: 'source/javascripts/**/*.js',
    srcFilename: 'site.js',
    dstDirname: '.tmp/dist/javascripts',
    dstFilename: 'concat.js',
    libs: [],
  },
  sass: {
    src: 'source/stylesheets/**/*.sass',
    dstDirname: '.tmp/dist/stylesheets',
    includepaths: [
      // include sass libs for import
    ]
  },
  fonts: {
    src: 'source/fonts/**/*.{eot,svg,ttf,woff,woff2}',
    npmFonts: [
      'node_modules/lato-webfont/fonts/Lato-*.{eot,svg,woff,woff2,ttf}',
      'node_modules/typeface-playfair-display/files/*.{eot,svg,woff,woff2,ttf}'
    ],
    dstDirname: '.tmp/dist/fonts',
  },
};

gulp.task('fonts', () => (
  src(config.fonts.npmFonts)
  .pipe(dest(config.fonts.dstDirname))
));

gulp.task('jquery', () => (
  src([
    'node_modules/jquery/dist/jquery.min.js'
  ])
  .pipe(dest(config.js.dstDirname))
));

// Tasks for development

// Styles
gulp.task('sass', () => (
  src(config.sass.src)
    .pipe(sourcemaps.init())
    .pipe(sass({
      outputStyle: 'expanded',
      sourceComments: true,
      sourceMap: true,
      sourceMapContents: true,
      sourceMapEmbed: true,
      indentedSyntax: true,
      includePaths: config.sass.includepaths,
    }).on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false,
    }))
    .pipe(sourcemaps.write('.'))
    .pipe(dest(config.sass.dstDirname))
    .pipe(cleancss({ compatibility: '*', rebase: false }))
    .pipe(rename({ basename: 'site', extname: '.min.css' }))
    .pipe(dest(config.sass.dstDirname))
));


const handleBrowserify = () => (
  browserify({
    entries: './source/javascripts/site.js',
    debug: true
  })
    .transform(babelify)
    .on('error', gutil.log)
    .bundle()
    .on('error', gutil.log)
    .pipe(source('site.js'))
);

gulp.task('browserify', () => (
  handleBrowserify()
    .pipe(buffer())
    .pipe(dest(config.js.dstDirname))
    .pipe(uglify())
    .pipe(rename({basename: 'site', extname: '.min.js'}))
    .pipe(dest(config.js.dstDirname))
));

gulp.task('scripts', ['browserify'], () => (
	src(config.js.dstDirname+'/site.js')
    .pipe(dest(config.js.dstDirname))
));
// Executions
gulp.task('default', () => {
  runSequence(['sass', 'browserify', 'fonts', 'jquery']);
});

gulp.task('sass-watch', () => {
  gulp.watch(config.sass.src, ['sass']);
});

gulp.task('watch', () => {
  gulp.watch(config.sass.src, ['sass']);
  gulp.watch(config.js.src, ['browserify']);
});

gulp.task('build', () => (
  runSequence(['sass', 'browserify', 'fonts', 'jquery'])
));

