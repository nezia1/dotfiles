(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(if (< emacs-major-version 30)
    (unless (package-installed-p 'vc-use-package)
      (package-vc-install "https://github.com/slotThe/vc-use-package"))
  (require 'vc-use-package))

(add-hook 'org-mode-hook
	  (lambda () (add-hook 'after-save-hook #'org-babel-tangle
			       :append :local)))

(use-package no-littering)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "/usr/bin/fish --login -c 'string join : $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

(setq ring-bell-function 'ignore)

;; Set base fonts
(set-face-attribute 'default nil :font "sans-serif" :height 125)
(set-face-attribute 'fixed-pitch nil :font "monospace" :height 125)

;; set monospace for specific org mode elements
(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598")))))

(use-package fixed-pitch
  :vc ( :fetcher github :repo cstby/fixed-pitch-mode))

(use-package ligature
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures '(prog-mode tsx-ts-mode) '("--" "---" "==" "===" "!=" "!==" "=!="
						     "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
						     "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
						     "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
						     "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
						     "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
						     "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
						     "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
						     "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
						     "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
						     "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
						     ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
						     "<:<" ";;;"))
  (global-ligature-mode t))

(global-visual-line-mode t)

(use-package catppuccin-theme
  :init
  (setq catppuccin-flavor 'frappe)
  :config
  (load-theme 'catppuccin :no-confirm))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 30))

(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
		  (replace-regexp-in-string
		   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
		   crm-separator)
		  (car args))
	  (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Support opening new minibuffers from inside existing minibuffers.
  (setq enable-recursive-minibuffers t)

  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (setq read-extended-command-predicate #'command-completion-default-include-p))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package which-key
  :config
  (which-key-mode))

(use-package elcord
  :config
  (elcord-mode))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

(use-package eglot
  :bind (:map eglot-mode-map
		("C-c C-d" . eldoc)
		("C-c C-e" . eglot-rename)
		("C-c C-o" . python-sort-imports)
		("C-c C-f" . eglot-format-buffer))
  :hook ((tsx-ts-mode . eglot-ensure)
	 (typescript-ts-mode . eglot-ensure)))

;; makes eglot faster using a rust wrapper, needs to be in PATH
(use-package eglot-booster
    :vc (:fetcher github :repo jdtsmith/eglot-booster)
  :after eglot
  :config
  (eglot-booster-mode))

(use-package corfu
  :custom
  (corfu-auto t)
  :init
  (global-corfu-mode)
  (setq corfu-popupinfo-delay 0.2)
  (corfu-popupinfo-mode))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :bind (:map yas-minor-mode-map
	      ("C-c C-e" . yas-expand)))

(use-package magit)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(cmake "https://github.com/uyha/tree-sitter-cmake")
	(css "https://github.com/tree-sitter/tree-sitter-css")
	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
	(go "https://github.com/tree-sitter/tree-sitter-go")
	(html "https://github.com/tree-sitter/tree-sitter-html")
	(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	(json "https://github.com/tree-sitter/tree-sitter-json")
	(make "https://github.com/alemuller/tree-sitter-make")
	(markdown "https://github.com/ikatyang/tree-sitter-markdown")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(toml "https://github.com/tree-sitter/tree-sitter-toml")
	(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
	(yaml "https://github.com/ikatyang/tree-sitter-yaml")))
(setq treesit-font-lock-level 4)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1)
  (setf (alist-get 'prettier apheleia-formatters)
	'(npx "prettier" file))
  (setf (alist-get 'prettier-typescript apheleia-formatters)
	'(npx "prettier" file)))
(use-package dtrt-indent)

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(autoload 'notmuch "notmuch" "notmuch mail" t)
(use-package notmuch)
