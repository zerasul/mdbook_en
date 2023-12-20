docker  run --rm -v $PWD:/data pandoc/core -f gfm -t epub3 1introduction/thanks.md 1introduction/introduction.md 2history/history.md 3Architecture/architecture.md 4SGDK/sgdk.md 5env-config/env-config.md 6helloworld/helloworld.md 7controls/controls.md 8backgrounds/backgrounds.md 9Sprites/sprites.md 10physics/pyshics.md 11Paletas/paletas.md 12TileSets/TileSets.md 13Scroll/scroll.md 14sonido/sonido.md 15SRAM/sram.md 16Debug/debug.md --toc --toc-depth=2 --metadata-file=title.txt --css=styles.css -o mdbook_en.epub