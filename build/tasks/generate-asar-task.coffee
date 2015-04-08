asar = require 'asar'
fs = require 'fs'
path = require 'path'

module.exports = (grunt) ->
  {rm} = require('./task-helpers')(grunt)

  grunt.registerTask 'generate-asar', 'Generate asar archive for the app', ->
    done = @async()

    appDir = grunt.config.get('atom.appDir')
    unless fs.existsSync(appDir)
      grunt.log.error 'The app has to be built before generating asar archive.'
      return done(false)

    asar.createPackageWithOptions appDir, path.resolve(appDir, '..', 'app.asar'), {unpack: '*.node'}, (err) ->
      return done(err) if err?
      rm appDir
      done()
