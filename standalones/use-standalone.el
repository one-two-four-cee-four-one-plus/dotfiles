(defmacro use-standalone (package mode mode-map &rest body)
    `(progn
        (let ((default-directory  "~/.emacs.d/elpa/"))
              (normal-top-level-add-subdirs-to-load-path))

            (menu-bar-mode -1)
            (setq-default mode-line-format nil)

            (require 'smex)
            (smex-initialize)

            (global-set-key (kbd "M-x") 'smex-major-mode-commands)
            (global-set-key (kbd "M-X") 'execute-extended-command)
            (global-set-key (kbd "M-q") (lambda () (interactive) (insert "q")))

            (defun mode-of (b)
                (buffer-local-value 'major-mode b))

            (defun main-standalone-mode-p ()
                (eq (mode-of (current-buffer)) (quote ,mode)))

            (defun main-standalone-mode-alive-p ()
                (seq-some (lambda (b) (eq (mode-of b) (quote ,mode))) (buffer-list)))

            (defun kill-emacs-on-main-standalone-mode-exit ()
                (interactive)
                    (if (or (main-standalone-mode-p) (not (main-standalone-mode-alive-p)))
                        (kill-emacs)
                        (kill-buffer)))

            (require (quote ,package))
            (global-set-key (kbd "q") 'kill-emacs-on-main-standalone-mode-exit)
            (define-key ,mode-map (kbd "q") 'kill-emacs-on-main-standalone-mode-exit)
            (define-key ,mode-map (kbd "M-q") (lambda () (interactive) (insert "q")))
            ,@body))
