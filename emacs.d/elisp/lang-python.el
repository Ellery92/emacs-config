;;; package --- python configs
;;; Commentary:
;;; Contains my python configs

(require 'anaconda-mode)
;; :init
;; (add-to-list 'python-shell-extra-pythonpaths "/path/to/the/project")
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-to-list 'company-backends 'company-anaconda)

(add-hook 'python-mode-hook 'flycheck-mode)

(define-key anaconda-mode-map (kbd "M-?") 'anaconda-mode-find-references)
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

(require 'py-isort)

;; (unless (package-installed-p 'importmagic)
;;   (package-install 'importmagic))

;; (defun auto-import-missing nil
;;   (interactive)
;;   (progn
;;     (importmagic-mode +1)
;;     (importmagic-fix-imports)
;;     (setq importmagic-mode nil)))

;; (define-key python-mode-map (kbd "C-c C-l") 'auto-import-missing)

(require 'smartrep)

(require 'ein)
(setq ein:use-auto-complete t)
(setq ein:use-smartrep t)
(setq ein:jupyter-default-notebook-directory "/home/ellery/Documents")

;; kivy: kv file
(require 'kivy-mode)
(add-to-list 'auto-mode-alist '("\\.kv$" . kivy-mode))
(add-hook 'kivy-mode-hook
          '(lambda ()
             (electric-indent-local-mode t)))

(provide 'lang-python)
;;; base-python.el ends here
