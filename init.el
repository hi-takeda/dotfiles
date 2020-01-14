;; Package setting
(package-initialize) 
(setq package-archives 
      '(("gnu" . "http://elpa.gnu.org/packages/") 
        ("melpa" . "http://melpa.org/packages/") 
        ("org" . "http://orgmode.org/elpa/")))

;; Speed up
(setq-default bidi-display-reordering nil)
(setq gc-cons-threshold (* 10 gc-cons-threshold)) 

;; Don't usesplash screen
(setq inhibit-splash-screen t)

;; Don't memory same changes
(setq history-delete-duplicates t)

;; When opened same name files
(require 'uniquify) 
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) 
(setq uniquify-ignore-buffers-re "[^*]+") 

;; Save last-opened place
(require 'saveplace) 
(setq-default save-place t) 
(setq save-place-file (concat user-emacs-directory "places")) 

;; () highlight
(show-paren-mode 1)

;; Save mini buffer for next launch
(savehist-mode 1)

;; C-h backspace
(global-set-key (kbd "C-h") 'delete-backward-char)
;; C-k remove after cursor
(setq kill-whole-line t)
;; M-x g goto-line
(global-set-key "\M-g" 'goto-line)
;; M-x query-replace
(global-set-key "\M-q" 'query-replace)

;; Show line and col num
(line-number-mode 1) 
(column-number-mode 1)

;; Set large log buffer
(setq message-log-max 10000)
(setq history-length 1000)

;; Don't show menu bar and tool bar
(menu-bar-mode -1) 
(tool-bar-mode -1)

;; Don't show startup message
(setq inhibit-startup-message t) 

;; Save backup files at one place
(setq backup-directory-alist '((".*" . "~/.ehist"))) 

;; Change "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Auto-complete
(require 'auto-complete-config) 
(ac-config-default) 

;; Font 
(add-to-list 'default-frame-alist '(font . "ricty-12")) 

;; Color theme 
;; (load-theme 'monokai t)
;; (load-theme 'cyberpunk t)
;; (load-theme 'manoj-dark t)
;; (load-theme 'atom-one-dark t)

;; Tell background color is not 'light' but dark
(add-hook 'tty-setup-hook '(lambda () (set-terminal-parameter nil 'background-mode 'dark)))

;; Indent
(setq default-tab-width 2)
(setq-default indent-tabs-mode nil)
(electric-indent-mode +1) 

;; Show full pass
(setq frame-title-format "%f")

;; Share copy between emacs and ubuntu
(if (eq system-type 'darwin)
    (setq x-select-enable-clipboard t)
  (defun xsel-cut-function (text &optional push)
  (with-temp-buffer
    (insert text)
    (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
  (defun xsel-paste-function()
  (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
    (unless (string= (car kill-ring) xsel-output)
    xsel-output )))
  (setq interprogram-cut-function 'xsel-cut-function)
  (setq interprogram-paste-function 'xsel-paste-function))

;; Rosemacs
(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
(require 'rosemacs-config)

;; Undo-tree ;; C-x u
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; Big/small letter distinguish
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
