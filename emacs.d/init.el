;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:
(setq warning-minimum-level :error)

(require 'cask "/usr/share/cask/cask.el")
(cask-initialize)

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-global-keys)

(require 'setup-helm)
(require 'setup-editing)

(require 'lang-elisp)
(require 'lang-c)
(require 'lang-python)
;; (require 'lang-java)
(require 'lang-rust)
(require 'lang-common-lisp)
(require 'lang-ruby)
(require 'lang-go)
(require 'lang-racket)
;; (require 'lang-javascript)
;; (require 'lang-web)
;; (require 'lang-php)
;; (require 'lang-haskell)
;; (require 'lang-elixir)

(require 'extra-extensions)
(require 'base-functions)
