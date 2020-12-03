;; .emacs basic file

;; Define custom load-path

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq load-path (cons "~/.emacs.d/site-lisp" load-path))

;; sane scroll
(setq scroll-step            1
      scroll-conservatively  10000)

;; get rid of slashes for cut-n-paste
(set-display-table-slot standard-display-table 'wrap ?\ )

;; discard newlines when cutting and pasting region
(defun my-copy-simple (beg end)
  "Save the current region to the kill ring after stripping extra whitespace and new lines"
  (interactive "r")
  (copy-region-as-kill beg end)
  (with-temp-buffer 
    (yank)
    (goto-char 0)
    (while (looking-at "[ \t\n]")
      (delete-char 1))
    (compact-uncompact-block)
    (mark-whole-buffer)
    (kill-region (point-min) (point-max))))


;; disable transient-mark-mode
(transient-mark-mode 0)

;; disable startup messages
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; disable auto-identing
(setq indent-tabs-mode nil)
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; default tab width
(setq-default tab-width 2)

;; turn on font-lock mode for emacs
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; enable ruby mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(put 'set-goal-column 'disabled nil)

;; enable yaml mode
(require 'yaml-mode nil 'missing-okay)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))



;; elpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 (quote
		(rust-mode jinja2-mode dockerfile-mode go-mode mmm-mode rinari web-mode enh-ruby-mode systemd markdown-mode chef-mode json-mode yaml-mode docker-compose-mode terraform-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )
