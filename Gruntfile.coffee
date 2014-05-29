module.exports = (grunt) ->
  require('load-grunt-tasks') grunt
  path = require 'path'

  config =
    connect_port: 8000
    livereload_port: 35729
    app: 'app'
    dist: 'dist'
    prod: 'prod'
    js: 'js'
    test: 'test'
    coffee: 'coffee'

  grunt.initConfig
    config: config

    coffee:
      dist:
        expand: true
        cwd: config.app
        src: ['**/*.coffee']
        dest: config.dist
        ext: '.js'

      test:
        expand: true
        cwd: path.join config.test, config.coffee
        dest: path.join config.test, config.js
        src: ['**/*.coffee']
        ext: '.js'


    less:
      dist:
        options:
          paths: ['<%= config.app %>/style']
        files:
          '<%= config.dist %>/style/main.css': '<%= config.app %>/style/main.less'


    copy:
      dist:
        expand: true
        cwd: config.app
        src: ['**/*.html']
        dest: config.dist


    jasmine:
      dist:
        src: '<%= config.dist %>/**/*.js'
        options:
          specs: '<%= config.test %>/<%= config.js %>/*_spec.js'


    watch:
      app:
        options:
          livereload: config.livereload_port
        files: '<%= config.app %>/**/*.{coffee,less}'
        tasks: ['coffee:dist', 'less:dist']

      static:
        options:
          livereload: config.livereload_port
        files: ['<%= config.app %>/*.html', '<%= config.app %>/**/*.html']
        tasks: ['copy:dist']

      test:
        options:
          livereload: config.livereload_port
        files: '<%= config.test %>/**/*.coffee'
        tasks: ['coffee:test', 'jasmine']


    open:
      dev:
        path: "http://localhost:#{config.connect_port}/"


    connect:
      server:
        options:
          port: config.connect_port
          hostname: '*'
          base: config.dist


    clean:
      dist: config.dist
      test: path.join config.test, config.js


  grunt.registerTask 'dist', ['clean:dist', 'coffee:dist', 'less:dist', 'copy:dist']
  grunt.registerTask 'test', ['dist', 'clean:test', 'coffee:test', 'jasmine']

  grunt.registerTask 'default', ['dist', 'connect', 'open', 'watch']
