;; C-IDE based on https://github.com/tuhdo/emacs-c-ide-demo
(use-package cc-mode
  :config
  ;; Available C style:
  ;; "gnu": The default style for GNU projects
  ;; "k&r": What Kernighan and Ritchie, the authors of C used in their book
  ;; "bsd": What BSD developers use, aka "Allman style" after Eric Allman.
  ;; "whitesmith": Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
  ;; "stroustrup": What Stroustrup, the author of C++ used in his book
  ;; "ellemtel": Popular C++ coding standards as defined by "Programming in C++, Rules and Recommendations," Erik Nyquist and Mats Henricson, Ellemtel
  ;; "linux": What the Linux developers use for kernel development
  ;; "python": What Python developers use for extension modules
  ;; "java": The default style for java-mode (see below)
  ;; "user": When you want to define your own style
  (setq c-default-style "gnu") ;; set style to "linux"
  (setq gdb-many-windows t ;; use gdb-many-windows by default
	gdb-show-main t))

(use-package semantic
  :config
  (global-semanticdb-minor-mode 1)
  (global-semantic-idle-scheduler-mode 1)
  (global-semantic-stickyfunc-mode 1)
  (semantic-add-system-include "~/workspace/experiment/java/jdk/classes/" 'java-mode)
  (semantic-add-system-include "/usr/include/c++/6.3.1/" 'c++-mode)
  (semantic-mode 1))

(use-package ede
  :config
  ;; Enable EDE only in C/C++
  (global-ede-mode))

(require 'setup-helm-gtags)

;; company-c-headers
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers)
  :config
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/6.3.1/"))

(use-package cc-mode
  ;; :init
  ;; (define-key c-mode-map  [(tab)] 'company-complete)
  ;; (define-key c++-mode-map  [(tab)] 'company-complete)
  )

;; git@github.com:syohex/emacs-counsel-gtags.git
;(use-package counsel-gtags
;  :load-path "vendor/emacs-counsel-gtags/"
;  :ensure nil
;  :config
;  (add-hook 'c-mode-hook 'counsel-gtags-mode)
;  (add-hook 'c++-mode-hook counsel-gtags-mode)
;
;  (with-eval-after-load 'counsel-gtags
;    (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
;    ;(define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
;    ;(define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
;    (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-pop-stack)))

(defun alexott/cedet-hook ()
  (local-set-key (kbd "C-c C-j") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-c C-s") 'semantic-ia-show-summary))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; (use-package srefactor-lisp)

(use-package srefactor
  :config
  (semantic-mode 1) ;; -> this is optional for Lisp
  :bind
  (:map c++-mode-map ("M-RET" . srefactor-refactor-at-point))
  (:map c-mode-map ("M-RET" . srefactor-refactor-at-point)))

(provide 'lang-c)
