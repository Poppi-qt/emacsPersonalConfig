;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(display-line-numbers-type 'relative))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )










;; My custom stuff
;; --------------------
;; UI / Font
;; --------------------

(set-face-attribute 'default nil
                    :family "Hack"
                    :height 138)


(menu-bar-mode -1)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(ido-mode 1)
(ido-everywhere 1)

;; --------------------
;; simpc-mode setup
;; --------------------

;; Allow Emacs to find simpc-mode.el
(add-to-list 'load-path "~/.emacslocal/")

;; Load simpc-mode
(require 'simpc-mode)

;; Use simpc-mode for C / C++ files
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; --------------------
;; clang-format setup
;; --------------------

(defun my/simpc-clang-format-buffer ()
  "Format the current buffer with the clang-format binary."
  (interactive)
  (when (executable-find "clang-format")
    ;; Save current point so we don't jump around
    (let ((current-point (point)))
      ;; Run clang-format on the whole buffer in place
      (shell-command-on-region (point-min) (point-max)
                               "clang-format"
                               nil t)
      (goto-char current-point))))

;; Auto-format on save (simpc-mode only)
(add-hook 'simpc-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      #'my/simpc-clang-format-buffer
                      nil
                      t)))

;; Manual format command: C-c f c (simpc-mode only)
(with-eval-after-load 'simpc-mode
  (define-key simpc-mode-map (kbd "C-c f c")
    #'my/simpc-clang-format-buffer))
