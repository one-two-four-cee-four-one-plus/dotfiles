(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-all)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-encoding nil)
  :config
  (set-face-attribute 'mode-line nil :family "monofur")
  (display-battery-mode)
  (column-number-mode))

(use-package all-the-icons
  :custom
  (all-the-icons-color-icons nil))
