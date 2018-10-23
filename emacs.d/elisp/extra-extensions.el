(require 'gif-screencast)

(define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
(define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop)

(require 'keycast)

(require 'helm-system-packages)

(require 'pdf-tools)
(pdf-tools-install)

(require 'emms)
(emms-all)
(emms-default-players)

(require 'emms-bilibili)

(require 'helm-youtube)
(setq request-curl-options (list "--preproxy" "socks5://127.0.0.1:1080"))
(setq helm-youtube-key "AIzaSyDz-ATMpi_vEsVD2dUDhwu4kh8XZa5UfcQ")

(require 'restclient)
;; (require 'restclient-helm)

(require 'restart-emacs)

(require 'pcap-mode)

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

(require 'plantuml-mode)
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(setq plantuml-jar-path "/opt/plantuml/plantuml.jar")

(require 'flycheck-plantuml)

(flycheck-plantuml-setup)
(add-hook 'plantuml-mode-hook #'flycheck-mode)

;; from emacswiki
(require 'dired+)

(provide 'extra-extensions)
