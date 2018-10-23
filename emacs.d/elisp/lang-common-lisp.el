(require 'sly)

(require 'common-lisp-snippets)

(require 'paredit)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'sly-mrepl-mode-hook        #'enable-paredit-mode)

(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)

;; (require 'lispy)
;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'eval-expression-minibuffer-setup-hook (lambda () (lispy-mode 1)))
;; (add-hook 'ielm-mode-hook             (lambda () (lispy-mode 1)))
;; (add-hook 'lisp-mode-hook             (lambda () (lispy-mode 1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'scheme-mode-hook           (lambda () (lispy-mode 1)))
;; (add-hook 'sly-mrepl-mode-hook        (lambda () (lispy-mode 1)))

;; https://github.com/promethial/paxedit
;; (require 'paxedit
;;   :init
;;   (add-hook 'clojure-mode-hook #'paxedit-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'paxedit-mode)
;;   (add-hook 'common-lisp-mode-hook #'paxedit-mode)
;;   (add-hook 'scheme-mode-hook #'paxedit-mode)
;;   (add-hook 'lisp-mode-hook #'paxedit-mode))

(require 'parinfer)
(global-set-key (kbd "C-,") 'parinfer-toggle-mode)
(progn
  (setq parinfer-extensions
        '(defaults       ; should be included.
           pretty-parens  ; different paren styles for different modes.
           evil           ; If you use Evil.
           ;; lispy          ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
           paredit        ; Introduce some paredit commands.
           smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
           smart-yank))   ; Yank behavior depend on mode.
  (add-hook 'clojure-mode-hook #'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  (add-hook 'common-lisp-mode-hook #'parinfer-mode)
  (add-hook 'scheme-mode-hook #'parinfer-mode)
  (add-hook 'lisp-mode-hook #'parinfer-mode))

(provide 'lang-common-lisp)
