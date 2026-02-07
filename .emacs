;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(display-line-numbers-type 'relative)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)










;Dashboard Set Up


(require 'dashboard)
(setq dashboard-startup-banner 'official
      dashboard-center-content nil
      dashboard-display-icons-p t
      dashboard-icon-type 'nerd-icons
      dashboard-set-heading-icons t
      dashboard-set-file-icons t)

(dashboard-setup-startup-hook)

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq dashboard-projects-backend 'projectile))

(use-package page-break-lines
  :ensure t
  :config
  (global-page-break-lines-mode))

(setq dashboard-items
      '((recents  . 10)   ;; show 10 recent files
        (agenda   . 5)    ;; show 5 agenda items (TODO/deadline/schedule)
        (projects . 10)   ;; show recent projects
        (bookmarks . 5))) ;; optional bookmarks


(use-package nerd-icons
  :ensure t)

(setq org-agenda-files
      '("~/Programming/org/tasks.org"))

(setq projectile-project-search-path '(("~/Programming/c/projects" . 2)))

(setq dashboard-startup-banner "~/Downloads/cat.png")
(setq dashboard-image-banner-max-width 200)




;; Telescope
(use-package vertico
  :init
  (vertico-mode 1))

(use-package orderless
  :init
  ;; Allow orderless (fuzzy) matching
  (setq completion-styles '(orderless basic))
  ;; Improve performance and allow simple wildcard behavior
  (setq completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind
  ;; Quickly find files recursively
  ("C-c f" . consult-find)
  ;; Handy: search file contents too
  ("C-c r" . consult-ripgrep))

(use-package marginalia
  :hook (after-init . marginalia-mode))




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
(global-set-key (kbd "C-c d l") 'duplicate-line)
(electric-pair-mode 1)
(setq inhibit-splash-screen t)

(setq c-default-style "linux"
      c-basic-offset 4)
;; --------------------
;; simpc-mode setup
;; --------------------

;; Allow Emacs to find simpc-mode.el
(add-to-list 'load-path "~/.emacslocal/")

;; Load simpc-mode
;(require 'simpc-mode)

;; Use simpc-mode for C / C++ files
;(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; --------------------
;; clang-format setup
;; --------------------

;(defun my/simpc-clang-format-buffer ()
;  "Format the current buffer with the clang-format binary."
;  (interactive)
;  (when (executable-find "clang-format")
    ;; Save current point so we don't jump around
;    (let ((current-point (point)))
      ;; Run clang-format on the whole buffer in place
;      (shell-command-on-region (point-min) (point-max)
;                               "clang-format"
;                               nil t)
;      (goto-char current-point))))

;; Auto-format on save (simpc-mode only)
;(add-hook 'simpc-mode-hook
;          (lambda ()
;            (add-hook 'before-save-hook
;                      #'my/simpc-clang-format-buffer
;                      nil
;                      t)))

;; Manual format command: C-c f c (simpc-mode only)
;(with-eval-after-load 'simpc-mode
;  (define-key simpc-mode-map (kbd "C-c f c")
;    #'my/simpc-clang-format-buffer))


(require 'tree-sitter)
(require 'tree-sitter-langs)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
