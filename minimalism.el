(defun mode-line-render (left right)
  (let ((available-width (- (window-total-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))

(set-frame-parameter (selected-frame) 'internal-border-width 20)
(setq x-underline-at-descent-line t)
(setq-default line-spacing 0)
(set-default 'cursor-type  '(hbar . 3))
(blink-cursor-mode 1)
(fringe-mode '(0 . 0))
(setq-default battery-mode-line-format "{%p}")

(setq-default header-line-format
  '(:eval (mode-line-render
           (format-mode-line
            (list
             "%b "
             '(:eval (if (and buffer-file-name (buffer-modified-p))
                         "(modified)"))))

           (format-mode-line
            (list
             "%3l:%2c "
             mode-line-misc-info
             " ")))))

(setq-default mode-line-format nil)

(let ((fg (face-attribute 'default :foreground))
      (bg (face-attribute 'default :background)))

  (set-face-attribute 'header-line nil
                      :height 220
                      :background bg
                      :underline nil
                      :foreground fg
                      :box `(:line-width 3 :color ,bg :style nil)))

  ;; (set-face-attribute 'mode-line nil
  ;;                     :height 10
  ;;                     :underline nil
  ;;                     :background bg
  ;;                     :box nil)

  ;; (set-face-attribute 'mode-line-inactive nil
  ;;                     :box nil
  ;;                     :inherit 'mode-line)

  ;; (set-face-attribute 'mode-line-buffer-id nil
  ;;                     :weight 'light))
