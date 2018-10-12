;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(if (version< emacs-version "26.0.50")
    (package-initialize))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)

(require 'setup-helm)
(require 'setup-editing)

(require 'lang-elisp)
(require 'lang-c)
(require 'lang-python)
(require 'lang-java)
(require 'lang-ruby)
(require 'lang-javascript)
(require 'lang-web)
(require 'lang-go)
(require 'lang-php)
(require 'lang-haskell)
(require 'lang-elixir)

(require 'extra-extensions)
