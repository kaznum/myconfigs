(setq load-path (cons "~/elisp" load-path))
(add-to-list 'load-path "~/elisp/ruby")

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
(add-to-list 'load-path "~/elisp/rinari")
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

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

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