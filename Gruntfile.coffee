module.exports = (grunt) ->
  'use strict'
  # パッケージ読み込み
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # タスク定義
  grunt.initConfig
    # ディレクトリ設定
    dir:
      app: 'src'

    # coffeeコンパイル
    coffee:
      options:
        bare: false #カプセル化する?
        sourceMap: true
      compile:
        expand: true,
        cwd: '<%= dir.app %>/coffee',
        src: ['*.coffee'],
        dest: '<%= dir.app %>/js',
        ext: '.js'

    # js整形
    jsbeautifier:
      options:
        config: '.js-beautify'
      js:
        src: ['<%= dir.app %>/js/*.js']

    # jsチェック
    jshint:
      options:
        jshintrc: '.jshintrc'
      files: ['<%= dir.app %>/js/*.js']

    # ファイルの変更監視
    watch:
      files: ['<%= dir.app %>/coffee/*.coffee']
      tasks: ['coffee', 'jsbeautifier', 'jshint']

  # タスク登録
  grunt.registerTask 'default', ['coffee', 'jsbeautifier', 'jshint', 'watch']
