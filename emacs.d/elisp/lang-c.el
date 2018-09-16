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

(use-package rtags
  :config
  (progn
    (unless (or (rtags-executable-find "rc") (rtags-executable-find "rdm"))
      (call-interactively #'rtags-install))

    (rtags-enable-standard-keybindings)
    (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-?") 'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back)

    ;; run rdm
    (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

    ;; Shutdown rdm when leaving emacs.
    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)))

(use-package helm-rtags
  :config
  (progn
    (setq rtags-display-result-backend 'helm)))

(use-package helm-gtags
  :init
  (setq helm-gtags-ignore-case t
        helm-gtags-auto-update t
        helm-gtags-use-input-at-cursor t
        helm-gtags-pulse-at-cursor t
        helm-gtags-prefix-key "\C-cg"
        helm-gtags-suggested-key-mapping nil)
  :config
  (progn
    (define-key helm-gtags-mode-map (kbd "C-c g .") 'helm-gtags-dwim)
    (define-key helm-gtags-mode-map (kbd "C-c g ?") 'helm-gtags-find-rtag)
    (define-key helm-gtags-mode-map (kbd "C-c g ,") 'helm-gtags-pop-stack)
    (define-key helm-gtags-mode-map (kbd "C-c g t") 'helm-gtags-find-tag)

    ;; Enable helm-gtags-mode in Dired so you can jump to any tag
    ;; when navigate project tree with Dired
    (add-hook 'dired-mode-hook 'helm-gtags-mode)

    ;; Enable helm-gtags-mode in Eshell for the same reason as above
    (add-hook 'eshell-mode-hook 'helm-gtags-mode)
    (add-hook 'shell-mode-hook 'helm-gtags-mode)

    ;; Enable helm-gtags-mode in languages that GNU Global supports
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'java-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode)))

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

(provide 'lang-c)
