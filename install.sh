#!/bin/bash

copy_folders() {
  source_dir="$1"
  destination_dir="$2"


  folders=("waybar" "hyprlandscripts" "hypr" "ranger" "cava" "fish" "kitty" "dunst")


  for folder in "${folders[@]}"; do
    # Hedef klasörün içinde a adında bir klasör var mı kontrol et
    if [ -d "$destination_dir/$folder" ]; then
      # Eğer aynı isimde bir klasör varsa, kaynak klasördeki dosyaları hedef klasörün aynı adlı klasörüne kopyala
      cp -r "$source_dir/$folder"/* "$destination_dir/$folder"
    else
      # Aynı isimde bir klasör yoksa, kaynak klasörü hedef klasöre kopyala
      cp -r "$source_dir/$folder" "$destination_dir"
    fi
  done


  echo "Files have been installed to $destination_dir. ✅"
}


source_folder="$HOME/kyprland/dotfiles"
destination_folder="$HOME/.config"

copy_folders "$source_folder" "$destination_folder"
