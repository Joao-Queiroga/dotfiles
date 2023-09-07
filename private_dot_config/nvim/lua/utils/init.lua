local utils = {}
setmetatable(utils, {
  __index = function(_, key)
    return require('utils.' .. key)
  end
})
return utils
