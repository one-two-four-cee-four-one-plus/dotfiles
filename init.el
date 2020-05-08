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
   ("C-x |" . split-window-right))
  :custom
  (browse-url-generic-program "min")
  (browse-url-browser-function 'browse-url-generic))

(use-package files
  :ensure nil
  :custom
  (backup-by-copying t)
  (create-lockfiles nil)
  (backup-directory-alist '(("." . "/home/ego/.cache/emacs-backups")))
  (auto-save-file-name-transforms '((".*" "/home/ego/.cache/emacs-backups/" t))))

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
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (blink-cursor-mode 0)
  (set-face-attribute 'default t 
                      :family "monofur"
                      :foundry "unknown"
                      :slant 'normal
                      :weight 'normal
                      :height 100
                      :width 'normal)
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;;; todo customize modeline

(use-package uniquify
  :ensure nil
  :custom (uniquify-buffer-name-style 'forward))

(use-package ivy
  :custom
  (enable-recursive-minibuffers t)
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
  :custom
  (company-idle-delay nil)
  :config
  (global-company-mode 1))

(use-package projectile
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :custom
  (treemacs-indentation 2))

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

(use-package telega
  :init
  (defalias 'tg 'telega-account-switch)
  (defalias 'tgq 'telega-kill)
  :bind
  (("C-c a" . telega-account-switch)
   ("C-c l" . telega-save-msg-link-to-kill-ring))
  :custom
  (telega-symbol-heavy-checkmark "☑")
  (telega-accounts '(("ego" telega-database-dir "/home/ego/.telega/ego")
                     ("pub" telega-database-dir "/home/ego/.telega/pub")))
  :config
  (defun anti-junk (msg)
    (let ((id (plist-get msg :sender_user_id)))
      (when (or (= id 365542142)
                (= id 646134594))
        (telega-msg-ignore msg))))
  (defun advice-filter-history (messages)
    (mapcar #'anti-junk messages))
  (advice-add 'telega-chatbuf--append-messages
              :before #'advice-filter-history)
  (advice-add 'telega-chatbuf--prepend-messages
              :before #'advice-filter-history)
  (add-hook 'telega-chat-pre-message-hook 'anti-junk)
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

(use-package jazz-theme
  :ensure t
  :config
  (load-theme 'jazz t))
