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

(use-package evil
  :init (setq evil-want-C-i-jump nil)
  :config (evil-mode 1))

(use-package dired-sidebar
  :commands (dired-sidebar-toggle-sidebar))

;; Themes
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(use-package nord-theme
  :init
  :config
  (load-theme 'nord t))

(set-face-attribute 'default nil :font "Fira Code NFM-12")


(use-package general)
;; Keybinds using generalusing general
(general-create-definer my-leader-def
  :states 'normal
  :prefix "SPC")

(my-leader-def
  "t" 'treemacs)

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
