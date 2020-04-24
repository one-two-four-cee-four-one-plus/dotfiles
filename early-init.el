;;; early-init.el --- early configurations -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

(defvar old--gc-cons-threshold gc-cons-threshold)
(defvar old--gc-cons-percentage gc-cons-percentage)
(defvar old--file-name-handler-alist file-name-handler-alist)

(setq-default gc-cons-threshold 402653184
	      gc-cons-percentage 0.6
	      inhibit-compacting-font-caches t
	      message-log-max 16384
	      file-name-handler-alist nil)

(add-hook 'after-init-hook
	  (lambda ()
	    (setq gc-cons-threshold old--gc-cons-threshold
		  gc-cons-percentage old--gc-cons-percentage
		  file-name-handler-alist old--file-name-handler-alist)))

(defvar package--init-file-ensured)
(setq package-enable-at-startup nil
      package--init-file-ensured t)

(provide 'early-init)
