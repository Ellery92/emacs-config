;; (use-package lsp-mode
;;   :ensure t
;;   :init (setq lsp-inhibit-message nil ; you may set this to t to hide messages from message area
;;               lsp-eldoc-render-all nil
;;               lsp-highlight-symbol-at-point nil))

;; (use-package company-lsp
;;   :after  company
;;   :ensure t
;;   :config
;;   (add-hook 'java-mode-hook (lambda () (push 'company-lsp company-backends)))
;;   (setq company-lsp-enable-snippet t
;;         company-lsp-cache-candidates t))

;; (use-package lsp-ui
;;   :ensure t
;;   :config
;;   (setq lsp-ui-sideline-enable t
;;         lsp-ui-sideline-show-symbol t
;;         lsp-ui-sideline-show-hover t
;;         lsp-ui-sideline-show-code-actions t
;;         lsp-ui-sideline-update-mode 'point))

;; (use-package dap-mode)

;; (use-package lsp-java
;;   :ensure t
;;   :requires (lsp-ui-flycheck lsp-ui-sideline dap-mode)
;;   :config
;;   (require 'dap-java)
;;   (add-hook 'java-mode-hook  'lsp-java-enable)
;;   (add-hook 'java-mode-hook  'flycheck-mode)
;;   (add-hook 'java-mode-hook  'company-mode)
;;   (add-hook 'java-mode-hook  'dap-mode)
;;   (add-hook 'java-mode-hook  'dap-ui-mode)
;;   (add-hook 'java-mode-hook  (lambda () (lsp-ui-flycheck-enable t)))
;;   (add-hook 'java-mode-hook  'lsp-ui-sideline-mode)

;;   (define-key java-mode-map (kbd "M-.") 'xref-find-definitions)
;;   (define-key java-mode-map (kbd "M-?") 'xref-find-references)
;;   (define-key java-mode-map (kbd "M-,") 'xref-pop-marker-stack)

;;   (with-eval-after-load 'dap-mode
;;     (define-key java-mode-map (kbd "<f5>") 'dap-java-debug)
;;     (define-key java-mode-map (kbd "<f7>") 'dap-breakpoint-toggle)
;;     (define-key java-mode-map (kbd "<f10>") 'dap-next)
;;     (define-key java-mode-map (kbd "<f11>") 'dap-step-in)
;;     (define-key java-mode-map (kbd "S-<f11>") 'dap-step-out))
;;   (setq lsp-java--workspace-folders (list "~/workspace/experiment/java/test-gradle")))

;; (use-package gradle-mode
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.gradle\\'" . gradle-mode)))

;; (use-package flycheck-gradle
;;   :init
;;   (flycheck-gradle-setup))

(provide 'lang-java)
