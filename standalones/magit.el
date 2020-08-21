(load-file "~/dotfiles/standalones/use-standalone.el")

(use-standalone magit magit-status-mode magit-mode-map 
  (magit)
  (delete-other-windows))
