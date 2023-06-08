(setq user-full-name "Anthony Rodriguez")

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

					;disable backup
(setq backup-inhibited t)
					;disable auto save
(setq auto-save-default nil)

(add-to-list 'default-frame-alist '(font . "Monospace 15"))
(add-hook 'text-mode-hook 'visual-line-mode)

;; Initialize package sources
(defvar bootstrap-version)
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
;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Set theme
(use-package catppuccin-theme
  :custom
  (catppuccin-flavor 'mocha)
  :init
  (load-theme 'catppuccin t)
  (catppuccin-reload))

;; ensures environment variables are available in GUI and daemon
(use-package exec-path-from-shell
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "NIX_SSL_CERT_FILE" "NIX_PATH"))
    (add-to-list 'exec-path-from-shell-variables var)))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(when (daemonp)
  (exec-path-from-shell-initialize))

(use-package vertico
  :init
  (vertico-mode))

(use-package nerd-icons)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :config
  (which-key-mode))
;; magit
(use-package magit)

;; org setup
;; export to a4
(with-eval-after-load 'ox-latex (add-to-list 'org-latex-classes
					     '("article" "\\documentclass[11pt,a4paper]{article}"
					       ("\\section{%s}" . "\\section*{%s}")
					       ("\\subsection{%s}" . "\\subsection*{%s}")
					       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
					       ("\\paragraph{%s}" . "\\paragraph*{%s}")
					       ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package org-roam
  :custom
  (org-roam-directory "~/org/notes")
  (org-roam-completion-everywhere t)
  :config
  (org-roam-setup)
  :bind (("C-c n f" . org-roam-node-find)
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n l" . org-roam-buffer-toggle)))))

(setq org-publish-project-alist
      (list 
       '("notes"
	 :base-directory "~/org/notes"
	 :base-extension "org"
	 :publishing-directory "~/org/notes"
	 :publishing-function org-latex-publish-to-pdf
	 )))

;; spell checking for text modes
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

(add-hook 'prog-mode-hook
	  (lambda ()
	    (flyspell-prog-mode)))
;; avoid spell checking code regions in org mode
(add-to-list 'ispell-skip-region-alist '("^#+BEGIN_SRC" . "^#+END_SRC"))

;; add different dictionaries
(let ((langs '("american" "francais")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

;; cycle through languages
(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))
(setq ispell-program-name "aspell")

(global-set-key [f6] 'cycle-ispell-languages)

;; automatic language detection
(use-package guess-language
  :config
  (setq guess-language-languages '(en fr))
  (setq guess-language-min-paragraph-length 35)
  :hook
  (text-mode . guess-language-mode))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

;; enable syntax highlighting in org source blocks
(setq org-src-fontify-natively t)

;; disable latex subscript in org-mode
(setq org-export-with-sub-superscripts nil)

(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width))

(use-package rustic
  :custom
  (rustic-format-trigger 'on-save)
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))
  :hook
  (rustic-mode . display-line-numbers-mode))

;; lsp integration
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode))

;; code completion
(use-package company
  :after lsp-mode
  :custom
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))
