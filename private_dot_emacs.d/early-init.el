;; Paths to config.org and the tangled init.el
(defvar org-config-file (expand-file-name "README.org" user-emacs-directory))
(defvar tangled-init-file (expand-file-name "init.el" user-emacs-directory))

;; Function to tangle the org file
(defun tangle-org-config ()
  (require 'org)
  (org-babel-tangle-file org-config-file))

;; Check if config.org is newer than init.el and tangle if necessary
(when (file-newer-than-file-p org-config-file tangled-init-file)
  (tangle-org-config))



