;;; package --- python configs
;;; Commentary:
;;; Contains my python configs

;;; Code:
(use-package elpy
  :init
  (setq elpy-rpc-python-command "python3")
  (setq elpy-eldoc-show-current-function t)
  (elpy-enable)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  (require 'py-autopep8)
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

(use-package ein
  :config
  (setq ein:use-auto-complete t)
  (setq ein:use-smartrep t)
  (setq ein:jupyter-default-notebook-directory "/home/ellery/Documents"))

;; kivy: kv file
(use-package kivy-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.kv$" . kivy-mode))
  (add-hook 'kivy-mode-hook
            '(lambda ()
               (electric-indent-local-mode t))))

(provide 'lang-python)
;;; base-python.el ends here
