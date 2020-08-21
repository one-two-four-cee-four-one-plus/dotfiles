(load-file "~/dotfiles/standalones/use-standalone.el")
(use-standalone erc erc-mode erc-mode-map
  (add-hook 'window-configuration-change-hook 
   '(lambda ()
      (setq erc-fill-column (- (window-width) 2))))
  (erc :server "irc.freenode.net" :nick "weird-ego" :password (read-passwd "passwd: ")))
