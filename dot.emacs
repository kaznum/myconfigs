(setq load-path (cons "~/elisp" load-path))
(add-to-list 'load-path "~/elisp/ruby")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
;;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;(add-to-list 'load-path "~/.emacs.d/elpa/ruby-mode-1.1")
;(add-to-list 'load-path "~/.emacs.d/elpa/ruby-electric-1.1")
;(add-to-list 'load-path "~/.emacs.d/elpa/ruby-test-mode-1.0")

;; SVN mode
(require 'psvn)
(autoload 'svn-status "psvn" nil t)
(setq svn-status-hide-unmodified t)
(setq process-coding-system-alist
      (cons '("svn" . utf-8) process-coding-system-alist))

;; YAML mode
(add-to-list 'load-path "~/elisp/yaml-mode")
;;; yaml-mode の設定
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (setq comment-start "#")
             (setq comment-start-skip "\\(^\\s-*\\|\\=\\s-*\\)#+ *")
             (setq comment-end-skip "$")
             (set (make-local-variable 'comment-style) 'indent) ))


;; configuration of ido
(require 'ido)
(ido-mode t)
(add-to-list 'load-path "~/.emacs.d/from_git/rinari")
(require 'rinari)

;; configuration of rhtml-mode
(add-to-list 'load-path "~/elisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
	(lambda () (rinari-launch)))

;; configuration of yasnippet/rails-snippets
(add-to-list 'load-path
	     "~/elisp/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/elisp/yasnippet/snippets")
(yas/load-directory "~/elisp/yasnippets-rails/rails-snippets")

;; highlight the line corresponding to "end"
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)


(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

;(require 'ruby-electric)
;(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; display line number
(global-linum-mode t)

(global-set-key "\C-o" 'dabbrev-expand)

(setq inhibit-startup-message t)
(setq-default transient-mark-mode t)

;; C-n(next-line)時に1行が複数行表示されている場合には、次の改行までスキップする
(setq column-number-mode t)
(setq line-move-visual nil)

(require 'font-lock)
(setq-default font-lock-maximum-decoration t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq indent-tabs-mode nil)
             (setq ruby-indent-level tab-width)
             ))

;;スクラッチバッファをからの状態にする
(setq initial-scratch-message nil)
;; フォントの指定
(create-fontset-from-ascii-font "Menlo-10:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 12)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; Configure for SKK
(defvar system-load-path load-path)
(setq my-load-path '("/Applications/Emacs.app/Contents/Resources/site-lisp/skk"
		     "/Applications/Emacs.app/Contents/Resources/site-lisp/apel"
		     "/Applications/Emacs.app/Contents/Resources/site-lisp/emu"))
(setq load-path (append my-load-path system-load-path))

(require 'skk-autoloads)
(global-set-key "\C-x\C-j" 'skk-mode)
;(global-set-key "\C-xj" 'skk-auto-fill-mode)
;(global-set-key "\C-xt" 'skk-tutorial)
;; Specify dictionary location
(setq skk-large-jisyo "/Users/kaz/Library/Application Support/AquaSKK/SKK-JISYO.L")
;; Specify tutorial location
;(setq skk-tut-file "/usr/share/skk/SKK.tut")

(add-hook 'isearch-mode-hook
	  (function (lambda ()
		      (and (boundp 'skk-mode) skk-mode
			   (skk-isearch-mode-setup)))))

(add-hook 'isearch-mode-end-hook
	  (function
	   (lambda ()
	     (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
	     (and (boundp 'skk-mode-invoked) skk-mode-invoked
		  (skk-set-cursor-properly)))))
(setq yas/trigger-key 'TAB)



;; ruby-mode
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
(defun ruby-mode-hook-ruby-elecrtric ()
  (ruby-electric-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-elecrtric)

;;rspec-mode
;; (install-elisp "http://perso.tls.cena.fr/boubaker/distrib/mode-compile.el")
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
;; (global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-ck" 'mode-compile-kill)

;; rvm-mode
(defadvice ido-completing-read (around invaild-ido-completing-read activate)
  "ido-completing-read -> completing-read"
  (complete-read))
(rvm-use-default)

;; rubydb -- ruby debugger
(autoload 'rubydb "rubydb3x" "Run rubydb on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger.")

;; ruby-block
(require 'ruby-block)
(setq ruby-block-highlight-toggle t)
(defun ruby-mode-hook-ruby-block()
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block)


(add-to-list 'load-path "/Users/kaz/.emacs.d/from_git/auto-complete")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)

;;rsense
(setq rsense-home (expand-file-name "~/opt/rsense/"))
;;(setq rsense-rurema-home "~/opt/rurema")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)
(define-key ruby-mode-map "\C-c\C-i" 'ac-complete-rsense)
(define-key ruby-mode-map "\C-ct" 'rsense-type-help)
(define-key ruby-mode-map "\C-cj" 'rsense-jump-to-definition)

;; C-c .で補完
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'rsense-complete)))
;; C-c .で補完
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'ac-complete-rsense)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))


;; Coffee-mode
(add-to-list 'load-path "/Users/kaz/.emacs.d/from_git/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))

;;SCSS
(add-to-list 'load-path "/Users/kaz/.emacs.d/from_git/scss-mode")
(require 'scss-mode)
