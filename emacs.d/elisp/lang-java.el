;; (use-package jdee
;;   :init
;;   :config
;;   (setq jdee-server-dir user-emacs-directory)
;;   (company-mode -1)
;;   :bind (:map jdee-mode-map
;;               ("C-M-i" . jdee-complete-minibuf)))

;; (use-package eclim
;;   :init
;;   (require 'eclimd)
;;   :config
;;   (setq eclimd-executable "/opt/eclipse/eclimd")
;;   (add-hook 'java-mode-hook 'eclim-mode))

;; (use-package malarbar-mode)

(provide 'lang-java)
