;;; -*- mode: Emacs-Lisp; -*-

;;----------------------------------------------------------------------------- 
;; Package setup
;;----------------------------------------------------------------------------- 

;; set a `custom-file` so Emacs leaves my init file alone
(setq custom-file (expand-file-name 
        (concat (getenv "DOTFILES_HOME") "/emacs/emacs-common-custom.el")))

;; Change to your .emacs.d/ directory accordingly
; (setq user-emacs-directory "${HOME}/.emacs.d")

;; Set up package and use-package

(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

;; Defered python package

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

(use-package org
             :ensure t)

; (use-package evil
;              :ensure t
;              :config
;              (evil-mode 1))

;;----------------------------------------------------------------------------- 
;; Startup, General Settings
;;----------------------------------------------------------------------------- 

;;; Don't show the splash screen and set index file
(setq inhibit-startup-message t)
(setq initial-buffer-choice "unamed-emacs-file")

;; Hide scroll bar, menu bar and tool bar
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Marking text and configuring the clipboard
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; Disable tabs (needed)
(setq tab-width 2
      indent-tabs-mode nil)

;; Disable backup (never used them)
(setq make-backup-files nil)

;; Set column number on
(setq column-number-mode t)

;; Turn on auto complete
(require 'auto-complete-config)
(ac-config-default)

;; Display line numbers in every buffer (relative)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Display battery for when in full screen mode
(display-battery-mode t)

;; Keybindings
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f3>") 'org-export-dispatch)
(global-set-key (kbd "<f6>") 'eshell)
(global-set-key (kbd "<f7>") 'ranger)
(global-set-key (kbd "<f8>") 'magit)

;; Misc stuff
(fset 'yes-or-no-p 'y-or-n-p)
(server-start)

;;----------------------------------------------------------------------------- 
;; Startup, General Settings
;;----------------------------------------------------------------------------- 

;; disable bell, always shows parenthesis highlight and dialog box to echo area
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;;----------------------------------------------------------------------------- 
;; Theming & Aesthetics
;;----------------------------------------------------------------------------- 

;; Highlight current line
(global-hl-line-mode t)

;; Empty line marks and title tweaks
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Identation and buffer cleanup (It is stolen directly from the emacs-starter-kit)
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(setq-default show-trailing-whitespace t)

;;----------------------------------------------------------------------------- 
;; Auto-Complete
;;----------------------------------------------------------------------------- 

(use-package auto-complete
  :ensure t
  :config 
  (ac-config-default)
)

;;----------------------------------------------------------------------------- 
;; Eshell 
;;----------------------------------------------------------------------------- 

(setq eshell-visual-commands
      '("less" "tmux" "htop" "top" "bash" "zsh" "fish"))

(setq eshell-visual-subcommands
      '(("git" "log" "l" "diff" "show")))

; ;; Prompt with a bit of help from http://www.emacswiki.org/emacs/EshellPrompt
; (defmacro with-face (str &rest properties)
;   `(propertize ,str 'face (list ,@properties)))

; (defun eshell/abbr-pwd ()
;   (let ((home (getenv "HOME"))
;         (path (eshell/pwd)))
;     (cond
;      ((string-equal home path) "~")
;      ((f-ancestor-of? home path) (concat "~/" (f-relative path home)))
;      (path))))

; (defun eshell/my-prompt ()
;   (let ((header-bg "#161616"))
;     (concat
;      (with-face (eshell/abbr-pwd) :foreground "#008700")
;      (if (= (user-uid) 0)
;          (with-face "#" :foreground "red")
;        (with-face "$" :foreground "#2345ba"))
;      " ")))

; (setq eshell-prompt-function 'eshell/my-prompt)
; (setq eshell-highlight-prompt nil)
; (setq eshell-prompt-regexp "^[^#$\n]+[#$] ")

; (setq eshell-cmpl-cycle-completions nil)
