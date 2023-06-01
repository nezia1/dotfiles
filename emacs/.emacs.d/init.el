(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elcord company company-mode pdf-tools org-roam magit expand-region doom-modeline all-the-icons vertico use-package))
 '(warning-suppress-log-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(add-to-list 'default-frame-alist '(font . "Monospace 13"))
;; Set theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'catppuccin t)
(setq catppuccin-flavor 'frappe)
(catppuccin-reload)

(add-hook 'text-mode-hook 'visual-line-mode)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

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
(use-package all-the-icons)  
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

;; make language settings work with latex exports
(add-to-list 'org-latex-packages-alist
             '("AUTO" "babel" t ("pdflatex" "xelatex" "lualatex")))
(add-to-list 'org-latex-packages-alist
             '("AUTO" "polyglossia" t ("xelatex" "lualatex")))

;; lsp configuration
(use-package eglot)
(add-hook 'prog-mode-hook 'eglot-ensure)

;; in buffer auto completion
(use-package company
  :hook (prog-mode . emacs-lisp-mode))

;; discord integration
(use-package elcord
  :config
  (elcord-mode))
;; Makes sure elcord doesn't run on empty frames (for daemonized setups) - https://github.com/Mstrodl/elcord/issues/17#issuecomment-571383324
(defun elcord--disable-elcord-if-no-frames (f)
  (declare (ignore f))
  (when (let ((frames (delete f (visible-frame-list))))
          (or (null frames)
              (and (null (cdr frames))
                   (eq (car frames) terminal-frame))))
    (elcord-mode -1)
    (add-hook 'after-make-frame-functions 'elcord--enable-on-frame-created)))

(defun elcord--enable-on-frame-created (f)
  (declare (ignore f))
  (elcord-mode +1))

(defun my/elcord-mode-hook ()
  (if elcord-mode
      (add-hook 'delete-frame-functions 'elcord--disable-elcord-if-no-frames)
    (remove-hook 'delete-frame-functions 'elcord--disable-elcord-if-no-frames)))

(add-hook 'elcord-mode-hook 'my/elcord-mode-hook)
