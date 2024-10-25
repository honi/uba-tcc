#!/bin/sh

cat prácticas/p01/*.md | md-to-pdf --pdf-options '{"margin":"1cm"}' > machetes/p01.pdf
cat prácticas/p02/tipos-finitos/*.md | md-to-pdf --pdf-options '{"margin":"1cm","landscape":true}' --css "pre {break-inside: avoid;}" > machetes/p02-tipos-finitos.pdf
cat prácticas/p02/tipos-infinitos/*.md | md-to-pdf --pdf-options '{"margin":"1cm"}' > machetes/p02-tipos-infinitos.pdf
cat prácticas/p04/*.md | md-to-pdf --pdf-options '{"margin":"1cm"}' > machetes/p04.pdf

rm -rf /tmp/p03.md
touch /tmp/p03.md

for file in prácticas/p03/src/*.ml; do
    echo "# $(echo $(basename $file))\n\n\`\`\`ocaml\n" >> /tmp/p03.md
    cat $file >> /tmp/p03.md
    echo "\n\`\`\`\n" >> /tmp/p03.md
done

cat /tmp/p03.md | md-to-pdf --pdf-options '{"margin":"1cm"}' > machetes/p03.pdf
