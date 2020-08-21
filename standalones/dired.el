(load-file "~/dotfiles/standalones/use-standalone.el")
(use-standalone dired dired-mode dired-mode-map
  (require 'dired-hide-dotfiles)
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map "." #'dired-hide-dotfiles-mode)
  (add-hook 'dired-mode-hook 'dired-hide-dotfiles-mode)
  (add-hook 'find-file-hook 'read-only-mode)
  (dired default-directory))
