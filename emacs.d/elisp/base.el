(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

;; Core settings
;; UTF-8 please
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)   ; pretty
(set-terminal-coding-system  'utf-8)   ; pretty
(set-keyboard-coding-system  'utf-8)   ; pretty
(set-selection-coding-system 'utf-8)   ; please
(prefer-coding-system        'utf-8)   ; with sugar on top
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Emacs customizations
(setq confirm-kill-emacs                  'y-or-n-p
      confirm-nonexistent-file-or-buffer  t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point                 t
      require-final-newline               t
      visible-bell                        nil
      ring-bell-function                  'ignore
      custom-file                         "~/.emacs.d/.custom.el"
      ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
      minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)

      ;; Disable non selected window highlight
      cursor-in-non-selected-windows     nil
      highlight-nonselected-windows      nil
      ;; PATH
      exec-path                          (append exec-path '("/usr/local/bin/"))
      indent-tabs-mode                   nil
      inhibit-startup-message            t
      fringes-outside-margins            t
      x-select-enable-clipboard          t
      use-package-always-ensure          t
      gc-cons-threshold                  100000000)

(load custom-file)

;; Bookmarks
(setq
 ;; persistent bookmarks
 bookmark-save-flag                      t
 bookmark-default-file              "~/workspace/document/bookmarks")

;; Backups enabled, use nil to disable
(setq
 history-length                     1000
 backup-inhibited                   nil
 make-backup-files                  t
 auto-save-default                  t
 auto-save-list-file-name           (concat temp-dir "/autosave")
 make-backup-files                  t
 create-lockfiles                   nil
 backup-directory-alist            `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t)))

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

;; Disable toolbar & menubar
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (  fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(show-paren-mode 1)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(desktop-save-mode 1)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t)

(add-to-list 'load-path (concat user-emacs-directory "elisp/misc"))

;; mail
;; ~/.authinfo.gpg
;; machine imap.gmail.com login <USER> password <APP-PASSWORD> port imaps
;; machine smtp.gmail.com login <USER> password <APP-PASSWORD> port 587

(defun use-gmail-config ()
  (interactive)
  (setq user-mail-address "elleryq92@gmail.com"
        user-full-name "Ellery Wang")
  (setq gnus-select-method
        '(nnimap "gmail"
	             (nnimap-address "imap.gmail.com")
	             (nnimap-server-port "imaps")
	             (nnimap-stream ssl)))
  (setq smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587
        gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"))

(defun use-qqmail-config ()
  (interactive)
  (setq user-mail-address "ellery-wang@qq.com"
        user-full-name "Ellery Wang")
  (setq gnus-select-method
        '(nnimap "qq"
	             (nnimap-address "imap.qq.com")
	             (nnimap-server-port "imaps")
	             (nnimap-stream ssl)))
  (setq smtpmail-smtp-server "smtp.qq.com"
        smtpmail-smtp-service 25
        gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"))

(use-gmail-config)
;; (use-qqmail-config)

(setq socks-noproxy '("127.0.0.1"))
(setq socks-server '("Default server" "127.0.0.1" 1080 5))
(setq url-gateway-method 'socks)

(setq browse-url-generic-program "google-chrome-stable")

(add-to-list 'load-path (concat user-emacs-directory "elisp/emacswiki"))

(provide 'base)
;;; base ends here
