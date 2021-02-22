const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const pugLoader = require('./loaders/pug')
const stylusLoader = require('./loaders/stylus')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('pug', pugLoader)
environment.loaders.prepend('stylus', stylusLoader)

const customConfig = require('./custom/aliases')
environment.config.merge(customConfig)

module.exports = environment
