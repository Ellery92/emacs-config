;;; package --- python configs
;;; Commentary:
;;; Contains my python configs

;;; Code:
(use-package elpy
  :init
  (elpy-enable)
  (setq elpy-rpc-python-command "python3"
  elpy-eldoc-show-current-function t))

;; kivy: kv file
(use-package kivy-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.kv$" . kivy-mode))
  (add-hook 'kivy-mode-hook
            '(lambda ()
               (electric-indent-local-mode t))))

(provide 'lang-python)
;;; base-python.el ends here
