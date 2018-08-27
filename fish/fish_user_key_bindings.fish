function fish_user_key_bindings
    fzf_key_bindings
end

bind \cg '__ghq_cd_repository'
if bind -M insert >/dev/null ^/dev/null
  bind -M insert \cg '__ghq_cd_repository'
end
