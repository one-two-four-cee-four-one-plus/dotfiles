(load-file "~/dotfiles/standalones/use-standalone.el")

(use-standalone telega telega-root-mode telega-root-mode-map
  (setq telega-symbol-underline-bar "=")
  (setq telega-symbol-heavy-checkmark "☑")
  (setq telega-accounts '(("ego" telega-database-dir "/home/ego/.telega/ego")
                          ("pub" telega-database-dir "/home/ego/.telega/pub")))
  (setq telega-chat-fill-column 100)
  (setq telega-root-fill-column 113)
  (telega))
