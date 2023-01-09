(require 'package)
(require 'multiple-cursors)
(require 'neotree)
(require 'powerline)
(require 'drag-stuff)
(require 'linum-relative)
(require 'whitespace)
(require 'all-the-icons)
(require 'dashboard)
(require 'page-break-lines)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("776c1ab52648f98893a2aa35af2afc43b8c11dd3194a052e0b2502acca02bfce" "171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" default))
 '(inhibit-startup-screen t)
 '(neo-theme 'icons)
 '(package-selected-packages
   '(page-break-lines dashboard all-the-icons ubuntu-theme atom-one-dark-theme drag-stuff multiple-cursors powerline nord-theme markdown-preview-mode markdown-mode neotree linum-relative dracula-theme racket-mode wakatime-mode))
 '(powerline-default-separator 'bar)
 '(powerline-gui-use-vcs-glyph t)
 '(wakatime-api-key "please use your api key")
 '(wakatime-cli-path "~/.wakatime/wakatime-cli"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#282a36" :foreground "#565761" :slant normal)))))

(load-theme 'nord)

(set-face-attribute 'default nil :font "Fira Code")
(set-frame-font "Fira Code" nil t)

(global-page-break-lines-mode)
(global-visual-line-mode)
(global-linum-mode)
(global-set-key [f8] 'neotree-toggle)
(global-hl-line-mode)
(global-wakatime-mode)
(global-whitespace-mode)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd"<escape>") 'keyboard-escape-quit)

(drag-stuff-global-mode)
(drag-stuff-define-keys)

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'visual-line-mode)

(setq dashboard-banner-logo-title "Hi, What We Do Today ?")
(setq dashboard-startup-banner "/home/adivin/Pictures/Logo/emacs-dashboard.png")
;(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
;(setq dashboard-set-navigator t)
(setq eshell-scroll-to-bottom-on-input t)
(setq warning-minimum-level :emergency)
(setq viisible-bell t)
(setq ring-bell-function 'ignore)
(setq default-tab-width 2)
(setq powerline-arrow-shape 'curve)
;(setq initial-frame-alist
;    '((width . 160)
;       (height . 50)))
;(setq-default frame-title-format '("%f [%m]"))
(setq frame-title-format
  (concat "%b - emacs@" (system-name)))
(setq whitespace-style '(face spaces tabs empty trailing))
(setq make-backup-file nil)
(setq-default tab-always-indent 'complete)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(dashboard-setup-startup-hook)
(powerline-default-theme)
(windmove-default-keybindings)

(fido-vertical-mode t)
