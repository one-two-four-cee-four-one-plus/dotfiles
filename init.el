(unless (featurep 'early-init)
  (load (expand-file-name "early-init" user-emacs-directory)))

(defvar package-archives)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")))

(when (version= emacs-version "26.2")
  (defvar gnutls-algorithm-priority)
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package emacs
  :bind
  (("C-x -" . split-window-below)
   ("C-x |" . split-window-right)))

(use-package files
  :ensure nil
  :custom
  (backup-by-copying t)
  (create-lockfiles nil)
  (backup-directory-alist '(("." . "~/.cache/emacs-backups")))
  (auto-save-file-name-transforms '((".*" "~/.cache/emacs-backups/" t))))

(use-package subr
  :no-require t
  :ensure nil
  :init
  (fset 'yes-or-no-p 'y-or-n-p))

(setq-default indent-tabs-mode nil)

(use-package cus-edit
  :ensure nil
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :init
  (load custom-file :noerror))

(defvar disabled-commands (expand-file-name ".disabled.el" user-emacs-directory)
  "File to store disabled commands, that were enabled permamently.")
(defadvice en/disable-command (around put-in-custom-file activate)
  "Put declarations in disabled.el."
  (let ((user-init-file disabled-commands))
    ad-do-it))
(load disabled-commands :noerror)

(use-package startup
  :no-require t
  :ensure nil
  :custom
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message ""))

(use-package startup
  :no-require t
  :ensure nil
  :custom
  (inhibit-splash-screen t))

(menu-bar-mode -1)

;;; todo customize modeline

(use-package uniquify
  :ensure nil
  :custom (uniquify-buffer-name-style 'forward))

(use-package ivy
  :init
  (setq enable-recursive-minibuffers t)
  :bind
  (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1))

(use-package swiper
  :bind
  (("C-s" . swiper)))

(use-package smex
  :config
  (smex-initialize)
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))

(use-package counsel
  :bind
  (("C-x C-f" . counsel-find-file)
   ("C-x d" . counsel-dired)
   ("<f2> u" . counsel-unicode-char)))

(use-package company
  :config
  (global-company-mode))

(use-package projectile
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (setq treemacs-indentation 2))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package magit
  :ensure t)

(use-package flx)

(use-package undo-tree)

(use-package hydra
  :bind (("C-h" . hydrant/body))
  :config

  (defun ego--collapse ()
    (treemacs-select-window)
    (treemacs-collapse-all-projects))

  ;; todo add nesting and more shortcuts
  (defhydra hydrant (:hint nil)
    "
    ^Treemacs^            ^Magit^
    _a_: add project      _b_: checkout
    _r_: remove project
    _c_: collapse
    _s_: select
    "
    ("a" treemacs-add-project-to-workspace)
    ("r" treemacs-remove-project-from-workspace)
    ("c" (ego--collapse))
    ("s" (centaur-tabs-counsel-switch-group))
    ("b" magit-checkout)
    ("q" nil "quit")))
