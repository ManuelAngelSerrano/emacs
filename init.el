;; MELPA
(require 'package)
; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents));; para usar el sistema use-package


(require 'use-package)
(setq use-package-always-ensure t) ;; Si no existe el paquete lo descarga

;;MacOsx keyboard config. Comment in Windows / Linux
(setq default-input-method "MacOSX")
;;(setq mac-option-key-is-meta t)
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
;; (setq mac-command-modifier 'meta)
(setq mac-command-modifier 'super)
(setq mac-right-option-modifier nil)
(setq x-select-enable-clipboard t)
(setq mac-pass-command-to-system t)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; Visual Bell - Avoid Beep
(setq visible-bell t)

;; Tema
;;;;;;;;;;;;;;;
(load-theme 'monokai t) ;;t for avoid confirmation

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Menlo" :foundry "nil" :slant normal :weight normal :height 160 :width normal)))))

(set-face-attribute 'default nil :font  "Menlo-18" )
(set-frame-font   "Menlo-18" nil t)

;; Word Wrap
(global-visual-line-mode 1)

;; Display line numbers
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode 1)

;; For auto-completion
(setq shift-select-mode t)
; (add-hook 'after-init-hook 'global-company-mode)

;; markdown-mode
;;;;;;;;;;;;;;;;
(add-hook 'markdown-mode-hook
        (lambda ()
            (when buffer-file-name
              (add-hook 'after-save-hook
                        'check-parens
                        nil t))))

;;Markdown-mode comillas
(add-hook 'markdown-mode-hook (lambda () (modify-syntax-entry ?\" "\"" markdown-mode-syntax-table)))

;; Keybinds
;;;;;;;;;;;
(global-set-key (kbd "C-<SPC>") 'set-mark-command) ; Ctrl-SPC Set Mark
(global-set-key (kbd "C-q") 'save-buffers-kill-emacs) ; Ctrl-Q Quit
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs) ; Cmd-Q Quit
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-z") 'undo) ; Ctrl-Z Undo
(global-set-key (kbd "C-S-Z") 'redo) ; Ctrl-Shift-Z Redo
(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)
;; Set super-h and Alt-h to hide window
(global-set-key (kbd "S-h") 'ns-do-hide-emacs)
(global-set-key (kbd "M-h") 'ns-do-hide-emacs)

;;Packages
;;;;;;;;;;

(use-package ido-vertical-mode
  :config
  (ido-mode 1)
  (ido-vertical-mode 1))

(use-package dirtree)
(use-package lorem-ipsum)
(use-package clojure-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package yasnippet
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/"))
  :config
  (yas-global-mode 1)
)

(use-package neotree
  :init
  (setq neo-smart-open t)
  :bind
  ([f8] . neotree-toggle)
  :config
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))

(use-package emmet-mode
  :init
  (setq emmet-move-cursor-between-quotes t)
  :hook ((sgml-mode . emmet-mode)
         (css-mode . emmet-mode)))

;;tabuladores... No se si funciona
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 5 120 5))

(use-package company
  :hook (after-init . global-company-mode))

(use-package smex
  :config
  (smex-initialize))

(use-package markdown-mode)

(use-package pandoc-mode
  :hook (markdown-mode . pandoc-mode))

;; LaTeX / AUCTeX
(use-package auctex
  :defer t
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook ((LaTeX-mode . visual-line-mode)
         (LaTeX-mode . flyspell-mode)
         (LaTeX-mode . LaTeX-math-mode)
         (LaTeX-mode . turn-on-reftex))
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-PDF-mode t)
  (reftex-plug-into-AUCTeX t)
  :config
  (setq TeX-view-program-selection
        '((output-pdf "open"))))


(use-package elm-mode
  :config
  (setq elm-mode-hook '(elm-indent-simple-mode)))

;;;;;;;;;;;;;;;;;;;;

;; EVIL 
;;;;;;;

(use-package evil
  :ensure t
  :init
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo))

;; evil Redo con C-r (substituye a redo+)
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode 1))

(use-package evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(use-package smartparens
  :hook ((prog-mode text-mode markdown-mode) . smartparens-mode)
  :config
  (require 'smartparens-config))

(use-package evil-smartparens
  :after (evil smartparens)
  :hook (smartparens-enabled-hook . evil-smartparens-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :after evil
  :commands (evilnc-comment-or-uncomment-lines evilnc-default-hotkeys)
  :config
  ;; (evilnc-default-hotkeys)
  )
; 
;;extend % use to tags
(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.15)
  :config
  (key-chord-mode 1))

(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(define-key evil-normal-state-map (kbd "U") 'evil-redo) ;U is also redo in evil-mode

;;; evil <esc> quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; Keybinds
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up) ; Para que Ctrl-U sea scroll up en evil mode
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd "<RET>") 'avy-goto-word-0-below) 
(define-key evil-visual-state-map (kbd "<RET>") 'avy-goto-word-0-below) 
(define-key evil-normal-state-map (kbd ", w") 'avy-goto-word-0-below)
(define-key evil-visual-state-map (kbd ", w") 'avy-goto-word-0-below)
(define-key evil-normal-state-map (kbd "s-7") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd "s-7") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd "C-7") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd "C-7") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd ", c") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ", c") 'evilnc-comment-or-uncomment-lines)
(key-chord-define evil-normal-state-map ",." 'evil-ex)
(key-chord-define evil-visual-state-map ",." 'evil-ex)

(define-key evil-normal-state-map (kbd "g n") 'switch-to-buffer)
(define-key evil-visual-state-map (kbd "g n") 'switch-to-buffer)
(define-key evil-normal-state-map (kbd "g p") 'switch-to-buffer)
(define-key evil-visual-state-map (kbd "g p") 'switch-to-buffer)

(define-key evil-normal-state-map (kbd "g h") 'evil-beginning-of-line)
(define-key evil-visual-state-map (kbd "g h") 'evil-beginning-of-line)
(define-key evil-normal-state-map (kbd "g l") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "g l") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "g e") 'end-of-buffer)
(define-key evil-visual-state-map (kbd "g e") 'end-of-buffer)
(define-key evil-normal-state-map (kbd ", r") 'eval-buffer)

(use-package avy ;easymotion
  :init
  (key-chord-define evil-normal-state-map "gw" 'avy-goto-word-0-below))

;; defino funciones para el evil-leader
;; para alternar entre relativos y absolutos
(defun my/toggle-relative-line-numbers ()
  (interactive)
  (setq display-line-numbers
        (if (eq display-line-numbers 'relative)
            t
          'relative))
  (redraw-display))

;; para alternar el word-wrap
(defun my/toggle-word-wrap ()
  "Alterna el word wrap visual."
  (interactive)
  (visual-line-mode 'toggle))

;; set custom evil-leader keybinds
(evil-leader/set-key
  "c" 'evilnc-comment-or-uncomment-lines
  "r" 'eval-buffer
  "f"  'ido-find-file
  "t"  'ido-find-file
  "e"  'ido-find-file
  "p"  'ido-find-file
  "b"  'switch-to-buffer
  "w"  'switch-to-buffer
  "s"  'save-buffer
  "q"  'kill-buffer
  ;; ",q" 'kill-emacs ;q!
  "Q" 'kill-emacs ;q!
  "max" 'toggle-frame-maximized
  "min" 'toggle-frame-maximized
  "mf" 'toggle-frame-fullscreen
  "v" #'my/toggle-word-wrap ;;'toggle-word-wrap
  "z" #'my/toggle-word-wrap ;;'toggle-word-wrap
  "n" #'my/toggle-relative-line-numbers
  "x" 'smex
  "."  'evil-ex
  ","  'evil-ex
  )



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(if (window-system) (set-frame-size (selected-frame) 140 80)) ; resize a 140 col y 80 filas
