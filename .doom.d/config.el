;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font "Rec Mono Duotone:pixelsize=18:weight=regular:slant=normal:width=normal:spacing=100:scalable=true")
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam")

(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
         :target (file+head "uncategorized/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %U\n#+filetags: Uncategorized\n\n#+hugo_base_dir: ../../hugo\n\n\n")
         :unnarrowed t)
        ("p" "project" plain "%?"
         :target (file+head "projects/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %U\n#+filetags: Project\n\n#+hugo_base_dir: ../../hugo\n#+hugo_section: projects\n\n\n")
         :unnarrowed t)
        ("i" "item" plain "\n\n* Description\n\n%?\n\n* Note\n"
         :target (file+head "items/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %U\n#+primary_url: \n#+item_tag: \n#+owned_amount: \n#+price: \n#+filetags: Item\n\n#+hugo_base_dir: ../../hugo\n#+hugo_section: items\n\n\n")
         :unnarrowed t)
        ("R" "reading" plain "%?"
         :target (file+head "readings/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %U\n#+primary_url: \n#+reading_type: blog\n#+filetags: Reading\n\n#+hugo_base_dir: ../../hugo\n#+hugo_section: readings\n\n\n")
         :unnarrowed t)
        ("r" "random" plain "%?"
         :target (file+head "randoms/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %U\n#+filetags: Random\n\n#+hugo_base_dir: ../../hugo\n#+hugo_section: randoms\n\n\n")
         :unnarrowed t)
        )
      )

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(after! company
  (setq company-idle-delay 0.05
        company-minimum-prefix-length 2
        company-box-doc-delay 0.1
        company-tooltip-maximum-width 50)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(setq display-line-numbers-type 'relative)

(setq doom-theme 'doom-one)

(after! centaur-tabs
  (setq centaur-tabs-height 24))
