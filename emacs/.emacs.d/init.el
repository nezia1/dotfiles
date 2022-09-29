(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package no-littering
  :config
  (require 'recentf)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory))

(use-package evil
  :init (setq evil-want-C-i-jump nil)
  :config (evil-mode 1))

(use-package dired-sidebar
    :commands (dired-sidebar-toggle-sidebar)
    :config
    (setq dired-sidebar-subtree-line-prefix "__")
    (setq dired-sidebar-theme 'vscode)
    (setq dired-sidebar-use-term-integration t)
    (setq dired-sidebar-use-custom-font t))

(use-package projectile
  :config
  (projectile-mode +1))

;; Themes
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(use-package nord-theme
  :init
  :config
  (load-theme 'nord t))

(set-face-attribute 'default nil :font "Fira Code NFM-12")


(use-package general)
;; Keybinds using generalusing general
(general-define-key 
  :states 'normal
  :prefix "SPC"
  "t" 'dired-sidebar-toggle-sidebar)

(general-define-key
 :prefix "C-c"
 "C-p" 'projectile-command-map)
;; Disable toolbars and scroll bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(if (boundp 'fringe-mode)
(fringe-mode -1))
(if (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; Minimal startup
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; Disable bell
(setq ring-bell-function 'ignore)

;; Line numbers in programming mode
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Enable flymake in programmaing mode
(add-hook 'prog-mode-hook 'flymake-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile use-package nord-theme general evil dired-sidebar))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
