#global module:false
LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
livereloadMiddleware = (connect, options) ->
  [lrSnippet, connect.static(options.base), connect.directory(options.base)]

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig

    # Metadata.
    pkg: grunt.file.readJSON("package.json")
    connect:
      client:
        options:
          port: 9001
          base: "app/compile"
          keepalive: true
          middleware: livereloadMiddleware

    jade:
      compile:
        options:
          pretty: true
          data:
            debug: false

        files: [
          cwd: "app/jade"
          src: [ "**/*.jade", "!**/_shared/*.jade" ]
          dest: "app/compile"
          expand: true
          ext: ".html"
        ]

    sass:
      dist:
        files:
          "app/compile/css/application.css": "app/sass/application.sass"

    coffee:
      compile:
        files:
          "app/compile/js/application.js": "app/coffee/application.js.coffee"

    autoprefixer:
      single_file:
        options:
          browsers: ["last 2 version", "> 1%", "ie 8", "ie 7"]

        src: "app/compile/css/application.css"
        dest: "app/compile/css/application.css"

    bowercopy:
      options:
        runBower: false
      css:
        options:
          destPrefix: "app/compile/css"
        files:
          'normalize.css': 'normalize-css/normalize.css'
          
      
      js:
        options:
          destPrefix: "app/compile/js"
        files:
          'jquery.min.js': 'jquery/dist/jquery.min.js'
      

    

    csso:
      compress:
        options:
          report: 'min'
        files:
          'app/production/css/application.css' : ['app/production/css/application.css']

    imagemin:
      dynamic:
        files: [
          expand: true
          progressive: true
          interlaced: true
          optimizationLevel: 3
          pngquant: true
          cwd: 'app/compile/img'
          src: ['**/*.{png,jpg,gif}']
          dest: 'app/production/img'
        ]

    concat:
      js:
        src: 'app/compile/js/**/*.js'
        dest: 'app/production/js/application.js'
      css:
        src: 'app/compile/css/**/*.css'
        dest: 'app/production/css/application.css'

    uglify:
      my_target:
        files: [
            expand: true
            cwd: 'app/production/js'
            src: '**/*.js'
            dest: 'app/production/js'
        ]

    watch:
      options:
        livereload: true

      templates:
        files: ["app/jade/*.jade", "app/jade/_shared/*.jade"]
        tasks: ["jade"]

      css:
        files: "app/sass/*.sass"
        tasks: ["sass", "autoprefixer"]

      coffee:
        files: "app/coffee/*.coffee"
        tasks: ["coffee"]

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-bowercopy"
  grunt.loadNpmTasks "grunt-autoprefixer"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-csso"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"

  

  grunt.registerTask "make_production", ["imagemin", "concat", "csso", "uglify"]

  grunt.registerTask "server", "connect"
  grunt.registerTask "default", "watch"
