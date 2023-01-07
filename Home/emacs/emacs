(require 'package)
(require 'multiple-cursors)
(require 'neotree)
(require 'powerline)
(require 'drag-stuff)
(require 'linum-relative)
(require 'whitespace)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(drag-stuff multiple-cursors powerline nord-theme markdown-preview-mode markdown-mode neotree linum-relative dracula-theme racket-mode wakatime-mode))
 '(wakatime-api-key "waka_19cdfb73-3c0f-475d-a6f0-485d1809e191")
 '(wakatime-cli-path "~/.wakatime/wakatime-cli"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'dracula)

(set-face-attribute 'default nil :font "Fira Code")
(set-frame-font "Fira Code" nil t)

(global-visual-line-mode)
(global-linum-mode)
(global-set-key [f8] 'neotree-toggle)
(global-hl-line-mode)
(global-wakatime-mode)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd"<escape>") 'keyboard-escape-quit)

(drag-stuff-global-mode)
(drag-stuff-define-keys)

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'visual-line-mode)

(setq eshell-scroll-to-bottom-on-input t)
(setq warning-minimum-level :emergency)
(setq viisible-bell t)
(setq ring-bell-function 'ignore)
(setq default-tab-width 2)
(setq initial-frame-alist
     '((width . 160)
       (height . 50)))
;(setq-default frame-title-format '("%f [%m]"))
(setq frame-title-format
  (concat "%b - emacs@" (system-name)))

(tool-bar-mode -1)
(scroll-bar-mode -1)

(powerline-default-theme)
(windmove-default-keybindings)
