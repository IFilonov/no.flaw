const path = require('path');

module.exports = {
  resolve: {
    alias: {
      notifications$: path.resolve(process.cwd(), `app/javascript/noflaw/mixins/notifications`)
    }
  }
}
