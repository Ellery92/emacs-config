;; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
(use-package irony
  :config
  (progn
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                    irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))

(use-package company-irony
  :init
  (add-to-list 'company-backends 'company-irony))

(use-package company-irony-c-headers
  ;; Load with `irony-mode` as a grouped backend
  :init
  (add-to-list 'company-backends 'company-irony-c-headers))

(use-package flycheck-irony
  :config
  (progn
    (flycheck-irony-setup)))

(use-package irony-eldoc
  :config
  (progn
    (add-hook 'irony-mode-hook #'irony-eldoc)))

(require 'setup-helm-gtags)

(use-package semantic
  :config
  (global-semanticdb-minor-mode 1)
  (global-semantic-idle-scheduler-mode 1)
  (global-semantic-stickyfunc-mode 1)
  (semantic-mode 1))

(defun alexott/cedet-hook ()
  (local-set-key (kbd "C-c C-j") 'semantic-ia-fast-jump))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

(use-package srefactor
  :config
  (semantic-mode 1) ;; -> this is optional for Lisp
  :bind
  (:map c++-mode-map ("M-RET" . srefactor-refactor-at-point))
  (:map c-mode-map ("M-RET" . srefactor-refactor-at-point)))

(use-package rtags
  :config
  (progn
    (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

    (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
    (rtags-enable-standard-keybindings)

    (setq rtags-use-helm t)

    ;; Shutdown rdm when leaving emacs.
    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)))

;; TODO: Has no coloring! How can I get coloring?
(use-package helm-rtags
  :config
  (progn
    (setq rtags-display-result-backend 'helm)))

;; Use rtags for auto-completion.
;; (use-package company-rtags
;;   :require company rtags
;;   :config
;;   (progn
;;     (setq rtags-autostart-diagnostics t)
;;     (rtags-diagnostics)
;;     (setq rtags-completions-enabled t)
;;     (push 'company-rtags company-backends)))

;; Live code checking.
;; (use-package flycheck-rtags
;;   :require flycheck rtags
;;   :config
;;   (progn
;;     ;; ensure that we use only rtags checking
;;     ;; https://github.com/Andersbakken/rtags#optional-1
;;     (defun setup-flycheck-rtags ()
;;       (flycheck-select-checker 'rtags)
;;       (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;;       (setq-local flycheck-check-syntax-automatically nil)
;;       (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
;;       )
;;     (add-hook 'c-mode-hook #'setup-flycheck-rtags)
;;     (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
;;     ))

;; (use-package helm-kythe)

(provide 'lang-c)
