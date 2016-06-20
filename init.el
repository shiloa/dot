;; marmalade repo support
(require 'package)

;;add-to-list 'package-archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
                         ;;("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)

;; load package archives
(when (not package-archive-contents)
  (package-refresh-contents))

;; list package deps
(defvar my-packages '(
                      ;; editor
                      starter-kit
                      evil
                      move-text
                      pallet
                      evil-leader
                      autopair
                      smart-tab
                      surround
                      company
                      helm
                      projectile
                      helm-projectile

                      ;; syntax support
                      color-theme-approximate
                      zenburn-theme
                      web-mode
                      flycheck
                      editorconfig
                      sass-mode
                      zencoding-mode

                      ;; languages
                      python-mode
                      go-mode
                      rust-mode
                      clojure-mode

                      ;; auto-complete
                      ;; yaml-mode
                      ))

;; make sure packages are installed
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; enable modes
(evil-mode 1)
(global-surround-mode)
(color-theme-approximate-on)
(global-flycheck-mode)
(autopair-global-mode)
(global-linum-mode)
(require 'editorconfig)

;; load color theme
(load-theme 'zenburn t)
;;(load-theme 'misterioso t)

;; set default font on windows
;; (set-face-attribute 'default nil :font "Consolas 12")

;; set default directory in Windows
;; (cd "C:/")

;; evil configuration
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

(evil-leader/set-key
  ;; <leader>-t locates file in folder
  "f" 'helm-projectile
  ;; list buffers
  "z" 'helm-buffers-list
  ;; comment/uncomment
  "c" 'comment-or-uncomment-region
  ;; Go to previous buffer
  "," 'previous-buffer)
  
;; projectile config
(projectile-global-mode)

;; enable company mode
(add-hook 'after-init-hook 'global-company-mode)

;; enable zencoding on markup files
(add-hook 'sgml-mode-hook 'zencoding-mode) 

;; enable smart-tab
(require 'smart-tab)
(global-smart-tab-mode)

;; flex matching
;;(require 'flx-ido)
;;(ido-mode 1)
;;(ido-everywhere 1)
;;(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; company mode config
(add-hook 'after-init-hook 'global-company-mode)

;; key binding to move text
(global-set-key (kbd "C-k") 'move-text-up)
(global-set-key (kbd "C-j") 'move-text-down)

;; web mode config
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; allow copying to clipboard
(defun paste-from-system-clipboard ()
  (shell-command-to-string "pbpaste"))

(defun copy-to-system-cliboard (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'copy-to-system-cliboard)
(setq interprogram-paste-function 'paste-from-system-clipboard)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes (quote ("1e194b1010c026b1401146e24a85e4b7c545276845fc38b8c4b371c8338172ad" "8f7e1668dd3a097964e6016c26d36822ab2e48fc3e9a3a2e2634224a5ca728c8" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" default)))
 '(fci-rule-color "#383838")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
