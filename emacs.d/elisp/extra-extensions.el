(use-package gif-screencast
  :config
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))

(use-package keycast)

(use-package helm-system-packages)

(use-package pdf-tools
  :init (pdf-tools-install)
  :mode ("\\.pdf" . pdf-view-mode))

(use-package emms
  :config
  (emms-all)
  (emms-default-players))

(use-package emms-bilibili)

(use-package helm-youtube
  :config
  (setq helm-youtube-key "API AIzaSyDz-ATMpi_vEsVD2dUDhwu4kh8XZa5UfcQ"))

(unless (package-installed-p 'langtool)
  (package-install 'langtool))
(setq langtool-java-classpath "/usr/share/languagetool:/usr/share/java/languagetool/*")

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g' .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))

(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)
(require 'langtool)

(use-package plantuml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  (setq plantuml-jar-path "/opt/plantuml/plantuml.jar"))

(use-package flycheck-plantuml
  :init
  (flycheck-plantuml-setup)
  (flycheck-mode))

;; from emacswiki
(add-to-list 'load-path (concat user-emacs-directory "elisp/emacswiki"))
(require 'dired+)

(provide 'extra-extensions)
