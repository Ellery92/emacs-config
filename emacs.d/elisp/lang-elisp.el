;;; emacs-lisp.el --- config for Elisp programming.

(require 'rainbow-delimiters)
(require 'rainbow-mode)
(require 'elisp-slime-nav)
(require 'crux)

;; a great lisp coding hook
(defun prelude-lisp-coding-defaults ()
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1))

(setq prelude-lisp-coding-hook 'prelude-lisp-coding-defaults)

;; interactive modes don't need whitespace checks
(defun prelude-interactive-lisp-coding-defaults ()
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1)
  (whitespace-mode -1))

(setq prelude-interactive-lisp-coding-hook 'prelude-interactive-lisp-coding-defaults)

(defun prelude-recompile-elc-on-save ()
  "Recompile your elc when saving an elisp file."
  (add-hook 'after-save-hook
            (lambda ()
              (when ((file-exists-p (byte-compile-dest-file buffer-file-name)))
                (emacs-lisp-byte-compile)))
            nil
            t))

(defun prelude-visit-ielm ()
  "Switch to default `ielm' buffer.
Start `ielm' if it's not already running."
  (interactive)
  (crux-start-or-switch-to 'ielm "*ielm*"))

(define-key emacs-lisp-mode-map (kbd "C-c C-z") 'prelude-visit-ielm)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-b") 'eval-buffer)

(defun prelude-conditional-emacs-lisp-checker ()
  "Don't check doc style in Emacs Lisp test files."
  (let ((file-name (buffer-file-name)))
    (when (and file-name (string-match-p ".*-tests?\\.el\\'" file-name))
      (setq-local flycheck-checkers '(emacs-lisp)))))

(defun prelude-emacs-lisp-mode-defaults ()
  "Sensible defaults for `emacs-lisp-mode'."
  (run-hooks 'prelude-lisp-coding-hook)
  (eldoc-mode +1)
  (rainbow-mode +1)
  (flycheck-mode +1)
  (prelude-conditional-emacs-lisp-checker))

(setq prelude-emacs-lisp-mode-hook 'prelude-emacs-lisp-mode-defaults)

(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (run-hooks 'prelude-emacs-lisp-mode-hook)))

(require 'cask)
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;; ielm is an interactive Emacs Lisp shell
(defun prelude-ielm-mode-defaults ()
  "Sensible defaults for `ielm'."
  (run-hooks 'prelude-interactive-lisp-coding-hook)
  (eldoc-mode +1))

(setq prelude-ielm-mode-hook 'prelude-ielm-mode-defaults)

(add-hook 'ielm-mode-hook (lambda ()
                            (run-hooks 'prelude-ielm-mode-hook)))

(with-eval-after-load "elisp-slime-nav"
  (diminish 'elisp-slime-nav-mode))
(with-eval-after-load "rainbow-mode"
  (diminish 'rainbow-mode))
(with-eval-after-load "eldoc"
  (diminish 'eldoc-mode))

;; enable elisp-slime-nav-mode
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

(defun conditionally-enable-smartparens-mode ()
  "Enable `smartparens-mode' in the minibuffer, during `eval-expression'."
  (if (eq this-command 'eval-expression)
      (smartparens-mode 1)))

(add-hook 'minibuffer-setup-hook 'conditionally-enable-smartparens-mode)

(provide 'lang-elisp)
