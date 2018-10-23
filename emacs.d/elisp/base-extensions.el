(require 'diminish)
(require 'ace-jump-mode)

(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(require 'company)
(setq company-minimum-prefix-length 3)
(delete 'company-semantic company-backends)
(add-hook 'after-init-hook 'global-company-mode)

(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-highlight-all-diffs 'nil)
(setq ediff-diff-options "-w")

(require 'exec-path-from-shell)
  ;; Add GOPATH to shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "PYTHONPATH")
  (exec-path-from-shell-initialize))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'hlinum)
(hlinum-activate)

;; (require 'linum)
  ;; :config
  ;; (setq linum-format " %3d ")
  ;; (global-linum-mode -1))

(require 'magit)
;; Magic
(global-set-key (kbd "C-x g x") 'magit-checkout)
(global-set-key (kbd "C-x g c") 'magit-commit)
(global-set-key (kbd "C-x g p") 'magit-push)
(global-set-key (kbd "C-x g u") 'magit-pull)
(global-set-key (kbd "C-x g e") 'magit-ediff-resolve)
(global-set-key (kbd "C-x g r") 'magit-rebase-interactive)

(require 'magit-popup)

(require 'multiple-cursors)
;; :bind
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)

(require 'neotree)

(setq neo-theme 'arrow
      neotree-smart-optn t
      neo-window-fixed-size nil)

(require 'org)
(setq org-directory "~/workspace/document"
      org-default-notes-file (concat org-directory "/todo.org"))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(require 'org-projectile)

(require 'org-bullets)

(setq org-hide-leading-stars t)
(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)))

(require 'page-break-lines)

(require 'projectile)
(setq projectile-known-projects-file
      (expand-file-name "projectile-bookmarks.eld" temp-dir))
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-enable-caching t)
(projectile-global-mode)

(require 'recentf)

(setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
(recentf-mode 1)

(require 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode)

(require 'smex)

(require 'undo-tree)
;; Remember undo history
(setq
 undo-tree-auto-save-history nil
 undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
(global-undo-tree-mode 1)

(require 'which-key)
(which-key-mode)

(require 'wgrep)

(require 'yasnippet)
(yas-global-mode 1)

;; Package zygospore
(require 'zygospore)
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
;; (global-set-key (kbd "RET") 'newline-and-indent)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

(windmove-default-keybindings)

;; show red column number when it exceeds 70
(require 'modeline-posn)
(column-number-mode 1)

(require 'flycheck)

(ignore-errors (matlab-cedet-setup))
(defalias 'run-matlab 'matlab-shell)

(require 'google-this)
(google-this-mode 1)

(with-eval-after-load "google-this"
  (diminish 'google-this-mode))

(require 'treemacs)
(with-eval-after-load 'winum
  (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
(progn
  (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
        treemacs-deferred-git-apply-delay   0.5
        treemacs-display-in-side-window     t
        treemacs-file-event-delay           5000
        treemacs-file-follow-delay          0.2
        treemacs-follow-after-init          t
        treemacs-follow-recenter-distance   0.1
        treemacs-goto-tag-strategy          'refetch-index
        treemacs-indentation                2
        treemacs-indentation-string         " "
        treemacs-is-never-other-window      nil
        treemacs-no-png-images              nil
        treemacs-project-follow-cleanup     nil
        treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
        treemacs-recenter-after-file-follow nil
        treemacs-recenter-after-tag-follow  nil
        treemacs-show-hidden-files          t
        treemacs-silent-filewatch           nil
        treemacs-silent-refresh             nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-space-between-root-nodes   t
        treemacs-tag-follow-cleanup         t
        treemacs-tag-follow-delay           1.5
        treemacs-width                      35)
  ;; The default width and height of the icons is 22 pixels. If you are
  ;; using a Hi-DPI display, uncomment this to double the icon size.
  ;;(treemacs-resize-icons 44)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python3"))))
    (`(t . t)
     (treemacs-git-mode 'extended))
    (`(t . _)
     (treemacs-git-mode 'simple))))

(global-set-key (kbd "M-0") 'treemacs-select-window)
(global-set-key (kbd "C-x t 1") 'treemacs-delete-other-windows)
(global-set-key (kbd "C-x t t") 'treemacs)
(global-set-key (kbd "C-x t B")  'treemacs-bookmark)
(global-set-key (kbd "C-x t C-t") 'treemacs-find-file)
(global-set-key (kbd "C-x t M-t") 'treemacs-find-tag)

(require 'treemacs-projectile)

(require 'helm-xref)
(setq xref-show-xrefs-function 'helm-xref-show-xrefs)

(require 'elscreen)
(setq elscreen-display-tab nil)
(elscreen-start)

(require 'helm-elscreen)

(require 'sudo-edit)

(require 'bbdb)

(require 'helm-bbdb)

(provide 'base-extensions)
