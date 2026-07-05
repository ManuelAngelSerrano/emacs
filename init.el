;; MELPA
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; para usar el sistema use-package
(require 'use-package-ensure)
(setq use-package-always-ensure t) ;; Si ni existe el paquete lo descarga

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
(load-theme 'tango-dark)
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
(add-hook 'after-init-hook 'global-company-mode)

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

;;pandoc-mode
;;;;;;;;;;;;;;
(add-hook 'markdown-mode-hook 'pandoc-mode)

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
;; (global-set-key (kbd "C-k") 'kill-whole-line) ;jj Ctrl-K Kill
;; (global-set-key (kbd "C-<tab>") 'other-window) ; Ctrl-TAB Next Window Buffer
;; (define-key isearch-mode-map (kbd "<right>") 'isearch-repeat-forward) ; -> Search Forward
;; (define-key isearch-mode-map (kbd "<left>") 'isearch-repeat-backward) ; <- Search Backward
;; (global-set-key (kbd "C-'") 'comment-dwim) ; Ctrl-ç Comment



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
  :hook ('prog-mode-hook . 'rainbow-delimiters-mode))

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
  :hook
  ('sgml-mode-hook . 'emmet-mode) ;; Auto-start on any markup modes
  ('css-mode-hook .  'emmet-mode)) ;; enable Emmet's css abbreviation.


(use-package smartparens
  :ensure smartparens
  :init
  (setq smartparens-global-mode t)
  :hook
  (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  ('smartparens-enabled-hook . 'evil-smartparens-mode);; evil-smartparens will be enabled whenever smartparens is enabled
  :config
  (require 'smartparens-config))



;;tabuladores... No se si funciona
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 5 120 5))

;;auctex
;;;;;;;;
(load "auctex.el" nil t t)
(setq TeX-PDF-mode t)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(cua-enable-cua-keys nil)
;;  '(cua-mode t nil (cua-base))
;;  '(custom-safe-themes
;;    '("f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c"
;;      default))
;;  '(delete-selection-mode t)
;;  '(evil-space-mode t)
;;  '(org-CUA-compatible nil)
;;  '(org-replace-disputed-keys t)
;;  '(package-selected-packages nil)
;;  '(recentf-mode t)
;;  '(shift-select-mode nil)
;;  '(show-paren-mode t))


;;;;;;;;;;;;;;;;;;;;


;; EVIL ;;
;;;;;;;;;;
;; (setq evil-want-C-u-scroll t)

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

(use-package evil-smartparens
  :ensure t
  :hook
  ('smartparens-enabled-hook . 'evil-smartparens-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package telephone-line
  :init
  (telephone-line-mode 1))

;; evil-nerd-commenter
(evilnc-default-hotkeys)

;;extend % use to tags
(global-evil-matchit-mode 1)


(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.15)
  :config
  (key-chord-mode 1))

(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;; (key-chord-define evil-normal-state-map "ZZ" 'evil-save-and-close)

(define-key evil-normal-state-map (kbd "U") 'evil-redo) ;U is also redo in evil-mode

;;; evil <esc> quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; ,. -> <esc>
;; (key-chord-define evil-normal-state-map ",," 'evil-force-normal-state)
;; (key-chord-define evil-visual-state-map ",." 'evil-change-to-previous-state)
;; (key-chord-define evil-insert-state-map ",." 'evil-normal-state)
;; (key-chord-define evil-replace-state-map ",." 'evil-normal-state)
;; (key-chord-define evil-visual-state-map ",." 'keyboard-quit)
;; (key-chord-define minibuffer-local-map ",." 'minibuffer-keyboard-quit)
;; (key-chord-define minibuffer-local-ns-map ",." 'minibuffer-keyboard-quit)
;; (key-chord-define minibuffer-local-completion-map ",." 'minibuffer-keyboard-quit)
;; (key-chord-define minibuffer-local-must-match-map ",." 'minibuffer-keyboard-quit)
;; (key-chord-define minibuffer-local-isearch-map ",." 'minibuffer-keyboard-quit)

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
;; (define-key evil-normal-state-map (kbd ", c") 'evilnc-comment-or-uncomment-lines)
;; (define-key evil-visual-state-map (kbd ", c") 'evilnc-comment-or-uncomment-lines)
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

;; evil-space: Repeat search with <SPC> and <S-SPC>
;; (require 'evil-space)
;; (evil-space-mode)

(use-package avy ;easymotion
  :init
  (key-chord-define evil-normal-state-map "gw" 'avy-goto-word-0-below))

;; (use-package general)
;; (general-evil-setup)
;; (general-nmap
;;  :prefix "SPC"
;;  "w": 'save-buffer
;;  "q": 'kill-buffer)

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
  ;; ",f" 'avy-goto-char
  ;; ",F" 'avy-goto-char
  ;; ",t" 'avy-goto-char
  ;; ",T" 'avy-goto-char
  ;; ",w" 'avy-goto-word-0-below
  ;; "<spc>w" 'avy-goto-word-0-below
  ;; ",b" 'avy-goto-word-0-above
  ;; ",j" 'avy-goto-line-below
  ;; ",k" 'avy-goto-line-above
  ;; "s"  'evil-search-forward
  ;; "S"  'evil-search-backward
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
  ",q" 'kill-emacs ;q!
  ;; "zz" 'save-buffers-kill-emacs
  "max" 'toggle-frame-maximized
  "min" 'toggle-frame-maximized
  "mf" 'toggle-frame-fullscreen
  "v" #'my/toggle-word-wrap ;;'toggle-word-wrap
  "z" #'my/toggle-word-wrap ;;'toggle-word-wrap
  ;; "n" '(lambda ()(interactive) (linum-mode) (linum-relative-toggle))
  "n" #'my/toggle-relative-line-numbers
  "x" 'smex
  "."  'evil-ex
  )



;; (evil-set-undo-system 'undo-redo)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auctex cider coffee-mode company dirtree emmet-mode evil-avy
            evil-easymotion evil-leader evil-matchit
            evil-nerd-commenter evil-smartparens evil-space
            evil-surround general haml-mode haskell-mode
            ido-vertical-mode key-chord linum-relative lorem-ipsum
            markdown-mode+ monokai-theme neotree pandoc-mode
           powerline-evil projectile rainbow-delimiters redo+ smex
            telephone-line undo-tree yasnippet)))
(if (window-system) (set-frame-size (selected-frame) 140 80)) ; resize a 140 col y 80 filas
