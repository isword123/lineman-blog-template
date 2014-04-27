###
Overrides the default lineman-blog markdown settings. To see what the defaults
are, try running `lineman config markdown` or looking in:
  node_modules/lineman-blog/config/plugins/markdown.coffee
###
module.exports = (lineman) ->
  config:
    markdown:
      options:
        author: "Zhijian Xia"
        title: "Zhijian's Blog"
        description: "Where I post my learning and feelings"
        url: "http://www.zhijian.me"
        rssCount: 10 #<-- remove, comment, or set to zero to disable RSS generation
        #disqus: "my_disqus_name" #<-- uncomment and set your disqus account name to enable disqus support

      dev:
        dest: "generated"
        context:
          js: "../js/app.js"
          css: "../css/app.css"
