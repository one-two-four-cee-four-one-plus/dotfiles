(load-file "~/dotfiles/standalones/use-standalone.el")

(use-standalone org org-mode org-mode-map
  (add-hook 'find-file-hook 'read-only-mode))
