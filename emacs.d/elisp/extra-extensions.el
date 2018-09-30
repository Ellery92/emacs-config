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

(provide 'extra-extensions)
