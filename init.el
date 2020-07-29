(unless (featurep 'early-init)
  (load (expand-file-name "early-init" user-emacs-directory)))

(defvar package-archives)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(when (version= emacs-version "26.2")
  (defvar gnutls-algorithm-priority)
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ido
  :ensure t
  :defer nil
  :bind
  (("<s-menu>" . ido-switch-buffer)
   ("C-x b"    . ido-switch-buffer))
  :custom
  (ido-enable-flex-matching t)
  :config
  (ido-mode)
  (ido-everywhere))

(use-package dired-hide-dotfiles
  :ensure t
  :defer t
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (define-key dired-mode-map "." #'dired-hide-dotfiles-mode))

(use-package emacs
  :bind
  (("C-x -"  . split-window-below)
   ("C-x |"  . split-window-right)
   ("C-w"    . backward-kill-word-or-region)
   ("C-u"    . backward-kill-line)
   ("<f4>"   . generic-apply-macro)
   ("C-h"    . backward-delete-char)
   ("C-a"    . smarter-move-beginning-of-line))
  :hook (find-file . fancy-scrolling-mode)
  :custom
  (browse-url-generic-program "min")
  (browse-url-browser-function 'browse-url-generic)
  :config
  (defadvice kill-ring-save (before slick-copy activate compile)
    (interactive
     (if mark-active (list (region-beginning) (region-end))
       (message "Copied line")
       (list (line-beginning-position)
             (line-beginning-position 2)))))

  (defadvice kill-region (before slick-cut activate compile)
    (interactive
     (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
             (line-beginning-position 2)))))

  (defun generic-apply-macro ()
    (interactive)
    (if (use-region-p)
        (let ((top (region-beginning))
              (bot (region-end)))
          (apply-macro-to-region-lines top bot))
      (kmacro-end-or-call-macro 1)))

  (defun fancy-scrolling-mode ()
    (interactive)
    (if buffer-file-name
        (progn
          (make-local-variable 'scroll-conservatively)
          (make-local-variable 'scroll-preserve-screen-position)
          (make-local-variable 'scroll-margin)
          (setq scroll-conservatively 50)
          (setq scroll-preserve-screen-position 't)
          (setq scroll-margin 10))))

  (defun smarter-move-beginning-of-line (arg)
    (interactive "^p")
    (setq arg (or arg 1))
    (when (/= arg 1)
      (let ((line-move-visual nil))
        (forward-line (1- arg))))
    (let ((orig-point (point)))
      (back-to-indentation)
      (when (= orig-point (point))
        (move-beginning-of-line 1))))

  (put 'dired-find-alternate-file 'disabled nil)
  (keyboard-translate ?\C-h ?\C-?)
  (add-hook 'after-save-hook 'delete-trailing-whitespace)
  (setq-default indent-tabs-mode nil)
  (global-eldoc-mode 1)
  (menu-bar-mode -1)
  (when window-system
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (blink-cursor-mode 0))

  (defun backward-kill-word-or-region (&optional count)
    (interactive "p")
    (if (use-region-p)
        (kill-region (region-beginning) (region-end))
      (backward-kill-word count)))

  (defun backward-kill-line (&optional arg)
    (interactive "p")
    (if (bolp)
        (delete-char -1 :kill)
      (kill-line (- (or arg 0))))))

(use-package term ;; todo coloring
  :ensure nil
  :bind (:map term-mode-map
              ("M-p" . term-send-up)
              ("M-n" . term-send-down)))

(use-package paren
  :ensure nil
  :defer nil
  :bind (:map global-map
              ("<C-menu> p" . show-paren-mode))
  :custom
  (show-paren-style 'expression))

(use-package whitespace
  :ensure nil
  :bind (:map global-map
              ("<C-menu> w" . whitespace-mode)))

(use-package files
  :ensure nil
  :custom
  (version-control t)
  (kept-new-versions 42)
  (kept-old-versions 0)
  (delete-old-versions t)
  (backup-by-copying t)
  (create-lockfiles nil)
  (backup-directory-alist '(("." . "/home/ego/.cache/emacs-backups")))
  (auto-save-file-name-transforms '((".*" "/home/ego/.cache/emacs-backups/" t))))

(use-package subr
  :no-require t
  :ensure nil
  :init
  (fset 'yes-or-no-p 'y-or-n-p))

(use-package cus-edit
  :ensure nil
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :init
  (load custom-file :noerror))

(use-package startup
  :no-require t
  :ensure nil
  :custom
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message ""))

(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

(use-package uniquify
  :ensure nil
  :custom (uniquify-buffer-name-style 'forward))

(use-package swiper
  :bind
  (("C-s" . swiper)))

(use-package smex
  :config
  (smex-initialize)
  :bind
  (("<menu>" . smex)
   ("M-<menu>" . smex-major-mode-commands)))

(use-package counsel
  :bind
  (("<f1> f" . counsel-describe-function)
   ("<f1> v" . counsel-describe-variable)
   ("<f1> s" . counsel-describe-symbol)
   ("<f1> b" . counsel-descbinds)
   ("<f2> u" . counsel-unicode-char)
   ("<f2> i" . counsel-info-lookup-symbol)))

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1))

(use-package company
  :custom
  (company-idle-delay nil)
  ;(company-minimum-prefix-length 100)
  ;(company-frontends '(my-company-frontend))
  :bind (:map global-map
              ("<M-tab>" . company-complete))
  :config
  ;; (defun my-company-frontend (command)
  ;;   (when (and (eq command 'post-command) company-candidates)
  ;;     (if (> (length company-candidates) 1)
  ;;         (let ((winner (ido-completing-read "" company-candidates nil nil company-common)))
  ;;           (company--insert-candidate winner))
  ;;       (company--insert-candidate (car company-candidates)))
  ;;     (company-cancel)))
  (global-company-mode))

(use-package projectile
  :ensure t)

(use-package centered-window
  :config
  (centered-window-mode))

(use-package treemacs
  :ensure t
  :defer t
  :custom
  (treemacs-indentation 2)
  (treemacs-width 20)
  (treemacs-no-png-images t)
  :bind (:map global-map
              ("<C-menu> t" . treemacs)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package magit  ;; todo adopt
  :ensure t
  :bind (:map global-map
              ("<C-menu> m" . magit)))

(use-package undo-tree
  :hook (find-file . undo-tree-mode)
  :bind (:map global-map
         ("<C-menu> v" . undo-tree-visualize)))

(use-package telega
  :ensure t
  :init
  (defalias 'tg 'telega-account-switch)
  :bind (:map telega-chat-mode-map
              ("C-c l" . telega-save-msg-link-to-kill-ring)
              ("C-c a" . telega-account-switch)
              ("C-c q" . telega-kill)
         :map telega-root-mode-map
              ("C-c a" . telega-account-switch)
              ("C-c q" . telega-kill))
    :custom
  (telega-symbol-underline-bar "=")
  (telega-symbol-heavy-checkmark "☑")
  (telega-accounts '(("ego" telega-database-dir "/home/ego/.telega/ego")
                     ("pub" telega-database-dir "/home/ego/.telega/pub")))
  :config
  (defun anti-junk (msg)
    (let ((id (plist-get msg :sender_user_id)))
      (when (or (= id 365542142))
        (telega-msg-ignore msg))))
  (add-hook 'telega-chat-insert-message-hook 'anti-junk)
  (global-telega-squash-message-mode 1)
  (defun telega-save-msg-link-to-kill-ring ()
    (interactive)
    (let* ((msg     (telega-msg-at (point)))
           (msg-id  (plist-get msg :id))
           (chat-id (plist-get msg :chat_id))
           (chat    (telega-chat-get chat-id))
           (link (ignore-errors
                   (cond ((telega-chat-public-p chat 'supergroup)
                          (telega--getPublicMessageLink chat-id msg-id))
                         ((eq (telega-chat--type chat 'no-interpret) 'supergroup)
                          (telega--getMessageLink chat-id msg-id))))))
      (when link
        (prin1 link)
        (kill-new link nil))))
  (unless window-system
    (setq telega-use-images nil)))

(use-package hardcore-mode
  :config
  (global-hardcore-mode))

(use-package avy  ;; todo: bind more
  :defer nil
  :bind (:map global-map
              ("C-," . avy-goto-word-1)
              ("C-." . avy-goto-line))
  :config
  (defun avy-actions-advice (&rest whatever)
    (prin1 "? for more actions"))
  (advice-add 'avy-goto-word-1 :after #'avy-actions-advice)
  (advice-add 'avy-goto-line :after #'avy-actions-advice))

(use-package visual-regexp)

(use-package focus
  :bind (:map global-map
              ("<C-menu> f" . focus-mode))
  :config
  (global-unset-key (kbd "C-c C-q")))

(use-package hl-line
  :ensure nil
  :bind (:map global-map
              ("<C-menu> h" . hl-line-mode)))

(use-package beacon
  :config
  (beacon-mode 1))

(use-package rainbow-mode
  :defer t
  :ensure t)

(use-package yasnippet) ;; todo customize

(use-package dimmer
  :defer nil
  :bind (:map global-map
              ("<C-menu> d" . dimmer-mode))
  :custom
  (dimmer-fraction  0.4)
  :config
  (dimmer-configure-which-key))

(use-package which-key
  :custom
  (which-key-popup-type 'side-window)
  (which-key-sort-order 'which-key-local-then-key-order)
  (which-key-idle-delay 1)
  (which-key-paging-prefixes '("C-x" "C-c"))
  (which-key-paging-key "<f5>")
  :config
  (which-key-mode))

;; (use-package tramp ) todo config

;; (use-package org) todo configte

(use-package abbrev
  :ensure nil)

(use-package life
  :ensure nil)

;; look
;; (use-package jazz-theme)
;; (use-package majapahit-theme)
;; (use-package sublime-themes)
;; (use-package silkworm-theme)

;(load-file "~/.emacs.d/doom-modeline-config.el")
;(load-file "~/.emacs.d/minimalism.el")
(load-file "~/.emacs.d/elegance.el")


;;; language/techology specific

;; lisps


;;js
(use-package js2-mode
  :config
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;;py
(use-package elpy
  :config
  (delete `elpy-module-highlight-indentation elpy-modules))

(use-package virtualenvwrapper
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

;; sql
(use-package sqlup-mode
  :hook sql-mode)

;; REST
(use-package restclient
  :mode ("\\.\\(http\\|rest\\)$" . restclient-mode))

(use-package company-restclient
  :after restclient
  :config
  (add-to-list 'company-backends 'company-restclient))
