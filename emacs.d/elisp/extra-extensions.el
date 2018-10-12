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
  (setq request-curl-options (list "--preproxy" "socks5://127.0.0.1:1080"))
  (setq helm-youtube-key "AIzaSyDz-ATMpi_vEsVD2dUDhwu4kh8XZa5UfcQ"))

(use-package restclient)
;; (use-package restclient-helm)

(use-package restart-emacs)

(use-package pcap-mode)

(provide 'extra-extensions)
