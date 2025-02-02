function nvimconf --wraps=nvim --description 'alias nvimconf=nvim'
  cd ~/.config/nvim
  nvim init.lua
  cd -
end
