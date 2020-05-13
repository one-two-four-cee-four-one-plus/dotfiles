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

(use-package ido
  :bind
  ("S-<menu>" . ido-switch-buffer)
  :custom
  (ido-enable-flex-matching t)
  :config
  (ido-mode))

(use-package emacs
  :bind
  (("C-x -" . split-window-below)
   ("C-x |" . split-window-right)
   ("C-w" . backward-kill-word-or-region)
   ("C-u" . backward-kill-line))
  :custom
  (browse-url-generic-program "min")
  (browse-url-browser-function 'browse-url-generic)
  (scroll-conservatively 50)
  (scroll-preserve-screen-position 't)
  (scroll-margin 10)
  :config
  ;; (global-unset-key (kbd "<left>"))
  ;; (global-unset-key (kbd "<right>"))
  ;; (global-unset-key (kbd "<up>"))
  ;; (global-unset-key (kbd "<down>"))
  ;; (global-unset-key (kbd "M-x"))
  ;; (global-unset-key (kbd "C-x b"))
  (define-key key-translation-map [?\C-h] [?\C-?])
  (add-hook 'after-save-hook 'delete-trailing-whitespace)
  (setq-default indent-tabs-mode nil)
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
      (kill-line (- (or arg 0)))))
  (defun sudo ()
    (interactive)
    (when buffer-file-name
      (find-alternate-file (concat "/sudo:root@localhost:"
                                   buffer-file-name)))))

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

(use-package cus-edit
  :ensure nil
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :init
  (load custom-file :noerror))

(use-package eshell
  :hook
  (eshell . (lambda () (scroll-margin 10))))

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

;; (use-package ivy
;;   :ensure t
;;   :custom
;;   (enable-recursive-minibuffers t)
;;   :bind
;;   (("S-<menu>" . ivy-switch-buffer))
;;   :config
;;   (ivy-mode 1))

(use-package swiper
  :bind
  (("C-s" . swiper)))

(use-package smex
  :config
  (smex-initialize)
  :bind
  (("<menu>" . smex)
   ("M-<menu>" . smex-major-mode-commands)))

;; (use-package counsel
;;   :bind
;;   (("C-x C-f" . counsel-find-file)
;;    ("C-x d" . counsel-dired)
;;    ("<f1> f" . counsel-describe-function)
;;    ("<f1> v" . counsel-describe-variable)
;;    ("<f2> u" . counsel-unicode-char)
;;    ("<f2> i" . counsel-info-lookup-symbol)))

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
  (treemacs-indentation 2)
  (treemacs-width 16)
  :bind (:map global-map
              ("C-c t" . treemacs)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package magit
  :ensure t)

(use-package undo-tree)

(use-package hydra
  :config
  ;; todo add nesting and more shortcuts
  (defhydra hydrant (:hint nil)
    "
    ^Treemacs^            ^Magit^
    _a_: add project      _b_: checkout
    _r_: remove project
    "
    ("a" treemacs-add-project-to-workspace)
    ("r" treemacs-remove-project-from-workspace)
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
  (telega-symbol-underline-bar "·")
  (telega-symbol-heavy-checkmark "☑")
  (telega-accounts '(("ego" telega-database-dir "/home/ego/.telega/ego")
                     ("pub" telega-database-dir "/home/ego/.telega/pub")))
  :config
  (defun anti-junk (msg)
    (let ((id (plist-get msg :sender_user_id)))
      (when (or (= id 365542142)
                (= id 646134594))
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

;; look
;(use-package jazz-theme)
;(use-package majapahit-theme)
(use-package sublime-themes)

;(load-file "~/.emacs.d/doom-modeline-config.el")
(load-file "~/.emacs.d/minimalism.el")

(custom-set-faces
 '(default ((t (:family "Monofur Nerd Font Mono" :foundry "unci" :slant normal :weight normal :height 218 :width normal)))))

;;; language specific

;(use-package flycheck
                                        ;  :hook python-mode)
(use-package elpy
  :config
  (delete `elpy-module-highlight-indentation elpy-modules))

;;js
(use-package js2-mode
  :config
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;;py
(use-package elpy)
(use-package virtualenvwrapper
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))
