{ config, pkgs, ... }:
{
        programs.fish = {
                enable = true;
                interactiveShellInit = ''
                        if status is-interactive
                                set EDITOR /usr/bin/nvim
                                        end

                                        fish_hybrid_key_bindings

                                        if type -q fortune
                                                set -U fish_greeting (fortune)
                                        else
                                                set -U fish_greeting ""
                                                        end

                                                        set XDG_PICTURES_DIR $HOME/Pictures
                                                        set XDG_CONFIG_DIRS "$HOME/.config"
                                                        set -x QT_QPA_PLATFORMTHEME qt5ct

                                                        fish_add_path $HOME/.cargo/bin
                                                        fish_add_path $HOME/.local/bin

                                                        if test -f "$HOME/.cargo/env.fish"
                                                                source "$HOME/.cargo/env.fish"
                                                                        end
                                                                        '';
                plugins = [
                { name = "done"; src = pkgs.fishPlugins.done.src;}
                { name = "transient-fish"; src = pkgs.fishPlugins.transient-fish.src;}
                { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src;}
                { name = "puffer"; src = pkgs.fishPlugins.puffer.src;}
                { name = "pisces"; src = pkgs.fishPlugins.pisces.src;}
                { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src;}
                { name = "gruvbox"; src = pkgs.fishPlugins.gruvbox.src;}
                { name = "z"; src = pkgs.fishPlugins.z.src;}
                ];
        };
}
