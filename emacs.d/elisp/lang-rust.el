;; language rust config

(require 'rust-mode)
(require 'flycheck-rust)
(require 'cargo)
(require 'lsp-mode)
(require 'rustic)

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (flycheck-mode))

(add-hook 'rust-mode-hook (lambda nil (cargo-minor-mode +1)))

(provide 'lang-rust)
