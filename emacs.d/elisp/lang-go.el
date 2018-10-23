(require 'go-mode)
;; Use goimports instead of go-fmt
(setq gofmt-command "goimports")
(add-hook 'go-mode-hook 'company-mode)
;; Call Gofmt before saving
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'setup-go-mode-compile)
(add-hook 'go-mode-hook #'smartparens-mode)
(add-hook 'go-mode-hook '(lambda ())
                     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports))
(add-hook 'go-mode-hook '(lambda ())
                     (local-set-key (kbd "C-c C-g") 'go-goto-imports))
(add-hook 'go-mode-hook (lambda ())
          (set (make-local-variable 'company-backends) '(company-go))
          (company-mode))

(require 'company-go)
(define-key go-mode-map (kbd "M-.") 'godef-jump)

(require 'flymake-go)

(require 'go-eldoc)

(defun setup-go-mode-compile ()
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))

(defun go-mode-hook-default nil
  (progn
    (setq tab-width 4)
    (go-eldoc-setup)))

(add-hook 'go-mode-hook #'go-mode-hook-default)

(provide 'lang-go)
