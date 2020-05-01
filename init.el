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
;; (require 'auto-complete-config) 
;; (ac-config-default) 

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

;; Rosemacs ;; C-x C-r f
(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
(require 'rosemacs-config)

;; Undo-tree ;; C-x u
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; Big/small letter distinguish
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; yasnippet ;; C-i
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/elpa/yasnippet-20200413.2221/"))
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/yasnippet-snippets/snippets"))
(define-key yas-keymap (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "C-x i t") 'yas-describe-tables)
(yas-global-mode 1)

;; company
(require 'company)
(global-company-mode 1)
(global-set-key (kbd "C-M-i") 'company-complete)
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
;; (setq company-idle-delay nil) ; 自動補完をしない
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil) ;; C-hはBackspace割当のため無効化
(define-key company-active-map (kbd "<tab>") 'company-complete-selection)
;; 色をauto-completeライクに
(set-face-attribute 'company-tooltip nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")

;; irony-mode
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
;; compile_commands.json からコンパイルオプションを取得
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ;; backend追加
;; compile_commands.json が見つからないとき用の一般的なコンパイルオプション
;; (setq irony-lang-compile-option-alist
;;       '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm"))
;;         (c-mode . ("c"))))
;; (defun irony--lang-compile-option ()
;;   (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
;;     (append '("-x") it)))

;; flycheck
(require 'flycheck)
(global-flycheck-mode 1)
(add-hook 'after-init-hook 'global-flycheck-mode)
;; (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
;; (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)

;; flycheck-tip
(require 'flycheck-tip)
(define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-tip-cycle)
(define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-tip-cycle-reverse)
(setq flycheck-tip-avoid-show-func nil)

;; flycheck-irony
(require 'flycheck-irony)
(flycheck-irony-setup)

;; rtags
(require 'rtags)
(rtags-enable-standard-keybindings c-mode-base-map)
(cmake-ide-setup)
(global-unset-key (kbd "C-x C-t"))
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (rtags-is-indexed)
              (local-set-key (kbd "C-x C-t s") 'rtags-find-symbol)
              (local-set-key (kbd "C-x C-t r") 'rtags-find-references)
              (local-set-key (kbd "C-x C-t b") 'rtags-location-stack-back))))
