;; for code navigate
(require 'helm-gtags)

(setq helm-gtags-ignore-case t
      helm-gtags-auto-update t
      helm-gtags-use-input-at-cursor t
      helm-gtags-pulse-at-cursor t
      helm-gtags-prefix-key "\C-cg"
      helm-gtags-suggested-key-mapping nil)
(progn
  (define-key helm-gtags-mode-map (kbd "M-.") nil)
  (define-key helm-gtags-mode-map (kbd "C-c g j") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "C-c g d") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "C-c g p") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c g .") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "C-c g ,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c g ?") 'helm-gtags-find-rtag)

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
  (add-hook 'python-mode-hook 'helm-gtags-mode)
  (add-hook 'asm-mode-hook 'helm-gtags-mode)
  (add-hook 'emacs-lisp-mode-hook 'helm-gtags-mode))

(require 'rtags)
(progn
  (unless (or (rtags-executable-find "rc") (rtags-executable-find "rdm"))
    (call-interactively #'rtags-install))

  (rtags-enable-standard-keybindings)

  ;; Shutdown rdm when leaving emacs.
  (add-hook 'kill-emacs-hook 'rtags-quit-rdm))

(require 'helm-rtags)
(setq rtags-display-result-backend 'helm)

;; cmake-related
(require 'cmake-mode)
(require 'cmake-ide)
(add-hook 'before-save-hook #'cide--before-save)

(defun set-rtags-env (build-prefix)
  (setq cmake-ide-project-dir project-root)
  (setq cmake-ide-build-dir (concat project-root build-prefix))
  (rtags-start-process-unless-running)
  t)

(defun is-cmake-project nil
  (let ((project-root
         (ignore-errors (projectile-project-root))))
    (if project-root
        (if (file-exists-p (expand-file-name "compile_commands.json" project-root))
            (set-rtags-env "")
          (if (file-exists-p (expand-file-name "build/compile_commands.json" project-root))
                 (set-rtags-env "build")
            (if (file-exists-p (expand-file-name "CMakeLists.txt" project-root))
                (progn
                  (cmake-ide-maybe-run-cmake)
                  (set-rtags-env "build"))
              nil)))
      nil)))

(defun rtags-dwim nil
    (if (and (buffer-file-name) (thing-at-point 'symbol))
        (rtags-find-symbol-at-point)
      (rtags-find-symbol)))

(defun cc-find-symbol-at-point nil
  (interactive)
  (if (is-cmake-project)
      (rtags-dwim)
    (helm-gtags-dwim)))

(defun cc-find-rtag nil
  (interactive)
  (if (is-cmake-project)
      (rtags-find-references-at-point)
    (helm-gtags-find-rtag (thing-at-point 'symbol))))

(defun cc-tags-pop-stack nil
  (interactive)
  (if (is-cmake-project)
      (rtags-location-stack-back)
    (helm-gtags-pop-stack)))

(defun projectile-run-cmake nil
  (interactive)
  (let ((project-root
         (ignore-errors (projectile-project-root))))
    (if project-root
        (progn
          (setq cmake-ide-project-dir project-root)
          (setq cmake-ide-build-dir (concat project-root "build"))
          (cmake-ide-maybe-run-cmake))
      (message "you are not in a project"))))

(define-key c-mode-map (kbd "M-.") 'cc-find-symbol-at-point)
(define-key c++-mode-map (kbd "M-.") 'cc-find-symbol-at-point)
(define-key c-mode-map (kbd "M-,") 'cc-tags-pop-stack)
(define-key c++-mode-map (kbd "M-,") 'cc-tags-pop-stack)
(define-key c-mode-map (kbd "M-?") 'cc-find-rtag)
(define-key c++-mode-map (kbd "M-?") 'cc-find-rtag)

;; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
(require 'irony)
(progn
  ;; If irony server was never installed, install it.
  ;; (unless (ignore-errors (irony--find-server-executable) (call-interactively #'irony-install-server)))

  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)

  ;; Use compilation database first, clang_complete as fallback.
  (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                  irony-cdb-clang-complete))

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(require 'company-irony)
(add-to-list 'company-backends 'company-irony)

(require 'company-irony-c-headers)
;; Load with `irony-mode` as a grouped backend
(add-to-list 'company-backends 'company-irony-c-headers)

(require 'company-rtags)
(push 'company-rtags company-backends)

(require 'irony-eldoc)
(progn
  (add-hook 'irony-mode-hook #'irony-eldoc))

;; flycheck related
;; (require 'flycheck-irony
;;   :config
;;   (progn
;;     (flycheck-irony-setup)))

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))

(defun cc-flycheck-setup ()
  (flycheck-mode)
  (if (is-cmake-project)
      (my-flycheck-rtags-setup)
    (flycheck-select-checker 'c/c++-gcc)))

(add-hook 'c-mode-hook #'cc-flycheck-setup)
(add-hook 'c++-mode-hook #'cc-flycheck-setup)

(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)
(semantic-mode 1)
(defun alexott/cedet-hook ()
  (local-set-key (kbd "C-c C-j") 'semantic-ia-fast-jump))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

(require 'srefactor)
(semantic-mode 1) ;; -> this is optional for Lisp
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(defun diable-namespace-indent nil
  (c-set-offset 'innamespace 0))

(add-hook 'c++-mode-hook 'diable-namespace-indent)

(require 'cpp-auto-include)
(define-key c++-mode-map (kbd "C-c C-i") 'cpp-auto-include)
(define-key c-mode-map (kbd "C-c C-i") 'cpp-auto-include)

(provide 'lang-c)
