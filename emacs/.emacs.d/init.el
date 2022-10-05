;; straight.el setup
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(use-package straight
             :custom (straight-use-package-by-default t))

(use-package no-littering
  :config
  (require 'recentf)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory))

(use-package evil
  :init
  (setq evil-want-C-i-jump nil)
  (setq evil-want-keybinding nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :config(evil-collection-init))

(use-package vscode-icon)
(use-package dired-sidebar
    :commands (dired-sidebar-toggle-sidebar)
    :config
    (setq dired-sidebar-subtree-line-prefix "__")
    (setq dired-sidebar-theme 'vscode)
    (setq dired-sidebar-use-term-integration t)
    (setq dired-sidebar-use-custom-font t))

(use-package projectile
  :config
  (projectile-register-project-type 'npm '("package.json")
    :project-file "package.json"
    :compile "npm install"
    :test "npm test"
    :run "npm start"
    :test-suffix ".spec")
  (projectile-mode +1))
(setq projectile-project-search-path '(("~/dev" . 3)))

(use-package magit)
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
  :prefix "C-x"
  "t" 'dired-sidebar-toggle-sidebar
  "p" 'projectile-command-map
  "g" 'magit)

(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))
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
    (vscode-icon projectile use-package nord-theme general evil dired-sidebar))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
